//
//  UIImageView+cornerRadius.h
//  SNEBook
//
//  Created by hj on 2018/5/16.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//  给图片添加圆角的方法

#import <UIKit/UIKit.h>

@interface UIImageView (cornerRadius)
/**
 @parma radius 圆角的大小 
 */
-(void)addCornerRadius:(float)radius;
@end
