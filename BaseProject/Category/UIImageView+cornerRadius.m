//
//  UIImageView+cornerRadius.m
//  SNEBook
//
//  Created by hj on 2018/5/16.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIImageView+cornerRadius.h"


@implementation UIImageView (cornerRadius)
-(void)addCornerRadius:(float)radius
{
    //如果是用masrony来约束的 那么需要重绘一下才有宽高
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
   
    
    
    
    
    
}
@end
