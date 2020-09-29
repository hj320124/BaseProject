//
//  PPNetWorkConfig.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//  PPNetwork 设置

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PPBaseRequest;
@class AFSecurityPolicy;

///  PPUrlFilterProtocol可用于在发送请求之前将公共参数附加到请求中。
@protocol PPUrlFilterProtocol <NSObject>
/// 在实际发送请求之前对其进行预处理。
///
/// @param originUrl 请求的原始URL，由“ requestUrl”返回
/// @param request 请求本身
///
/// @return一个新的URL，它将用作新的`requestUrl`
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(PPBaseRequest *)request;
@end

///  在缓存响应结果时，可以使用PPCacheDirPathFilterProtocol附加公共路径组件
@protocol PPCacheDirPathFilterProtocol <NSObject>
///在实际保存缓存路径之前对其进行预处理。
///
/// @param originPath 原始基本缓存路径，该路径在`PPRequest`类中生成。
/// @param request 请求本身
///
/// @return一个新路径，在缓存时将用作基本路径。
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(PPBaseRequest *)request;
@end

/// PPNetworkConfig存储了与全局网络相关的配置，这些配置将在`PPNetworkAgent`中使用

@interface PPNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 单例
+ (PPNetworkConfig *)sharedConfig;

///  请求基本URL，例如“ http://www.ppm.com”。 默认为空字符串。
@property (nonatomic, strong) NSString *baseUrl;
///  请求CDN URL。 默认为空字符串。
@property (nonatomic, strong) NSString *cdnUrl;
///  网址过滤器。 另请参见“ PPUrlFilterProtocol”。
@property (nonatomic, strong, readonly) NSArray<id<PPUrlFilterProtocol>> *urlFilters;
///  缓存路径过滤器。 另见`PPCacheDirPathFilterProtocol`。
@property (nonatomic, strong, readonly) NSArray<id<PPCacheDirPathFilterProtocol>> *cacheDirPathFilters;
///  AFNetworking将使用安全策略。 另请参阅“ AFSecurityPolicy”。
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;
///  是否记录调试信息。 默认为“否”。
@property (nonatomic) BOOL debugLogEnabled;
///  SessionConfiguration将用于初始化AFHTTPSessionManager。 默认值为nil。
@property (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;

///  添加一个新的URL过滤器。
- (void)addUrlFilter:(id<PPUrlFilterProtocol>)filter;
///  删除所有URL过滤器。
- (void)clearUrlFilter;
///  添加新的缓存路径过滤器
- (void)addCacheDirPathFilter:(id<PPCacheDirPathFilterProtocol>)filter;
///  清除所有缓存路径过滤器。
- (void)clearCacheDirPathFilter;

@end

NS_ASSUME_NONNULL_END
