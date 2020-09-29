//
//  PPBaseRequest.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/14.
//  Copyright © 2020 mate. All rights reserved.
//  网络请求基础类

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const PPRequestValidationErrorDomain;

NS_ENUM(NSInteger) {
    PPRequestValidationErrorInvalidStatusCode = -8,
    PPRequestValidationErrorInvalidJSONFormat = -9,
};

/// 请求类型
typedef NS_ENUM(NSInteger, PPRequestMethod) {
    PPRequestMethodGET = 0,
    PPRequestMethodPOST,
    PPRequestMethodHEAD,
    PPRequestMethodPUT,
    PPRequestMethodDELETE,
    PPRequestMethodPATCH
};

/// 请求优先级
typedef NS_ENUM(NSInteger, PPRequestPriority) {
    PPRequestPriorityLow = -4L,
    PPRequestPriorityDefault = 0,
    PPRequestPriorityHigh = 4
};

/// 请求序列化工具类型
typedef NS_ENUM(NSInteger, PPRequestSerializerType) {
    PPRequestSerializerTypeHTTP = 0,
    PPRequestSerializerTypeJSON
};

/// 返回数据序列化工具类型
typedef NS_ENUM(NSInteger, PPResponseSerializerType) {
    PPResponseSerializerTypeHTTP,
    PPResponseSerializerTypeJSON,
    PPResponseSerializerTypeXMLParser
};

@protocol AFMultipartFormData;
/// post请求有文件和富文本的时候使用的block
typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

/// 重定向的block
typedef NSURLRequest *(^PPRedirectBlock)(NSURLSession *session, NSURLSessionTask *task, NSURLResponse *response, NSURLRequest *request);

/// 下载进度block
typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);

@class PPBaseRequest;

///请求结果回调
@protocol PPBaseRequestDelegate <NSObject>

@optional
/// 请求成功
- (void)requestDidFinished:(PPBaseRequest *)request;

/// 请求失败
- (void)requestDidFailed:(PPBaseRequest *)request;

@end

/// 请求的监听
@protocol PPBaseRequestObserver <NSObject>

@optional
/// 请求将要开始
- (void)requestWillStart:(id)request;

/// 请求将要结束
- (void)requestWillStop:(id)request;

/// 请求结束
- (void)requestDidStop:(id)request;

@end

@interface PPBaseRequest : NSObject

#pragma mark -- 基础属性
///=====================================================================
///@ requset 基础属性
///=====================================================================
///
/// @warning 任务开始前为空
@property (nonatomic, strong,readonly) NSURLSessionTask *requestTask;

///  requestTask.currentRequest
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

///  requestTask.originalRequest
@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

///  requestTask.response
@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

/// 响应状态码
@property (nonatomic, assign, readonly) NSInteger responseStatusCode;

/// 响应头部
@property (nonatomic, strong, readonly) NSDictionary *responseHeaders;

/// 响应的原始数据表示
@property (nonatomic, strong, readonly) NSData *responseData;

/// 序列化对象，如果是下载任务，此值是url形式
@property (nonatomic, strong, readonly) id responseObject;

/// 响应的字符串表示形式。
@property (nonatomic, strong, readonly) NSString *responseString;

/// 响应的json序列化对象
@property (nonatomic, strong, readonly) id responseJSONObject;

/// 请求错误
@property (nonatomic, strong ,readonly) NSError *error;

/// 请求任务的取消状态
@property (nonatomic, readonly, getter = isCancelled) BOOL cancelled;

/// 请求任务的执行状态
@property (nonatomic, readonly, getter = isExecuting) BOOL executing;

#pragma mark -- 请求的configuration
///=====================================================================
///@ requset configuration
///=====================================================================
///
/// 给request一个tag，可以标记request
@property (nonatomic, assign) NSInteger tag;

/// 给request一个存储额外信息的字典
@property (nonatomic, strong) NSDictionary *userInfo;

/// 请求结果代理
@property (nonatomic, weak) id<PPBaseRequestDelegate> delegate;

/// 请求成功回调
@property (nonatomic, copy) void (^requsetSuccessBlock)(PPBaseRequest *);

/// 请求失败回调
@property (nonatomic, copy) void (^requsetFailureBlock)(PPBaseRequest *);

/// 下载地址
@property (nonatomic, strong) NSString *resumableDownloadPath;

/// 下载进度
@property (nonatomic, copy) AFURLSessionTaskProgressBlock resumeDownloadProgressBlock;

@property (nonatomic, copy) AFURLSessionTaskProgressBlock upLoadBlock;

/// post请求使用
@property (nonatomic, copy) AFConstructingBlock constructingBodyBlock;

/// 存放请求监听的数组
@property (nonatomic, strong) NSMutableArray <id<PPBaseRequestObserver>>*observersArray;

/// 请求优先级
@property (nonatomic, assign) PPRequestPriority requestPriority;

///开启缓存策略dzp
@property(nonatomic,assign) NSURLRequestCachePolicy cachePolicy;

#pragma mark -- 通用方法

/// 设置成功失败请求的回调
/// @param success 成功回调
/// @param failure 失败回调
- (void)setCompletionBlockWithSuccess:(void (^)(PPBaseRequest *request))success
failure:(void (^)(PPBaseRequest *request))failure;

/// 添加请求监听方法
/// @param observer 请求监听的代理
- (void)addObserver:(id<PPBaseRequestObserver>)observer;

/// 开始请求的回调
/// @param success 成功回调
/// @param failure 失败回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(PPBaseRequest *request))success
failure:(void (^)(PPBaseRequest *request))failure;

/// 开始任务
- (void)start;

/// 停止任务
- (void)stop;

/// 清除完成的block
- (void)clearCompletionBlock;

#pragma mark -- 以下方法由子类继承来覆盖默认值
///=====================================================================
///@ requset 子类继承方法
///=====================================================================
///
/// 请求成功在切换到主线程之前的回调
- (void)requestCompletePreprocessor;

/// 请求成功，在主线程
- (void)requestDidCompleted;

/// 请求失败在切换到主线程之前的回调
- (void)requestFailedPreprocessor;

/// 请求失败
- (void)requestDidFailed;

/// 请求的URL中的host e.g. http://www.ppm.com
- (NSString *)baseUrl;

/// 请求的URL，可以不包含host
- (NSString *)requestUrl;

/// CDN加速 URL
- (NSString *)cdnUrl;

/// 请求的连接超时时间，默认为20秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数列表
- (id)requestArgument;

/// 重写此方法以在缓存时用某些参数筛选请求。
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/// Http请求的方法
- (PPRequestMethod)requestMethod;

/// 请求序列化类型
- (PPRequestSerializerType)requestSerializerType;

/// 响应序列化类型
- (PPResponseSerializerType)responseSerializerType;

/// 请求认证的用户和密码 @[@"Username", @"Password"].
- (NSArray<NSString *> *)requestAuthorizationHeaderFieldArray;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest;

/// 发送请求时使用cdn
- (BOOL)useCDN;

/// 是否允许使用蜂窝移动网络，默认是YES
- (BOOL)allowsCellularAccess;

/// 用于检查JSON是否合法的对象,如果这里返回nil，那么就不会验证json
- (id)jsonValidator;

/// 用于检查Status Code是否正常的方法，如果返回yes，会继续进行json合法验证，
//  如果返回no，认为请求失败
- (BOOL)statusCodeValidator;

/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock;

@end
