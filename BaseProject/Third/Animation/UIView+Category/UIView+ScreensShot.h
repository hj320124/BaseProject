//
//  UIView+ScreensShot.h
//  SNEBook
//
//  Created by mate on 2018/10/8.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//  截图的功能

#import <UIKit/UIKit.h>

@interface UIView (ScreensShot)
/**
 *  无损截图
 *
 *  这个功能可能在任何线程调用
 *
 *  @return 返回生成的图片
 */
- (UIImage *)screenShot;

@end
