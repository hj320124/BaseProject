//
//  PPChainRequest.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPChainRequest;
@class PPBaseRequest;
@protocol PPBaseRequestObserver;

/// PPChainRequestDelegate协议定义了几种可以使用的可选方法
/// 接收与网络相关的消息。 所有委托方法将被调用在主队列上。
/// 请注意，当所有请求都将调用委托方法时 链式请求完成。
@protocol PPChainRequestDelegate <NSObject>

@optional
///  告诉代理链式请求成功
///
///  @param chainRequest 相应的链请求。
- (void)chainRequestFinished:(PPChainRequest *_Nullable)chainRequest;

/// 告诉代理链式请求失败。
///
/// @param chainRequest 相应的链请求。
/// @param request 第一个失败的请求，导致整个请求失败。
- (void)chainRequestFailed:(PPChainRequest *_Nullable)chainRequest failedBaseRequest:(PPBaseRequest*_Nullable)request;

@end

typedef void (^PPChainCallback)(PPChainRequest * _Nullable chainRequest, PPBaseRequest * _Nullable baseRequest);

/// PPBatchRequest可用于链接多个YTKRequest，以便一个仅在另一个完成后才开始。
/// 请注意，在PPChainRequest中使用时，单个PPRequest将具有自己的回调和委托

@interface PPChainRequest : NSObject

/// 储存所有单个请求
- (NSMutableArray<PPBaseRequest *> *_Nonnull)requestArray;

/// 代理
@property (nonatomic, weak, nullable) id<PPChainRequestDelegate> delegate;

/// 存放监听代理的数组
@property (nonatomic, strong, nullable) NSMutableArray<id<PPBaseRequestObserver>> *observersArray;

///  添加监听对象
- (void)addObserver:(id<PPBaseRequestObserver>_Nullable)observer;

///  启动链请求，将链中的第一个请求添加到请求队列。
- (void)start;

///  停止链请求。 链中剩余的请求将被取消。
- (void)stop;

/// 将请求添加到请求链。
///
/// @param request 要链接的请求。
/// @param callback 完成回调
- (void)addRequest:(PPBaseRequest *_Nullable)request callback:(nullable PPChainCallback)callback;

@end
