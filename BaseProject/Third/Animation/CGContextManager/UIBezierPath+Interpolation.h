//
//  UIBezierPath+Interpolation.h
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//  贝塞尔曲线分类

// https://spin.atomicobject.com/2014/05/28/ios-interpolating-points/
// https://github.com/jnfisher/ios-curve-interpolation

#import <UIKit/UIKit.h>

@interface UIBezierPath (Interpolation)

// pointsAsNSValues must be NSValue objects containing CGPoints.
//
// ex:
//     const char *encoding = @encode(CGPoint);
//     NSValue *pointAsValue = [NSValue valueWithBytes:&cgPoint objCType:encoding];

// 0.0 <= alpha <= 1.0
//插值算法
+(UIBezierPath *)interpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha;
//艾米插值
+(UIBezierPath *)interpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed;

@end
