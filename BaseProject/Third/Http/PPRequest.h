//
//  PPRequest.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//  PPBaseRequest的子类，主要用于取本地缓存数据

#import "PPBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const PPRequestCacheErrorDomain;

NS_ENUM(NSInteger) {
    PPRequestCacheErrorExpired = -1,
    PPRequestCacheErrorVersionMismatch = -2,
    PPRequestCacheErrorSensitiveDataMismatch = -3,
    PPRequestCacheErrorAppVersionMismatch = -4,
    PPRequestCacheErrorInvalidCacheTime = -5,
    PPRequestCacheErrorInvalidMetadata = -6,
    PPRequestCacheErrorInvalidCacheData = -7,
};


@interface PPRequest : PPBaseRequest

/// 是否使用缓存作为响应。
/// 默认为NO，这意味着缓存将对特定的参数生效。
/// 请注意，“ cacheTimeInSeconds”的默认值为-1。 结果是缓存数据实际上不是
/// 用作响应，除非您在`cacheTimeInSeconds`中返回正值。
///
/// 另外请注意，此选项不会影响响应的存储，这意味着响应将始终被保存
/// 甚至`ignoreCache`是YES。
@property (nonatomic) BOOL ignoreCache;

/// 数据是否来自本地缓存。
- (BOOL)isDataFromCache;

/// 从存储中手动加载缓存。
///
/// @param error 如果发生错误导致缓存加载失败，则将传递错误对象，否则为NULL。
///
/// @return是否成功加载缓存。
- (BOOL)loadCacheWithError:(NSError * __autoreleasing *)error;

/// 启动请求，而不读取本地缓存，即使该缓存存在也是如此。 使用此更新本地缓存。
- (void)startWithoutCache;

///  将响应数据（可能来自另一个请求）保存到该请求的缓存位置
- (void)saveResponseDataToCacheFile:(NSData *)data;

#pragma mark - Subclass Override

/// 缓存可以保留在磁盘上的最大持续时间，直到它被认为过期为止。
/// 默认值为-1，这意味着响应实际上并未保存为缓存。
- (NSInteger)cacheTimeInSeconds;

/// 版本可用于标识本地缓存并使其无效。 默认值为0。
- (long long)cacheVersion;

/// 可以用作告诉高速缓存需要更新的其他标识符。
/// @discussion该对象的`description`字符串将用作标识符以验证是否缓存
///              是无效的。 建议使用NSArray或NSDictionary作为返回值类型。 然而，
/// 如果打算使用自定义类类型，请确保正确执行了“ description”。
- (nullable id)cacheSensitiveData;

/// 是否将缓存异步写入存储。 默认为是。
- (BOOL)writeCacheAsynchronously;

@end

NS_ASSUME_NONNULL_END
