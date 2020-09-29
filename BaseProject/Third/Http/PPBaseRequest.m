//
//  PPBaseRequest.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/14.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPBaseRequest.h"
#import "PPNetworkAgent.h"
#import "PPNetworkPrivate.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

NSString *const PPRequestValidationErrorDomain = @"com.ppm.request.validation";

@interface PPBaseRequest ()

@property (nonatomic, strong) NSURLSessionTask *requestTask;

@property (nonatomic, strong) NSData *responseData;

@property (nonatomic, strong) id responseJSONObject;

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) NSString *responseString;

@property (nonatomic, strong) NSError *error;

@end

@implementation PPBaseRequest

#pragma mark -- requst 和 response 的信息

- (NSHTTPURLResponse *)response {
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)responseStatusCode {
    return self.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest {
    return self.requestTask.currentRequest;
}

- (NSURLRequest *)originalRequest {
    return self.requestTask.originalRequest;
}

- (BOOL)isCancelled {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (BOOL)isExecuting {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateRunning;
}

#pragma mark -- reqeust configuration

//  添加Request的监听
- (void)addObserver:(id<PPBaseRequestObserver>)observer
{
    if (!self.observersArray) {
        self.observersArray = [NSMutableArray array];
    }
    if (observer) {
        [self.observersArray addObject:observer];
    }
}

- (void)setCompletionBlockWithSuccess:(void (^)(PPBaseRequest *request))success
                              failure:(void (^)(PPBaseRequest *request))failure {
    self.requsetSuccessBlock = success;
    self.requsetFailureBlock = failure;
}

- (void)clearCompletionBlock {
    self.requsetSuccessBlock  = nil;
    self.requsetFailureBlock  = nil;
}

#pragma mark -- request 执行方法

- (void)start {
    [self tellObserversRequestWillStart];
    [[PPNetworkAgent sharedAgent] addRequest:self];
}

- (void)stop {
    [self tellObserversRequestWillStop];
    self.delegate = nil;
    [[PPNetworkAgent sharedAgent] cancelRequest:self];
    [self tellObserversRequestDidStop];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(PPBaseRequest *))success failure:(void (^)(PPBaseRequest *))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

#pragma mark --  以下方法由子类继承来覆盖默认值

- (void)requestCompletePreprocessor {
}

- (void)requestDidCompleted {
}

- (void)requestFailedPreprocessor {
}

- (void)requestDidFailed {
}

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)cdnUrl {
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 20;
}

- (id)requestArgument {
    return nil;
}

- (NSURLRequestCachePolicy)cachePolicy {
    return NSURLRequestReloadIgnoringLocalCacheData;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (PPRequestMethod)requestMethod {
    return PPRequestMethodGET;
}

- (PPRequestSerializerType)requestSerializerType {
    return PPRequestSerializerTypeHTTP;
}

- (PPResponseSerializerType)responseSerializerType {
    return PPResponseSerializerTypeJSON;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString *useragent = [self defaultUserAgentString];
    return @{@"User-Agent":useragent};
}

- (NSString *)defaultUserAgentString
{
    @synchronized (self) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        
        // Attempt to find a name for this application
        NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (!appName) {
            appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
        }
        
        NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
        appName = [[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding] ;
        
        // If we couldn't find one, we'll give up (and ASIHTTPRequest will use the standard CFNetwork user agent)
        if (!appName) {
            return nil;
        }
        
        NSString *appVersion = nil;
        NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
        if (marketingVersionNumber && developmentVersionNumber) {
            if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
                appVersion = marketingVersionNumber;
            } else {
                appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
            }
        } else {
            appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
        }
        
        NSString *deviceName;
        NSString *OSName;
        NSString *OSVersion;
        NSString *locale = [[NSLocale currentLocale] localeIdentifier];
        
#if TARGET_OS_IPHONE
        UIDevice *device = [UIDevice currentDevice];
        deviceName = [device model];
        OSName = [device systemName];
        OSVersion = [device systemVersion];
        
#else
        deviceName = @"Macintosh";
        OSName = @"Mac OS X";
        
        // From http://www.cocoadev.com/index.pl?DeterminingOSVersion
        // We won't bother to check for systems prior to 10.4, since ASIHTTPRequest only works on 10.5+
        OSErr err;
        SInt32 versionMajor, versionMinor, versionBugFix;
        err = Gestalt(gestaltSystemVersionMajor, &versionMajor);
        if (err != noErr) return nil;
        err = Gestalt(gestaltSystemVersionMinor, &versionMinor);
        if (err != noErr) return nil;
        err = Gestalt(gestaltSystemVersionBugFix, &versionBugFix);
        if (err != noErr) return nil;
        OSVersion = [NSString stringWithFormat:@"%u.%u.%u", versionMajor, versionMinor, versionBugFix];
#endif
        
        // Takes the form "My Application 1.0 (Macintosh; Mac OS X 10.5.7; en_GB)"
        NSString *strAgent = [NSString stringWithFormat:@"%@ %@ (%@; %@ %@; %@) SNCLIENT", appName, appVersion, deviceName, OSName, OSVersion, locale];
        
        return strAgent;
        
    }
    return nil;
    
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (BOOL)allowsCellularAccess {
    return YES;
}

- (id)jsonValidator {
    return nil;
}

- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    return  (statusCode >= 200 && statusCode <=299);
}

/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}

- (AFURLSessionTaskProgressBlock)resumeDownloadProgressBlock {
    return nil;
}

- (AFURLSessionTaskProgressBlock)upLoadBlock {
    return nil;
}
    
@end
