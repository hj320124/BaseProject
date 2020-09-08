//
//  GCDSemaphore.m
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GCDSemaphore.h"

@interface GCDSemaphore ()

@property (strong, readwrite, nonatomic) dispatch_semaphore_t dispatchSemaphore;

@end

@implementation GCDSemaphore

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        //信号量为0
        self.dispatchSemaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}

- (instancetype)initWithValue:(long)value {
    
    self = [super init];
    
    if (self) {
        //初始化信号量值
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    
    return self;
}

- (BOOL)signal {
    
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait {
    
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    
    return dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

-(void)test
{
    //创建一个新信号量每次允许一次操作
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    
   // [网络请求:{
        //成功：dispatch_semaphore_signal(sema);//信号量+1
        //失败：dispatch_semaphore_signal(sema);//信号量+1
    //}];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);//信号量等待直到操作结束

   
}

@end
