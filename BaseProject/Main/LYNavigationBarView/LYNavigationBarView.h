//
//  LYNavgationBarView.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/20.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LYNavigationBarView;
@protocol LYNavigationBarViewDelegate <NSObject>

@optional
/**
 点击自定义导航栏左按钮

 @param navigationBarView 自定义导航栏
 @param sender 左按钮
 */
-(void)navigationBarView:(LYNavigationBarView*)navigationBarView didSelectLeftButton:(UIButton*)sender;
/**
 点击自定义导航栏右按钮

 @param navigationBarView 自定义导航栏
 @param sender 右按钮
 */
-(void)navigationBarView:(LYNavigationBarView*)navigationBarView didSelectRightButton:(UIButton*)sender;


/// 点击自定义导航栏左按钮（根据下标，从左往右，index增大）
/// @param navigationBarView 自定义导航栏
/// @param index 下标
- (void)navigationBarView:(LYNavigationBarView *)navigationBarView didSelectLeftBarItemWithIndex:(NSInteger)index;

/// 点击自定义导航栏右按钮（根据下标，从右向左，index增大）
/// @param navigationBarView 自定义导航栏
/// @param index 下标
- (void)navigationBarView:(LYNavigationBarView *)navigationBarView didSelectRightBarItemWithIndex:(NSInteger)index;

@end

@interface LYNavigationBarView : UIView

/// 导航栏背景图片
@property (nonatomic, copy) NSString *backgroundImage;

/// 隐藏自定义导航栏下的横线，默认为NO
@property (nonatomic, assign)BOOL hideLine;

/// 横线颜色透明度
@property (nonatomic, assign) CGFloat lineAlpha;

/// 导航栏左返回按钮图片
@property (nonatomic, copy) NSString *backImage;

/// 右侧按钮图片
@property (nonatomic, copy) NSString *rightImage;

/// 导航栏标题
@property (nonatomic, copy) NSString *titleText;

/// 文字颜色
@property (nonatomic, strong) UIColor *titleColor;

/// 隐藏导航栏标题，默认不隐藏
@property (nonatomic, assign) BOOL hideTitle;

/// 右侧按钮
@property (nonatomic, strong) UIButton *rightButton;

/// 代理
@property (nonatomic, weak) id <LYNavigationBarViewDelegate> delegate;

/**
 通用样式导航栏(同系统导航栏大小)

 @param barTitle 导航栏标题
 @param leftTitle 导航栏左按钮标题
 @param leftImage 导航栏左按钮图标
 @param rightTitle 导航栏右按钮标题
 @param rightImage 导航栏右按钮图标
 @return 自定义通用样式导航栏
 */
+ (LYNavigationBarView *)createGeneralNavigationBarViewWithBarTitle:(NSString * __nullable)barTitle
                                                          leftTitle:(NSString * __nullable)leftTitle
                                                          leftImage:(NSString * __nullable)leftImage
                                                         rightTitle:(NSString * __nullable)rightTitle
                                                         rightImage:(NSString * __nullable)rightImage;

/**
 初始化自定义导航栏
 
 @param frame 导航栏frame
 @param barTitle 导航栏标题
 @param leftTitle 导航栏左按钮标题
 @param leftImage 导航栏左按钮图标
 @param rightTitle 导航栏右按钮标题
 @param rightImage 导航栏右按钮图标
 @return 自定义样式导航栏
 */
- (instancetype)initWithFrame:(CGRect)frame
                     barTitle:(NSString * __nullable)barTitle
                    leftTitle:(NSString * __nullable)leftTitle
                    leftImage:(NSString * __nullable)leftImage
                   rightTitle:(NSString * __nullable)rightTitle
                   rightImage:(NSString * __nullable)rightImage;

/// 添加
/// @param rightTitle 右侧图标标题
/// @param rightImage 右侧图标标题图片
- (void)addRightButtonItem:(NSString *)rightTitle
                rightImage:(NSString *)rightImage;

/// 当页面上下滚动时改变自身颜色透明度
/// @param alpha 透明度
- (void)pageScrollToChangeColorAlpha:(CGFloat)alpha;

#pragma mark -- 新增方法

/// 左侧按钮组（index从小到大，icon从左到右）
@property (nonatomic, strong) NSArray *leftItems;

/// 右侧按钮组（index从小到大，icon从右到左）
@property (nonatomic, strong) NSArray *rightItems;

/// 初始化同系统导航栏大小的导航栏
/// @param title 导航栏标题
/// @param leftBarItemArray 左侧按钮组
/// @param rightBarItemArray 右侧按钮组
+ (LYNavigationBarView *)createSystemStyleBarWithTitle:(NSString * __nullable)title
                                      leftBarItemArray:(NSArray <LYNavigationBarItemModel *> * __nullable)leftBarItemArray
                                     rightBarItemArray:(NSArray <LYNavigationBarItemModel *> * __nullable)rightBarItemArray;

/// 初始化自定义大小的导航栏
/// @param frame 尺寸
/// @param title 导航栏标题
/// @param leftBarItemArray 左侧按钮组
/// @param rightBarItemArray 右侧按钮组
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString * __nullable)title
             leftBarItemArray:(NSArray <LYNavigationBarItemModel *> * __nullable)leftBarItemArray
            rightBarItemArray:(NSArray <LYNavigationBarItemModel *> * __nullable)rightBarItemArray;

@end

NS_ASSUME_NONNULL_END
