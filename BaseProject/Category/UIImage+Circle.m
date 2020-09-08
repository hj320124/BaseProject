//
//  UIImage+Circle.m
//  SuningEBuy
//
//  Created by songzhanglong on 2017/12/4.
//  Copyright © 2017年 苏宁易购. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)

+ (UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, 2);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 边框圆角绘制
//边框圆角绘制
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor {
    return [UIImage drawBorderImage:size strokeColor:strokeColor lineWidth:1];
}

//边框圆角绘制
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth {
    return [UIImage drawBorderImage:size strokeColor:strokeColor lineWidth:lineWidth cornerRadius:2];
}

//边框圆角绘制
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor cornerRadius:(CGFloat)cornerRadius {
    return [UIImage drawBorderImage:size strokeColor:strokeColor lineWidth:1 cornerRadius:cornerRadius];
}

//边框圆角绘制
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(lineWidth, lineWidth, size.width - lineWidth * 2, size.height - lineWidth * 2) cornerRadius:cornerRadius];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark - 圆角纯色背景
//圆角纯色背景绘制
+ (UIImage *)drawCircleImage:(CGSize)size fillColor:(UIColor *)fillColor {
    return [self drawCircleImage:size strokeColor:[UIColor clearColor] fillColor:fillColor];
}

//圆角纯色背景绘制
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor {
    return [UIImage drawCircleImage:size strokeColor:strokeColor fillColor:fillColor lineWidth:0.5];
}

//圆角纯色背景绘制
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth {
    return [UIImage drawCircleImage:size strokeColor:strokeColor fillColor:fillColor lineWidth:lineWidth cornerRadius:2];
}

//圆角纯色背景绘制
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(roundf(lineWidth / 2), roundf(lineWidth / 2), size.width - lineWidth - 0.5, size.height - lineWidth - 0.5) cornerRadius:cornerRadius];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

+ (instancetype)roundRectImageWithFrame:(CGSize)size
                            borderColor:(UIColor *)borderColor
                              fillColor:(UIColor *)fillColor
                           borderRadius:(CGFloat)borderRadius
                            borderWidth:(CGFloat)borderWidth
                                 margin:(CGFloat)margin
{
    CGFloat x = size.width;
    CGFloat y = size.height;
    CGFloat radius = borderRadius - margin;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor (context,  1.0, 1.0, 1.0, 1.0);//设置填充颜色(白色)
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetLineWidth(context, borderWidth);//线的宽度
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);//线框颜色
    //绘制path 方法1
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth/2 +margin,borderWidth/2 +margin, x - borderWidth - margin*2, y - borderWidth - margin*2)cornerRadius:radius].CGPath;
    CGContextAddPath(context, clippath);
    //填充
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//头部圆角图片
+ (UIImage *)drawTopCircleImage:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, 0, cornerRadius);
    CGContextAddArcToPoint(context, 0, 0, cornerRadius, 0, cornerRadius);
    CGContextAddLineToPoint(context, size.width - cornerRadius, 0);
    CGContextAddArcToPoint(context, size.width, 0, size.width, cornerRadius, cornerRadius);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0, cornerRadius);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

//左，下圆角图片
+ (UIImage *)drawThreeCircleImage:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, 0, cornerRadius);
    CGContextAddArcToPoint(context, 0, 0, cornerRadius, 0, cornerRadius);
    CGContextAddLineToPoint(context, size.width, 0);
    CGContextAddLineToPoint(context, size.width, size.height - cornerRadius);
    CGContextAddArcToPoint(context, size.width, size.height, size.width - cornerRadius, size.height, cornerRadius);
    CGContextAddLineToPoint(context, cornerRadius, size.height);
    CGContextAddArcToPoint(context, 0, size.height, 0, size.height - cornerRadius, cornerRadius);
    CGContextAddLineToPoint(context, 0, cornerRadius);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark - 图片旋转
- (UIImage *)imageWithrotation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
        {
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width / rect.size.height;
            scaleX = rect.size.height / rect.size.width;
        }
            break;
        case UIImageOrientationRight:
        {
            rotate = -M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width / rect.size.height;
            scaleX = rect.size.height / rect.size.width;
        }
            break;
        case UIImageOrientationDown:
        {
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
        }
            break;
        default:
        {
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
        }
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

#pragma mark - 带小三角矩形与不带小三角矩形
//下边带小三角矩形
+ (UIImage *)drawRectTrangle:(CGSize)size fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetLineWidth(context, 0);
    
    CGPoint sPoints[7];//坐标点
    sPoints[0] = CGPointMake(0, 0);
    sPoints[1] = CGPointMake(size.width, 0);
    sPoints[2] = CGPointMake(size.width, size.height - 5);
    sPoints[3] = CGPointMake((size.width - 8) / 2 + 8, size.height - 5);
    sPoints[4] = CGPointMake(size.width / 2 , size.height);
    sPoints[5] = CGPointMake((size.width - 8) / 2, size.height - 5);
    sPoints[6] = CGPointMake(0, size.height - 5);
    CGContextAddLines(context, sPoints, 7);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

//矩形，下边留2个像素
+ (UIImage *)drawRect:(CGSize)size fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetLineWidth(context, 0);
    
    CGPoint sPoints[4];//坐标点
    sPoints[0] = CGPointMake(0, 0);
    sPoints[1] = CGPointMake(size.width, 0);
    sPoints[2] = CGPointMake(size.width, size.height - 5);
    sPoints[3] = CGPointMake(0, size.height - 5);
    CGContextAddLines(context, sPoints, 4);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark - 绘制齿轮
+ (UIImage *)drawGearRect:(CGSize)size itemWidth:(CGFloat)width fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    
    NSInteger numOfGear = (size.width - width) / width * 2;
    NSInteger i = 0;
    while (i < numOfGear + 1) {
        CGPoint sPoints[3];
        if (i == 0) {
            sPoints[0] = CGPointMake(0, 0);
            sPoints[1] = CGPointMake(0, size.height);
            sPoints[2] = CGPointMake(width, size.height);
        } else {
            CGFloat xOri = width + width * 2 * (i - 1);
            sPoints[0] = CGPointMake(xOri, size.height);
            sPoints[1] = CGPointMake(xOri + width, 0);
            sPoints[2] = CGPointMake(xOri + width * 2, size.height);
        }
        
        CGContextAddLines(context, sPoints, 3);
        i++;
    }
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark - 绘制身边苏宁标题图片
+ (UIImage *)drawTwoArcRect:(CGSize)size fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, 0, size.height);
    CGFloat radius = 4;
    CGContextAddArcToPoint(context, radius, size.height, radius, size.height - radius, radius);
    CGContextAddLineToPoint(context, radius + 10, 0);
    CGContextAddLineToPoint(context, size.width - radius - 10, 0);
    CGContextAddLineToPoint(context, size.width - radius, size.height - radius);
    CGContextAddArcToPoint(context, size.width - radius, size.height, size.width, size.height, radius);
    CGContextAddLineToPoint(context, 0, size.height);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark - 单边圆角
+ (UIImage *)drawSingleCircle:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth circleType:(NSInteger)typeIdx {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    
    CGFloat radius = size.height / 2;
    CGContextMoveToPoint(context, radius, 0);
    
    //左边圆角判断
    if (typeIdx == 0) {
        CGContextAddArcToPoint(context, 0, 0, 0, radius, radius);
        CGContextAddLineToPoint(context, 0, size.height - radius);
        CGContextAddArcToPoint(context, 0, size.height, radius, size.height, radius);
    } else {
        CGContextAddLineToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, size.height);
    }
    
    //右边圆角判断
    if (typeIdx == 2) {
        CGContextAddArcToPoint(context, size.width, size.height, size.width, size.height - radius, radius);
        CGContextAddLineToPoint(context, size.width, radius);
        CGContextAddArcToPoint(context, size.width, 0, size.width - radius, 0, radius);
    } else {
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, size.width, 0);
    }
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

@end
