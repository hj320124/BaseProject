//
//  UIFont+LYUtil.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/19.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (LYUtil)

/**
 设置字体(block点语法，传值字体大小)
 */
+(UIFont*(^)(CGFloat fontSize))systemFont;

/**
 设置粗体字体(block点语法，传值字体大小)
 */
+(UIFont * _Nonnull (^)(CGFloat))boldSystemFont;

+ (UIFont * _Nonnull (^) (CGFloat))pingFangFont;

@end

NS_ASSUME_NONNULL_END
