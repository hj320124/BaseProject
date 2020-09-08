//
//  UIImage+LYUtil.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/21.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "UIImage+LYUtil.h"

@implementation UIImage (LYUtil)

+ (UIImage*)getColorImageWith:(UIColor *)color size:(CGSize)size {
    // 开始绘制指定大小的图片
    UIGraphicsBeginImageContext(size);
    // 注入颜色
    [color setFill];
    // 设定大小
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    // 开始绘制
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 绘制结束
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)getNavigaitonBarClearBgImage {
    return [UIImage getColorImageWith:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]
                                 size:[UIScreen mainScreen].bounds.size];
}

+ (UIImage *)grayImage:(UIImage*)originImage {
    // 1.将UIImage转化为CIImage
    CIImage *image = [CIImage imageWithCGImage:originImage.CGImage];
    // 2.初始化滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@(0) forKey:@"inputBrightness"];// 亮度
    [filter setValue:@(0) forKey:@"inputSaturation"];// 饱和度
    [filter setValue:@(0.5) forKey:@"inputContrast"];// 对比度
    // 3.初始化上下文对象
    CIContext *context = [CIContext contextWithOptions:nil];
    // 4.初始化一个图片输出对象
    CGImageRef imageRef = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    // 5.生成一个UIImage
    UIImage *newImage = [UIImage imageWithCGImage:imageRef
                                            scale:originImage.scale
                                      orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return newImage;
}

@end
