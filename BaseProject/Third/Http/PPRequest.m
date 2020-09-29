//
//  PPRequest.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPNetworkConfig.h"
#import "PPNetworkPrivate.h"

#ifndef NSFoundationVersionNumber_iOS_8_0
#define NSFoundationVersionNumber_With_QoS_Available 1140.11
#else
#define NSFoundationVersionNumber_With_QoS_Available NSFoundationVersionNumber_iOS_8_0
#endif

NSString *const PPRequestCacheErrorDomain = @"com.ppm.request.caching";

static dispatch_queue_t pprequest_cache_writing_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_With_QoS_Available) {
            attr = dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_BACKGROUND, 0);
        }
        queue = dispatch_queue_create("com.ppm.request.caching", attr);
    });

    return queue;
}

@interface PPCacheMetadata : NSObject<NSSecureCoding>

@property (nonatomic, assign) long long version;
@property (nonatomic, strong) NSString *sensitiveDataString;
@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString *appVersionString;

@end

@implementation PPCacheMetadata

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.version) forKey:NSStringFromSelector(@selector(version))];
    [aCoder encodeObject:self.sensitiveDataString forKey:NSStringFromSelector(@selector(sensitiveDataString))];
    [aCoder encodeObject:@(self.stringEncoding) forKey:NSStringFromSelector(@selector(stringEncoding))];
    [aCoder encodeObject:self.creationDate forKey:NSStringFromSelector(@selector(creationDate))];
    [aCoder encodeObject:self.appVersionString forKey:NSStringFromSelector(@selector(appVersionString))];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (!self) {
        return nil;
    }

    self.version = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(version))] integerValue];
    self.sensitiveDataString = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(sensitiveDataString))];
    self.stringEncoding = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(stringEncoding))] integerValue];
    self.creationDate = [aDecoder decodeObjectOfClass:[NSDate class] forKey:NSStringFromSelector(@selector(creationDate))];
    self.appVersionString = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(appVersionString))];

    return self;
}

@end

@interface PPRequest()

@property (nonatomic, strong) NSData *cacheData;

@property (nonatomic, strong) NSString *cacheString;

@property (nonatomic, strong) id cacheJSON;

@property (nonatomic, strong) NSXMLParser *cacheXML;

@property (nonatomic, strong) PPCacheMetadata *cacheMetadata;

@property (nonatomic, assign) BOOL dataFromCache;

@end

@implementation PPRequest

- (void)start {
    if (self.ignoreCache) {
        [self startWithoutCache];
        return;
    }

    // 不缓存下载的请求
    if (self.resumableDownloadPath) {
        [self startWithoutCache];
        return;
    }

    if (![self loadCacheWithError:nil]) {
        [self startWithoutCache];
        return;
    }

    _dataFromCache = YES;
// 如果走的缓存 直接返回请求成功
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestCompletePreprocessor];
        [self requestDidCompleted];
        PPRequest *strongSelf = self;
        [strongSelf.delegate requestDidFinished:strongSelf];
        if (strongSelf.requsetSuccessBlock) {
            strongSelf.requsetSuccessBlock(strongSelf);
        }
        [strongSelf clearCompletionBlock];
    });
}

- (void)startWithoutCache {
    [self clearCacheVariables];
    [super start];
}

#pragma mark - Network Request Delegate

- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
//  如果使用异步存储本地数据,开启一个异步线程存储
    if (self.writeCacheAsynchronously) {
        dispatch_async(pprequest_cache_writing_queue(), ^{
            [self saveResponseDataToCacheFile:[super responseData]];
        });
    } else {
        [self saveResponseDataToCacheFile:[super responseData]];
    }
}

#pragma mark - 子类继承的方法

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (long long)cacheVersion {
    return 0;
}

- (id)cacheSensitiveData {
    return nil;
}

- (BOOL)writeCacheAsynchronously {
    return YES;
}

#pragma mark -

- (BOOL)isDataFromCache {
    return _dataFromCache;
}

- (NSData *)responseData {
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseData];
}

- (NSString *)responseString {
    if (_cacheString) {
        return _cacheString;
    }
    return [super responseString];
}

- (id)responseJSONObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    return [super responseJSONObject];
}

- (id)responseObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    if (_cacheXML) {
        return _cacheXML;
    }
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseObject];
}

#pragma mark -

- (BOOL)loadCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    // Make sure cache time in valid.
    if ([self cacheTimeInSeconds] < 0) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorInvalidCacheTime userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache time"}];
        }
        return NO;
    }

    // Try load metadata.
    if (![self loadCacheMetadata]) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorInvalidMetadata userInfo:@{ NSLocalizedDescriptionKey:@"Invalid metadata. Cache may not exist"}];
        }
        return NO;
    }

    // Check if cache is still valid.
    if (![self validateCacheWithError:error]) {
        return NO;
    }

    // Try load cache.
    if (![self loadCacheData]) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorInvalidCacheData userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache data"}];
        }
        return NO;
    }

    return YES;
}

- (BOOL)validateCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    // Date
    NSDate *creationDate = self.cacheMetadata.creationDate;
    NSTimeInterval duration = -[creationDate timeIntervalSinceNow];
    if (duration < 0 || duration > [self cacheTimeInSeconds]) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorExpired userInfo:@{ NSLocalizedDescriptionKey:@"Cache expired"}];
        }
        return NO;
    }
    // Version
    long long cacheVersionFileContent = self.cacheMetadata.version;
    if (cacheVersionFileContent != [self cacheVersion]) {
        if (error) {
            *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache version mismatch"}];
        }
        return NO;
    }
    // Sensitive data
    NSString *sensitiveDataString = self.cacheMetadata.sensitiveDataString;
    NSString *currentSensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
    if (sensitiveDataString || currentSensitiveDataString) {
        // If one of the strings is nil, short-circuit evaluation will trigger
        if (sensitiveDataString.length != currentSensitiveDataString.length || ![sensitiveDataString isEqualToString:currentSensitiveDataString]) {
            if (error) {
                *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorSensitiveDataMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache sensitive data mismatch"}];
            }
            return NO;
        }
    }
    // App version
    NSString *appVersionString = self.cacheMetadata.appVersionString;
    NSString *currentAppVersionString = [PPNetworkUtils appVersionString];
    if (appVersionString || currentAppVersionString) {
        if (appVersionString.length != currentAppVersionString.length || ![appVersionString isEqualToString:currentAppVersionString]) {
            if (error) {
                *error = [NSError errorWithDomain:PPRequestCacheErrorDomain code:PPRequestCacheErrorAppVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"App version mismatch"}];
            }
            return NO;
        }
    }
    return YES;
}

- (BOOL)loadCacheMetadata {
    NSString *path = [self cacheMetadataFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        @try {
            _cacheMetadata = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            return YES;
        } @catch (NSException *exception) {
            PPLog(@"Load cache metadata failed, reason = %@", exception.reason);
            return NO;
        }
    }
    return NO;
}

- (BOOL)loadCacheData {
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;

    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        _cacheData = data;
        _cacheString = [[NSString alloc] initWithData:_cacheData encoding:self.cacheMetadata.stringEncoding];
        switch (self.responseSerializerType) {
            case PPResponseSerializerTypeHTTP:
                // 不做任何事
                return YES;
            case PPResponseSerializerTypeJSON:
                _cacheJSON = [NSJSONSerialization JSONObjectWithData:_cacheData options:(NSJSONReadingOptions)0 error:&error];
                return error == nil;
            case PPResponseSerializerTypeXMLParser:
                _cacheXML = [[NSXMLParser alloc] initWithData:_cacheData];
                return YES;
        }
    }
    return NO;
}

- (void)saveResponseDataToCacheFile:(NSData *)data {
    if ([self cacheTimeInSeconds] > 0 && ![self isDataFromCache]) {
        if (data != nil) {
            @try {
                // 新的数据将会覆盖老的数据.
                [data writeToFile:[self cacheFilePath] atomically:YES];

                PPCacheMetadata *metadata = [[PPCacheMetadata alloc] init];
                metadata.version = [self cacheVersion];
                metadata.sensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
                metadata.stringEncoding = [PPNetworkUtils stringEncodingWithRequest:self];
                metadata.creationDate = [NSDate date];
                metadata.appVersionString = [PPNetworkUtils appVersionString];
                [NSKeyedArchiver archiveRootObject:metadata toFile:[self cacheMetadataFilePath]];
            } @catch (NSException *exception) {
                PPLog(@"Save cache failed, reason = %@", exception.reason);
            }
        }
    }
}

- (void)clearCacheVariables {
    _cacheData = nil;
    _cacheXML = nil;
    _cacheJSON = nil;
    _cacheString = nil;
    _cacheMetadata = nil;
    _dataFromCache = NO;
}

#pragma mark -

- (void)createDirectoryIfNeeded:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path {
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        PPLog(@"create cache directory failed, error = %@", error);
    } else {
        [PPNetworkUtils addDoNotBackupAttribute:path];
    }
}

- (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];

    // Filter cache base path
    NSArray<id<PPCacheDirPathFilterProtocol>> *filters = [[PPNetworkConfig sharedConfig] cacheDirPathFilters];
    if (filters.count > 0) {
        for (id<PPCacheDirPathFilterProtocol> f in filters) {
            path = [f filterCacheDirPath:path withRequest:self];
        }
    }

    [self createDirectoryIfNeeded:path];
    return path;
}

- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = [PPNetworkConfig sharedConfig].baseUrl;
    id argument = [self cacheFileNameFilterForRequestArgument:[self requestArgument]];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@",
                             (long)[self requestMethod], baseUrl, requestUrl, argument];
    NSString *cacheFileName = [PPNetworkUtils md5StringFromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheMetadataFilePath {
    NSString *cacheMetadataFileName = [NSString stringWithFormat:@"%@.metadata", [self cacheFileName]];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheMetadataFileName];
    return path;
}

@end

