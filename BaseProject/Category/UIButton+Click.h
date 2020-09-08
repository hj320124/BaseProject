//
//  UIButton+Click.h
//  SNEBook
//
//  Created by mate on 2018/7/11.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//  防止按钮重复点击

#import <UIKit/UIKit.h>

@interface UIButton (Click)
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end

