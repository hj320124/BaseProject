//
//  PPBatchRequestAgent.h
//  
//
//  Created by imac2015-2 on 2020/5/19.
//  批量请求的处理系统

#import <Foundation/Foundation.h>
@class PPBatchRequest;

@interface PPBatchRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 单粒对象.
+ (PPBatchRequestAgent *)sharedAgent;

///  添加一个批量请求
- (void)addBatchRequest:(PPBatchRequest *)request;

///  删除先前添加的批处理请求
- (void)removeBatchRequest:(PPBatchRequest *)request;

@end


