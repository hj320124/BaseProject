//
//  SemaphoreDetection.m
//  test
//
//  Created by mate on 2018/10/24.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "SemaphoreDetection.h"

@interface SemaphoreDetection()
{
    CFRunLoopObserverRef ymObserver;
    
@public     //@public 外部能访问到
    CFRunLoopActivity currentRunloopActivity;
    dispatch_semaphore_t semaphore;
    
   
}
@end

@implementation SemaphoreDetection
+(instancetype)shareInstance
{
    static dispatch_once_t once;
    static SemaphoreDetection *instance;
    dispatch_once(&once, ^{
        instance=[[SemaphoreDetection alloc] init];
    });
    return instance;
}
-(void)start
{
    if (ymObserver) {
        return;
    }
    //
    CFRunLoopObserverContext context={
        0,
        (__bridge void*)self,
        NULL,
        NULL,
        NULL
    };
    ymObserver=CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &mObservercallBack, &context);
    //创建同步信号量
    
    semaphore=dispatch_semaphore_create(0);
    
    //创建一个子线程检测
    dispatch_queue_t monitorQueue=dispatch_queue_create("monitor.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(monitorQueue, ^{
        
        //开一个持续的loop
        while (YES) {
            dispatch_time_t outTimer = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
            //信号量到达、或者 超时会继续向下进行，否则等待、
            long result = dispatch_semaphore_wait(self->semaphore, outTimer);
            if (result!=0) {
                //超时了，判断最后停留的信号量是哪一个，是或否处理为卡顿现象
                if (!self->ymObserver) {
                    NSLog(@"没有runloop观察者");
                    self->semaphore=0;
                    self->currentRunloopActivity=0;
                    return;
                }
                
                //判断当前 监听到的 信号(也就是说上一个信号量超过2秒没有更新，故卡顿)
                /**
                 RunLoop 顺序
                 1、进入
                 
                 2、通知Timer
                 3、通知Source
                 4、处理Source
                 5、如果有 Source1 调转到 11
                 6、通知 BeforWaiting
                 7、wait
                 8、通知afterWaiting
                 9、处理timer
                 10、处理 dispatch 到 main_queue 的 block
                 11、处理 Source1、
                 12、进入 2
                 
                 13、退出
                 
                 由上可知，主要处理任务阶段为 AfterWaiting 之后、通知Source之后
                 如果 发送 AfterWaiting 后在限定时间内没有发送其他信号量，
                 可以认为这中间存在耗时操作,判定为卡顿。
                 同理 通知Source之后 超时也可以判定为卡顿。
                 
                 */
                
                if (self->currentRunloopActivity == kCFRunLoopBeforeSources || self->currentRunloopActivity == kCFRunLoopAfterWaiting) {
                    //出现卡顿、进一步处理
                    NSLog(@"--卡顿啦----From 卡顿监控线程");
                    // log current stack info
                    continue;
                }
                
            }
            NSLog(@"--系统运行良好--From 卡顿监控线程");
        }
    });
    
    
}

-(void)end
{
    if (!ymObserver) {
        return;
    }
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), ymObserver, kCFRunLoopCommonModes);
    CFRelease(ymObserver);
    ymObserver = NULL;
    
    
}

static void  mObservercallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    //每一次监测到Runloop发送通知的时候，都会调用此函数
    //在此过程修改当前的 RunloopActivity 状态，发送同步信号。
    NSLog(@"发送通知了==》%lu",activity);
}

@end
