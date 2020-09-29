////
////  PPNetworkPrivate.h
////  BaseProject
////
////  Created by imac2015-2 on 2020/5/14.
////  Copyright © 2020 mate. All rights reserved.
////  PPNetwork 组件相关
#import <Foundation/Foundation.h>
#import "PPRequest.h"
#import "PPBaseRequest.h"
#import "PPBatchRequest.h"
#import "PPChainRequest.h"
#import "PPNetworkAgent.h"
#import "PPNetworkConfig.h"

FOUNDATION_EXPORT void PPLog(NSString * _Nullable format, ...) NS_FORMAT_FUNCTION(1,2);

@class AFHTTPSessionManager;

@interface PPNetworkUtils : NSObject

/// 验证json是否合法
+ (BOOL)validateJSON:(id _Nullable )json withValidator:(id _Nullable )jsonValidator;
/// 添加描述
+ (void)addDoNotBackupAttribute:(NSString *_Nullable)path;
/// 生成md5
+ (NSString *_Nullable)md5StringFromString:(NSString *_Nullable)string;
/// app版本号
+ (NSString *_Nullable)appVersionString;
///
+ (NSStringEncoding)stringEncodingWithRequest:(PPBaseRequest *_Nullable)request;
/// 验证下载的数据
+ (BOOL)validateResumeData:(NSData *_Nullable)data;

@end

@interface PPRequest (Getter)

- (NSString *_Nullable)cacheBasePath;

@end

@interface PPBaseRequest (Setter)
/// 这里的属性原本设置的是readonly 其他地方要用到需要使用
@property (nonatomic, strong, readwrite) NSURLSessionTask * _Nullable requestTask;
@property (nonatomic, strong, readwrite, nullable) NSData *responseData;
@property (nonatomic, strong, readwrite, nullable) id responseJSONObject;
@property (nonatomic, strong, readwrite, nullable) id responseObject;
@property (nonatomic, strong, readwrite, nullable) NSString *responseString;
@property (nonatomic, strong, readwrite, nullable) NSError *error;

@end

@interface PPBaseRequest (RequestObserver)

- (void)tellObserversRequestWillStart;

- (void)tellObserversRequestWillStop;

- (void)tellObserversRequestDidStop;

@end

@interface PPBatchRequest (RequestObserver)

- (void)tellObserversRequestWillStart;

- (void)tellObserversRequestWillStop;

- (void)tellObserversRequestDidStop;

@end

@interface PPChainRequest (RequestObserver)

- (void)tellObserversRequestWillStart;

- (void)tellObserversRequestWillStop;

- (void)tellObserversRequestDidStop;

@end

@interface PPNetworkAgent (Private)

- (AFHTTPSessionManager *_Nullable)manager;

- (void)resetURLSessionManager;

- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *_Nullable)configuration;

- (NSString *_Nullable)incompleteDownloadTempCacheFolder;

@end

