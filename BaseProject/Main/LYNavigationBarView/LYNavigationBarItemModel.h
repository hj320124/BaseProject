//
//  LYNavigationBarItemModel.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2020/6/24.
//  Copyright © 2020 PPMG. All rights reserved.
//  导航栏上的按钮

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYNavigationBarItemModel : NSObject

/// 按钮图标名
@property (nonatomic, copy, nullable) NSString *imageName;

/// 按钮文字
@property (nonatomic, copy, nullable) NSString *title;

/// 按钮图标
@property (nonatomic, strong) UIImage *image;

/// 是否是左侧按钮
@property (nonatomic, assign) BOOL isLeft;

/// 创建模型
/// @param imageName 图标名称
/// @param title 标题
/// @param isLeft 是否是左按钮
+ (LYNavigationBarItemModel *)modelWithImageName:(NSString * __nullable)imageName
                                           title:(NSString * __nullable)title
                                          isLeft:(BOOL)isLeft;

/// 创建左按钮图标模型
/// @param leftImgName 左图标名
+ (LYNavigationBarItemModel *)modelWithLeftImgName:(NSString *)leftImgName;

/// 创建右按钮图标模型
/// @param rightimgName 右图标名
+ (LYNavigationBarItemModel *)modelWithRightImgName:(NSString *)rightimgName;

/// 创建左按钮标题模型
/// @param leftTitle 左标题名
+ (LYNavigationBarItemModel *)modelWithLeftTitle:(NSString *)leftTitle;

/// 创建右按钮标题模型
/// @param rightTitle 右标题名
+ (LYNavigationBarItemModel *)modelWithRightTitle:(NSString *)rightTitle;

@end

NS_ASSUME_NONNULL_END
