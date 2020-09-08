//
//  UIView+AnimationProperty.m
//  SNEBook
//
//  Created by mate on 2018/10/8.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIView+AnimationProperty.h"
#import <objc/runtime.h>
NSString *const scaleKey=@"_scaleKey";
NSString *const angleKey=@"_anglekey";
@implementation UIView (AnimationProperty)
-(void)setScale:(CGFloat)scale
{
    objc_setAssociatedObject(self, (__bridge const void *)(scaleKey), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform=CGAffineTransformMakeScale(scale, scale);
}

-(CGFloat)scale
{
    NSNumber *scaleValue=objc_getAssociatedObject(self, (__bridge const void *)(scaleKey));
    return scaleValue.floatValue;
}

-(void)setAngle:(CGFloat)angle
{
    objc_setAssociatedObject(self, (__bridge const void *)(angleKey), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform=CGAffineTransformMakeRotation(angle);
}

-(CGFloat)angle
{
    NSNumber *angleValue=objc_getAssociatedObject(self, (__bridge const void *)(angleKey));
    return angleValue.floatValue;
}

@end
