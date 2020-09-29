//
//  PPNetWorkAgent.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/15.
//  Copyright © 2020 mate. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPBaseRequest;

@interface PPNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///单例
+ (PPNetworkAgent *)sharedAgent;

/// 添加请求并开始请求
/// @param request 请求
- (void)addRequest:(PPBaseRequest *)request;

/// 取消某个请求
/// @param request 请求
- (void)cancelRequest:(PPBaseRequest *)request;

/// 取消所有请求
- (void)cancelAllRequests;

/// 返回请求的url字符串
/// @param request 请求
- (NSString *)buildRequestUrl:(PPBaseRequest *)request;

@end


