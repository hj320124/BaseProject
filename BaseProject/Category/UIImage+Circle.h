//
//  UIImage+Circle.h
//  SuningEBuy
//
//  Created by songzhanglong on 2017/12/4.
//  Copyright © 2017年 苏宁易购. All rights reserved.
//  圆角图片，旋转后的图片

#import <UIKit/UIKit.h>

@interface UIImage (Circle)

+ (UIImage *)getImageFromView:(UIView *)theView;

#pragma mark - 边框圆角绘制
/**
 边框圆角绘制
 
 @param size 尺寸大小
 @param strokeColor 边框颜色
 @return 图片
 */
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor;

/**
 边框圆角绘制
 
 @param size 尺寸大小
 @param strokeColor 边框颜色
 @param lineWidth 线宽
 @return 图片
 */
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth;

/**
 边框圆角绘制
 
 @param size 尺寸大小
 @param strokeColor 边框颜色
 @param cornerRadius 角度
 @return 图片
 */
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor cornerRadius:(CGFloat)cornerRadius;


/**
 边框圆角绘制

 @param size 尺寸大小
 @param strokeColor 边框颜色
 @param lineWidth 线宽
 @param cornerRadius 角度
 @return 图片
 */
+ (UIImage *)drawBorderImage:(CGSize)size strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 圆角纯色背景
/**
 圆角纯色背景绘制
 
 @param size 大小
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawCircleImage:(CGSize)size fillColor:(UIColor *)fillColor;

/**
 圆角纯色背景绘制
 
 @param size 大小
 @param strokeColor 线条颜色
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;

/**
 圆角纯色背景绘制
 
 @param size 大小
 @param strokeColor 线条颜色
 @param fillColor 填充色
 @param lineWidth 线宽
 @return 图片
 */
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth;

/**
 圆角纯色背景绘制
 
 @param size 大小
 @param strokeColor 线条颜色
 @param fillColor 填充色
 @param lineWidth 线宽
 @param cornerRadius 圆角大小
 @return 图片
 */
+ (UIImage *)drawCircleImage:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

/**
 绘制圆角矩形
 
 @param size 画布大小
 @param borderColor 边缘颜色
 @param borderRadius 圆角半径
 @param borderWidth 线宽
 @param margin 上下左右间距
 */
+ (instancetype)roundRectImageWithFrame:(CGSize)size
                            borderColor:(UIColor *)borderColor
                              fillColor:(UIColor *)fillColor
                           borderRadius:(CGFloat)borderRadius
                            borderWidth:(CGFloat)borderWidth
                                 margin:(CGFloat)margin;

/**
 头部圆角图片

 @param size 区域大小
 @param fillColor 填充色
 @param cornerRadius 角度
 @return 图片
 */
+ (UIImage *)drawTopCircleImage:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius;

/**
 左，下圆角图片
 
 @param size 区域大小
 @param fillColor 填充色
 @param cornerRadius 角度
 @return 图片
 */
+ (UIImage *)drawThreeCircleImage:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 图片旋转
/**
 旋转图片

 @param orientation 角度
 @return 旋转后的新图片
 */
- (UIImage *)imageWithrotation:(UIImageOrientation)orientation;

#pragma mark - 带小三角矩形与不带小三角矩形
/**
 下边带小三角矩形

 @param size 尺寸
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawRectTrangle:(CGSize)size fillColor:(UIColor *)fillColor;

/**
 矩形，下边留2个像素

 @param size 尺寸
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawRect:(CGSize)size fillColor:(UIColor *)fillColor;

#pragma mark - 绘制齿轮
/**
 绘制齿轮

 @param size 总大小
 @param width 每个小齿轮宽度
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawGearRect:(CGSize)size itemWidth:(CGFloat)width fillColor:(UIColor *)fillColor;

#pragma mark - 绘制身边苏宁标题图片
/**
 绘制身边苏宁标题图片

 @param size 区域
 @param fillColor 填充色
 @return 图片
 */
+ (UIImage *)drawTwoArcRect:(CGSize)size fillColor:(UIColor *)fillColor;

#pragma mark - 单边圆角
/**
 单边圆角

 @param size 尺寸
 @param strokeColor 线条颜色
 @param fillColor 填充色
 @param lineWidth 线宽
 @param typeIdx 圆角位置索引 0-左边，1-无圆角，2右边
 @return UIImage
 */
+ (UIImage *)drawSingleCircle:(CGSize)size strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth circleType:(NSInteger)typeIdx;

@end
