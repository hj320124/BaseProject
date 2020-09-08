//
//  UIView+Shadow.m
//  SNEBook
//
//  Created by hj on 2018/5/9.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIView+Shadow.h"
#import <objc/runtime.h>
#import "UIColor+Hex.h"
#import "YYKit.h"

static const char *key="shadowColour";


@implementation UIView (Shadow)

-(UIColor*)shadowColor
{
    return objc_getAssociatedObject(self, key);
}

-(void)setShadowColor:(UIColor *)shadowColor
{
    objc_setAssociatedObject(self, key, shadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)BeShadow
{
    if (!self.shadowColor) {
        self.shadowColor=[UIColor colorWithHexString:@"#dad9da"];
    }
        //由于是layout所以重绘来获取frame
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
        self.layer.shadowPath=[UIBezierPath bezierPath].CGPath;
        //画一个阴影
        self.layer.shadowColor=self.shadowColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 4);//偏移距离
        self.layer.shadowOpacity = 1;//不透明度
        self.layer.shadowRadius = 3;//半径
        UIBezierPath *path=[UIBezierPath bezierPath];
        float width=self.bounds.size.width;
        float heigth=self.bounds.size.height;
        float x=self.bounds.origin.x;
        float y=self.bounds.origin.y;
        float addWH=6;
        CGPoint topleft=CGPointMake(x+3, y);
        CGPoint topMiddle=CGPointMake(x+width/2, y-addWH);
        CGPoint rightMiddle=CGPointMake(x+width-3, y+(heigth/2));
        CGPoint topRight=CGPointMake(x+width-3, y);
        CGPoint bottomRight=CGPointMake(x+width-3, y+heigth);
        CGPoint bottomMiddle=CGPointMake(x, y+heigth+addWH);
        CGPoint leftMiddle=CGPointMake(x+3, y+(heigth/2));
        CGPoint bottomLeft=CGPointMake(x, y+heigth);
        [path moveToPoint:topleft];
        [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
        [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
        [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
        [path addQuadCurveToPoint:topleft controlPoint:leftMiddle];
        self.layer.shadowPath=path.CGPath;
}
-(void)BeShadowWithOffSetX:(CGFloat)X OffsetY:(CGFloat)Y
{
    if (!self.shadowColor) {
        self.shadowColor=[UIColor colorWithHexString:@"#dad9da"];
    }
    //由于是layout所以重绘来获取frame
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    self.layer.shadowPath=[UIBezierPath bezierPath].CGPath;
    //画一个阴影
    self.layer.shadowColor=self.shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(X, Y);//偏移距离
    self.layer.shadowOpacity = 1;//不透明度
    self.layer.shadowRadius = 3;//半径
    UIBezierPath *path=[UIBezierPath bezierPath];
    float width=self.bounds.size.width;
    float heigth=self.bounds.size.height;
    float x=self.bounds.origin.x;
    float y=self.bounds.origin.y;
    float addWH=6;
    CGPoint topleft=CGPointMake(x, y);
    CGPoint topMiddle=CGPointMake(x+width/2, y-addWH);
    CGPoint rightMiddle=CGPointMake(x+width, y+(heigth/2));
    CGPoint topRight=CGPointMake(x+width, y);
    CGPoint bottomRight=CGPointMake(x+width, y+heigth);
    CGPoint bottomMiddle=CGPointMake(x, y+heigth+addWH);
    CGPoint leftMiddle=CGPointMake(x, y+(heigth/2));
    CGPoint bottomLeft=CGPointMake(x, y+heigth);
    [path moveToPoint:topleft];
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topleft controlPoint:leftMiddle];
    self.layer.shadowPath=path.CGPath;
}


-(void)BeShadowDiscoverWithOffSetX:(CGFloat)X OffsetY:(CGFloat)Y
{
    
    if (!self.shadowColor) {
        self.shadowColor=[UIColor colorWithHexString:@"#c7c7c7"];
    }
    //由于是layout所以重绘来获取frame
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
   
    self.layer.shadowPath=[UIBezierPath bezierPath].CGPath;
    //画一个阴影
    self.layer.shadowColor=self.shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(X, Y);//偏移距离
    self.layer.shadowOpacity = 0.5;//不透明度
    self.layer.shadowRadius = 6;//半径
    UIBezierPath *path=[UIBezierPath bezierPath];
    float width=self.bounds.size.width;
    float heigth=self.bounds.size.height;
    float x=self.bounds.origin.x;
    float y=self.bounds.origin.y;
    float addWH=6;
    CGPoint topleft=CGPointMake(x, y);
    CGPoint topMiddle=CGPointMake(x+width/2, y-addWH);
    CGPoint rightMiddle=CGPointMake(x+width, y+(heigth/2));
    CGPoint topRight=CGPointMake(x+width, y);
    CGPoint bottomRight=CGPointMake(x+width, y+heigth);
    CGPoint bottomMiddle=CGPointMake(x, y+heigth+addWH);
    CGPoint leftMiddle=CGPointMake(x, y+(heigth/2));
    CGPoint bottomLeft=CGPointMake(x, y+heigth);
    [path moveToPoint:topleft];
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topleft controlPoint:leftMiddle];
    self.layer.shadowPath=path.CGPath;
}
-(void)BeShadowDiscoverNew
{
    UIColor *shadowColor = [UIColor colorWithHexString:@"#C7C7C7"];
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 5.0;
    self.layer.cornerRadius = 8.0;
    [self.layer setShouldRasterize:YES];
    [self.layer setRasterizationScale:[UIScreen mainScreen].scale];

}


-(void)buttonShadowNew
{
    UIColor *shadowColor = [UIColor colorWithHexString:@"#A6CBED"];
    //由于是layout所以重绘来获取frame
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
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


-(void)buttonShadowLeftAndRight
{
//    UIColor *shadowColor = [UIColor colorWithHexString:@"#A6CBED"];
    //由于是layout所以重绘来获取frame
    if (self.width==0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
//    self.layer.shadowColor=[shadowColor colorWithAlphaComponent:0.7].CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
//    self.layer.shadowOpacity = 1;//不透明度
//    self.layer.shadowRadius = 5;//半径
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FFE1B4"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#E0A754"].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];//渐变颜色区域
    //渐变角度
    gradientLayer.startPoint = CGPointMake(0, 1);//左上角
    gradientLayer.endPoint = CGPointMake(1, 1.0);//右下角
    gradientLayer.frame = CGRectMake(0, 0,  self.bounds.size.width, self.bounds.size.height);
    gradientLayer.cornerRadius = self.bounds.size.height/2;
    [self.layer addSublayer:gradientLayer];
}

@end
