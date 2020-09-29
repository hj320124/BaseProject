//
//  PPNetWorkAgent.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/15.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPNetworkAgent.h"
#import "PPNetworkPrivate.h"
#import "PPNetworkConfig.h"
#import <pthread/pthread.h>

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

#define PPKNetworkIncompleteDownloadFolderName @"PPIncomplete"

@interface PPNetworkAgent (){
    pthread_mutex_t _lock;
    dispatch_queue_t _processingQueue;
}
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) AFJSONResponseSerializer *jsonResponseSerializer;

@property (nonatomic, strong) PPNetworkConfig *config;

@property (nonatomic, strong) AFXMLParserResponseSerializer *xmlParserResponseSerialzier;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, PPBaseRequest *> *requestsRecord;

@property (nonatomic, strong) NSIndexSet *allStatusCodes;

@end

@implementation PPNetworkAgent

//单例
+ (PPNetworkAgent *)sharedAgent {
    static PPNetworkAgent *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _config = [PPNetworkConfig sharedConfig];
        _requestsRecord = [NSMutableDictionary dictionary];
        _allStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
        pthread_mutex_init(&(_lock), NULL);
        _processingQueue = dispatch_queue_create("com.ppm.networkagent.processing", DISPATCH_QUEUE_CONCURRENT);
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _manager.securityPolicy = _config.securityPolicy;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableStatusCodes = self.allStatusCodes;
        _manager.completionQueue = _processingQueue;
    }
    return self;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        _jsonResponseSerializer.acceptableStatusCodes = _allStatusCodes;
        _jsonResponseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/javascript", nil];
    }
    return _jsonResponseSerializer;
}

- (AFXMLParserResponseSerializer *)xmlParserResponseSerialzier {
    if (!_xmlParserResponseSerialzier) {
        _xmlParserResponseSerialzier = [AFXMLParserResponseSerializer serializer];
        _xmlParserResponseSerialzier.acceptableStatusCodes = _allStatusCodes;
    }
    return _xmlParserResponseSerialzier;
}

#pragma mark -

- (NSString *)buildRequestUrl:(PPBaseRequest *)request {
    NSParameterAssert(request != nil);
    
    NSString *detailUrl = [request requestUrl];
    NSURL *temp = [NSURL URLWithString:detailUrl];
    // If detailUrl is valid URL
    if (temp && temp.host && temp.scheme) {
        return detailUrl;
    }
    // Filter URL if needed
    NSArray *filters = [self.config urlFilters];
    for (id<PPUrlFilterProtocol> f in filters) {
        detailUrl = [f filterUrl:detailUrl withRequest:request];
    }
    
    NSString *baseUrl;
    if ([request useCDN]) {
        if ([request cdnUrl].length > 0) {
            baseUrl = [request cdnUrl];
        } else {
            baseUrl = [self.config cdnUrl];
        }
    } else {
        if ([request baseUrl].length > 0) {
            baseUrl = [request baseUrl];
        } else {
            baseUrl = [self.config baseUrl];
        }
    }
    // URL slash compability
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    if (baseUrl.length > 0 && ![baseUrl hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    return [NSURL URLWithString:detailUrl relativeToURL:url].absoluteString;
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(PPBaseRequest *)request {
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (request.requestSerializerType == PPRequestSerializerTypeHTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == PPRequestSerializerTypeJSON) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //超时
    requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    requestSerializer.allowsCellularAccess = [request allowsCellularAccess];
    

    //设置请求缓存策略
    requestSerializer.cachePolicy = request.cachePolicy;
    
    // 如果api需要用户名和密码
    NSArray<NSString *> *authorizationHeaderFieldArray = [request requestAuthorizationHeaderFieldArray];
    if (authorizationHeaderFieldArray != nil) {
        [requestSerializer setAuthorizationHeaderFieldWithUsername:authorizationHeaderFieldArray.firstObject
                                                          password:authorizationHeaderFieldArray.lastObject];
    }
    //自定义http头
    NSDictionary<NSString *, NSString *> *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    return requestSerializer;
}


- (NSURLSessionTask *)sessionTaskForRequest:(PPBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    PPRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = request.requestArgument;
    AFConstructingBlock constructingBlock = [request constructingBodyBlock];
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:request];
    switch (method) {
        case PPRequestMethodGET:
            if (request.resumableDownloadPath) {
                return [self downloadTaskWithDownloadPath:request.resumableDownloadPath requestSerializer:requestSerializer URLString:url parameters:param progress:request.resumeDownloadProgressBlock error:error];
            } else {
                return [self dataTaskWithHTTPMethod:@"GET" requestSerializer:requestSerializer URLString:url parameters:param error:error];
            }
        case PPRequestMethodPOST:
            return [self dataTaskWithHTTPMethod:@"POST" requestSerializer:requestSerializer URLString:url parameters:param constructingBodyWithBlock:constructingBlock error:error];
        case PPRequestMethodHEAD:
            return [self dataTaskWithHTTPMethod:@"HEAD" requestSerializer:requestSerializer URLString:url parameters:param error:error];
        case PPRequestMethodPUT:
            return [self dataTaskWithHTTPMethod:@"PUT" requestSerializer:requestSerializer URLString:url parameters:param error:error];
        case PPRequestMethodDELETE:
            return [self dataTaskWithHTTPMethod:@"DELETE" requestSerializer:requestSerializer URLString:url parameters:param error:error];
        case PPRequestMethodPATCH:
            return [self dataTaskWithHTTPMethod:@"PATCH" requestSerializer:requestSerializer URLString:url parameters:param error:error];
    }
}

- (void)addRequest:(PPBaseRequest *)request {
    NSParameterAssert(request != nil);
    
    NSError * __autoreleasing requestSerializationError = nil;
    
    NSURLRequest *customUrlRequest= [request buildCustomUrlRequest];
    if (customUrlRequest) {
        __block NSURLSessionDataTask *dataTask = nil;
        dataTask = [self.manager dataTaskWithRequest:customUrlRequest uploadProgress:request.upLoadBlock downloadProgress:request.resumeDownloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [self handleRequestResult:dataTask responseObject:responseObject error:error];
        }];
        request.requestTask = dataTask;
    } else {
        request.requestTask = [self sessionTaskForRequest:request error:&requestSerializationError];
    }
    
    if (requestSerializationError) {
        [self requestDidFailWithRequest:request error:requestSerializationError];
        return;
    }
    
    NSAssert(request.requestTask != nil, @"requestTask should not be nil");
    
    // Set request task priority
    // !!Available on iOS 8 +
    if ([request.requestTask respondsToSelector:@selector(priority)]) {
        switch (request.requestPriority) {
            case PPRequestPriorityHigh:
                if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityHigh;
                } else {
                    // Fallback on earlier versions
                }if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityHigh;
                } else {
                    // Fallback on earlier versions
                }
                break;
            case PPRequestPriorityLow:
                if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityLow;
                } else {
                    // Fallback on earlier versions
                }if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityLow;
                } else {
                    // Fallback on earlier versions
                }
                break;
            case PPRequestPriorityDefault:
                /*!!fall through*/
            default:
                if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityDefault;
                } else {
                    // Fallback on earlier versions
                }if (@available(iOS 8.0, *)) {
                    request.requestTask.priority = NSURLSessionTaskPriorityDefault;
                } else {
                    // Fallback on earlier versions
                }
                break;
        }
    }
    
    // Retain request
    PPLog(@"Add request: %@", NSStringFromClass([request class]));
    [self addRequestToRecord:request];
    [request.requestTask resume];
}

- (void)cancelRequest:(PPBaseRequest *)request {
    NSParameterAssert(request != nil);
    
    if (request.resumableDownloadPath) {
        NSURLSessionDownloadTask *requestTask = (NSURLSessionDownloadTask *)request.requestTask;
        [requestTask cancelByProducingResumeData:^(NSData *resumeData) {
            NSURL *localUrl = [self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath];
            [resumeData writeToURL:localUrl atomically:YES];
        }];
    } else {
        [request.requestTask cancel];
    }
    
    [self removeRequestFromRecord:request];
    [request clearCompletionBlock];
}

- (void)cancelAllRequests {
    Lock();
    NSArray *allKeys = [self.requestsRecord allKeys];
    Unlock();
    if (allKeys && allKeys.count > 0) {
        NSArray *copiedKeys = [allKeys copy];
        for (NSNumber *key in copiedKeys) {
            Lock();
            PPBaseRequest *request = self.requestsRecord[key];
            Unlock();
            // 使用非递归锁，不能锁住stop函数，否则会发生死锁
            [request stop];
        }
    }
}

- (BOOL)validateResult:(PPBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    BOOL result = [request statusCodeValidator];
    if (!result) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestValidationErrorDomain code:PPRequestValidationErrorInvalidStatusCode userInfo:@{NSLocalizedDescriptionKey:@"Invalid status code"}];
        }
        return result;
    }
    id json = [request responseJSONObject];
    id validator = [request jsonValidator];
    if (json && validator) {
        result = [PPNetworkUtils validateJSON:json withValidator:validator];
        if (!result) {
            if (error) {
                *error = [NSError errorWithDomain:PPRequestValidationErrorDomain code:PPRequestValidationErrorInvalidJSONFormat userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON format"}];
            }
            return result;
        }
    }
    return YES;
}

- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    Lock();
    PPBaseRequest *request = self.requestsRecord[@(task.taskIdentifier)];
    Unlock();
    
    //当请求被取消并从记录中删除时，基础
    // AFNetworking故障回调仍将启动，导致请求为nil。
    //在这里，我们选择完全忽略已取消的任务。
    if (!request) {
        return;
    }
    
    PPLog(@"Finished Request: %@", NSStringFromClass([request class]));
    
    NSError * __autoreleasing serializationError = nil;
    NSError * __autoreleasing validationError = nil;
    
    NSError *requestError = nil;
    BOOL succeed = NO;
    
    request.responseObject = responseObject;
    if ([request.responseObject isKindOfClass:[NSData class]]) {
        request.responseData = responseObject;
        request.responseString = [[NSString alloc] initWithData:responseObject encoding:[PPNetworkUtils stringEncodingWithRequest:request]];
        
        switch (request.responseSerializerType) {
            case PPResponseSerializerTypeHTTP:
                // Default serializer. Do nothing.
                break;
            case PPResponseSerializerTypeJSON:
                request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:request.responseData error:&serializationError];
                request.responseJSONObject = request.responseObject;
                break;
            case PPResponseSerializerTypeXMLParser:
                request.responseObject = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:request.responseData error:&serializationError];
                break;
        }
    }
    if (error) {
        succeed = NO;
        requestError = error;
    } else if (serializationError) {
        succeed = NO;
        requestError = serializationError;
    } else {
        succeed = [self validateResult:request error:&validationError];
        requestError = validationError;
    }
    
    if (succeed) {
        [self requestDidSucceedWithRequest:request];
    } else {
        [self requestDidFailWithRequest:request error:requestError];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeRequestFromRecord:request];
        [request clearCompletionBlock];
    });
}

- (void)requestDidSucceedWithRequest:(PPBaseRequest *)request {
    @autoreleasepool {
        [request requestCompletePreprocessor];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [request tellObserversRequestWillStop];
        [request requestDidCompleted];
        
        if (request.delegate != nil) {
            [request.delegate requestDidFinished:request];
        }
        if (request.requsetSuccessBlock) {
            request.requsetSuccessBlock(request);
        }
        [request tellObserversRequestDidStop];
    });
}

- (void)requestDidFailWithRequest:(PPBaseRequest *)request error:(NSError *)error {
    request.error = error;
    PPLog(@"Request %@ failed, status code = %ld, error = %@",
          NSStringFromClass([request class]), (long)request.responseStatusCode, error.localizedDescription);
    
    // Save incomplete download data.
    NSData *incompleteDownloadData = error.userInfo[NSURLSessionDownloadTaskResumeData];
    if (incompleteDownloadData) {
        [incompleteDownloadData writeToURL:[self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath] atomically:YES];
    }
    
    // Load response from file and clean up if download task failed.
    if ([request.responseObject isKindOfClass:[NSURL class]]) {
        NSURL *url = request.responseObject;
        if (url.isFileURL && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            request.responseData = [NSData dataWithContentsOfURL:url];
            request.responseString = [[NSString alloc] initWithData:request.responseData encoding:[PPNetworkUtils stringEncodingWithRequest:request]];
            
            [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
        }
        request.responseObject = nil;
    }
    
    @autoreleasepool {
        [request requestFailedPreprocessor];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [request tellObserversRequestWillStop];
        [request requestDidFailed];
        
        if (request.delegate != nil) {
            [request.delegate requestDidFailed:request];
        }
        if (request.requsetFailureBlock) {
            request.requsetFailureBlock(request);
        }
        [request tellObserversRequestDidStop];
    });
}

- (void)addRequestToRecord:(PPBaseRequest *)request {
    Lock();
    self.requestsRecord[@(request.requestTask.taskIdentifier)] = request;
    Unlock();
}

- (void)removeRequestFromRecord:(PPBaseRequest *)request {
    Lock();
    [self.requestsRecord removeObjectForKey:@(request.requestTask.taskIdentifier)];
    PPLog(@"Request queue size = %zd", [self.requestsRecord count]);
    Unlock();
}

#pragma mark - NSURLSessionDataTask

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                           error:(NSError * _Nullable __autoreleasing *)error {
    return [self dataTaskWithHTTPMethod:method requestSerializer:requestSerializer URLString:URLString parameters:parameters constructingBodyWithBlock:nil error:error];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableURLRequest *request = nil;
    
    if (block) {
        request = [requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:block error:error];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:error];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self handleRequestResult:dataTask responseObject:responseObject error:error];
    }];
    
    
    return dataTask;
}


- (NSURLSessionDownloadTask *)downloadTaskWithDownloadPath:(NSString *)downloadPath
                                         requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                                 URLString:(NSString *)URLString
                                                parameters:(id)parameters
                                                  progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                                     error:(NSError * _Nullable __autoreleasing *)error {
    // add parameters to URL;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:error];
    
    NSString *downloadTargetPath;
    BOOL isDirectory;
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadPath isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    // If targetPath is a directory, use the file name we got from the urlRequest.
    // Make sure downloadTargetPath is always a file, not directory.
    if (isDirectory) {
        NSString *fileName = [urlRequest.URL lastPathComponent];
        downloadTargetPath = [NSString pathWithComponents:@[downloadPath, fileName]];
    } else {
        downloadTargetPath = downloadPath;
    }
    
    // AFN use `moveItemAtURL` to move downloaded file to target path,
    // this method aborts the move attempt if a file already exist at the path.
    // So we remove the exist file before we start the download task.
    // https://github.com/AFNetworking/AFNetworking/issues/3775
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadTargetPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:downloadTargetPath error:nil];
    }
    
    BOOL resumeDataFileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self incompleteDownloadTempPathForDownloadPath:downloadPath].path];
    NSData *data = [NSData dataWithContentsOfURL:[self incompleteDownloadTempPathForDownloadPath:downloadPath]];
    BOOL resumeDataIsValid = [PPNetworkUtils validateResumeData:data];
    
    BOOL canBeResumed = resumeDataFileExists && resumeDataIsValid;
    BOOL resumeSucceeded = NO;
    __block NSURLSessionDownloadTask *downloadTask = nil;
    // Try to resume with resumeData.
    // Even though we try to validate the resumeData, this may still fail and raise excecption.
    if (canBeResumed) {
        @try {
            downloadTask = [self.manager downloadTaskWithResumeData:data progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return [NSURL fileURLWithPath:downloadTargetPath isDirectory:NO];
            } completionHandler:
                            ^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [self handleRequestResult:downloadTask responseObject:filePath error:error];
            }];
            resumeSucceeded = YES;
        } @catch (NSException *exception) {
            PPLog(@"Resume download failed, reason = %@", exception.reason);
            resumeSucceeded = NO;
        }
    }
    if (!resumeSucceeded) {
        downloadTask = [self.manager downloadTaskWithRequest:urlRequest progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:downloadTargetPath isDirectory:NO];
        } completionHandler:
                        ^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            [self handleRequestResult:downloadTask responseObject:filePath error:error];
        }];
    }
    return downloadTask;
}

#pragma mark - Resumable Download

- (NSString *)incompleteDownloadTempCacheFolder {
    NSFileManager *fileManager = [NSFileManager new];
    static NSString *cacheFolder;
    
    if (!cacheFolder) {
        NSString *cacheDir = NSTemporaryDirectory();
        cacheFolder = [cacheDir stringByAppendingPathComponent:PPKNetworkIncompleteDownloadFolderName];
    }
    
    NSError *error = nil;
    if(![fileManager createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
        PPLog(@"Failed to create cache directory at %@", cacheFolder);
        cacheFolder = nil;
    }
    return cacheFolder;
}

- (NSURL *)incompleteDownloadTempPathForDownloadPath:(NSString *)downloadPath {
    NSString *tempPath = nil;
    NSString *md5URLString = [PPNetworkUtils md5StringFromString:downloadPath];
    tempPath = [[self incompleteDownloadTempCacheFolder] stringByAppendingPathComponent:md5URLString];
    return [NSURL fileURLWithPath:tempPath];
}

#pragma mark - Testing

- (AFHTTPSessionManager *)manager {
    return _manager;
}

- (void)resetURLSessionManager {
    _manager = [AFHTTPSessionManager manager];
}

- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration {
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
}

@end
