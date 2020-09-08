//
//  SemaphoreDetection.h
//  test
//
//  Created by mate on 2018/10/24.
//  Copyright © 2018年 mate. All rights reserved.
//  检测线程卡顿

#import <Foundation/Foundation.h>

@interface SemaphoreDetection : NSObject

+(instancetype)shareInstance;
-(void)start;
-(void)end;
@end
