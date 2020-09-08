//
//  UIImage+LYUtil.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/21.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYUtil)

/// 获取有色图片
/// @param color 图片颜色
/// @param size 图片大小
+ (UIImage*)getColorImageWith:(UIColor *)color size:(CGSize)size;

/// 绘制导航栏透明图片
+ (UIImage*)getNavigaitonBarClearBgImage;

/// 灰白图片
/// @param originImage 原始图片
+ (UIImage *)grayImage:(UIImage*)originImage;

@end

NS_ASSUME_NONNULL_END
