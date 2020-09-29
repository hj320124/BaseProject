//
//  PPBatchRequest.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//  批量请求类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PPRequest;
@class PPBatchRequest;
@protocol PPBaseRequestObserver;

/// 所有委托方法将被调用在主队列上。 请注意，当所有请求都完成时将调用委托方法
@protocol PPBatchRequestDelegate <NSObject>

@optional
///  批量请求已经完成
///  @param batchRequest The corresponding batch request.
- (void)batchRequestFinished:(PPBatchRequest *)batchRequest;

/// 批量请求失败
///  @param batchRequest The corresponding batch request.
- (void)batchRequestFailed:(PPBatchRequest *)batchRequest;

@end


@interface PPBatchRequest : NSObject

/// 保存所有的单个请求
@property (nonatomic, strong, readonly) NSArray<PPRequest *> *requestArray;

/// 代理
@property (nonatomic, weak, nullable) id<PPBatchRequestDelegate> delegate;

/// 成功回调。 请注意，只有在所有请求都完成后才会调用此方法。
/// 将在主队列上调用此block。
@property (nonatomic, copy, nullable) void (^batchRequsetSuccessBlock)(PPBatchRequest *);

/// 失败回调。 请注意，如果其中一个请求失败，则将调用此方法。
/// 将在主队列上调用此block。
@property (nonatomic, copy, nullable) void (^batchRequestfailureBlock)(PPBatchRequest *);

@property (nonatomic) NSInteger tag;

/// 观察者代理对象叔叔
@property (nonatomic, strong, nullable) NSMutableArray<id<PPBaseRequestObserver>> *observersArray;

/// 第一个失败的请求（并导致批处理请求失败）。
@property (nonatomic, strong, readonly, nullable) PPRequest *failedRequest;

/// 创建带有一系列请求的`PPBatchRequest`。
///
/// @param requestArray 请求用于创建批处理请求。
- (instancetype)initWithRequestArray:(NSArray<PPRequest *> *)requestArray;

///  设置完成的回调
- (void)setCompletionBlockWithSuccess:(nullable void (^)(PPBatchRequest *batchRequest))success
                              failure:(nullable void (^)(PPBatchRequest *batchRequest))failure;

///  清除block
- (void)clearCompletionBlock;

///  添加监听对象
- (void)addObserver:(id<PPBaseRequestObserver>)observer;

///  将所有请求追加到队列中。
- (void)start;

///  停止批处理请求中的所有请求。
- (void)stop;

///  使用块回调启动批处理请求的便捷方法。
- (void)startWithCompletionBlockWithSuccess:(nullable void (^)(PPBatchRequest *batchRequest))success
                                    failure:(nullable void (^)(PPBatchRequest *batchRequest))failure;

///  是否所有响应数据都来自本地缓存。
- (BOOL)isDataFromCache;

@end

NS_ASSUME_NONNULL_END

