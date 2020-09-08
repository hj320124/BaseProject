//
//  UIControl+BUIControl.h
//  BlockUI
//
//  Created by zhangxi on 12-9-10.
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (BUIControl)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;

@end
