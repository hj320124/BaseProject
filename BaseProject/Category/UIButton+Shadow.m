//
//  UIButton+Shadow.m
//  阴影
//
//  Created by farben on 2018/8/15.
//  Copyright © 2018年 胡高广. All rights reserved.
//

#import "UIButton+Shadow.h"
@implementation UIButton (Shadow)


-(void)buttonShadow
{
    UIColor *shadowColor = [UIColor colorWithHexString:@"#A6CBED"];
    //由于是layout所以重绘来获取frame
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.layer.shadowColor=[shadowColor colorWithAlphaComponent:0.7].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
    self.layer.shadowOpacity = 1;//不透明度
    self.layer.shadowRadius = 5;//半径    
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#5AADFF"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#3399FF"].CGColor];
    gradientLayer.locations = @[@0.5, @1.0];//渐变颜色区域
    //渐变角度
    gradientLayer.startPoint = CGPointMake(0, 0);//左上角
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);//右下角
    gradientLayer.frame = CGRectMake(0, 0,  self.bounds.size.width, self.bounds.size.height);
    gradientLayer.cornerRadius = self.bounds.size.height/2;
    [self.layer addSublayer:gradientLayer];
    
}

@end
