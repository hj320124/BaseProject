//
//  GCDQueue.h
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDGroup;

@interface GCDQueue : NSObject
//队列
@property (strong, readonly, nonatomic) dispatch_queue_t dispatchQueue;

+ (GCDQueue *)mainQueue;//主线程队列
+ (GCDQueue *)globalQueue;//全局对列
+ (GCDQueue *)highPriorityGlobalQueue;//高优先级全局对列
+ (GCDQueue *)lowPriorityGlobalQueue;//低优先级全局对列
+ (GCDQueue *)backgroundPriorityGlobalQueue;//后台运行全局对列

#pragma mark - 便利的构造方法
 //在主队列中执行任务
+ (void)executeInMainQueue:(dispatch_block_t)block;
//在全局队列中执行任务
+ (void)executeInGlobalQueue:(dispatch_block_t)block;
//在高优先级的全局队列中执行任务
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block;
//在低优先级的任务中执行队列
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block;
//在后台线程中执行任务
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block;
//在主线程中延迟一段时间执行任务
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
//在全局队列中延迟一段时间执行任务
+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
//在高优先级全局队列中延迟执行任务
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
//在低优先级的全局队列中延迟执行任务
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
//在后台队列中延迟执行全局队列
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

#pragma 初始化
- (instancetype)init;
- (instancetype)initSerial;
- (instancetype)initSerialWithLabel:(NSString *)label;
- (instancetype)initConcurrent;
- (instancetype)initConcurrentWithLabel:(NSString *)label;

#pragma mark - 用法
/*
 *执行block
 */
- (void)execute:(dispatch_block_t)block;
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta;
- (void)execute:(dispatch_block_t)block afterDelaySecs:(float)delta;
- (void)waitExecute:(dispatch_block_t)block;//等待执行block
- (void)barrierExecute:(dispatch_block_t)block;//栅栏函数执行
- (void)waitBarrierExecute:(dispatch_block_t)block;//等待栅栏函数执行
- (void)suspend;//线程暂停
- (void)resume;//线程启动

#pragma mark - 与GCDGroup相关
- (void)execute:(dispatch_block_t)block inGroup:(GCDGroup *)group;

- (void)notify:(dispatch_block_t)block inGroup:(GCDGroup *)group;

@end
