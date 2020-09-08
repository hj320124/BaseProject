//
//  UIViewController+LYUtil.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/20.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LYUtil)<LYNavigationBarViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)LYNavigationBarView * customNavigationBarView;

/**
 通用导航栏

 @param barTitle 导航栏标题
 @param leftTitle 左按钮标题
 @param leftImage 左按钮图标
 @param rightTitle 右按钮标题
 @param rightImage 右按钮图标
 */
-(void)setupNormalNavigationBarViewWithBarTitle:(NSString * __nullable)barTitle
                                      leftTitle:(NSString * __nullable)leftTitle
                                      leftImage:(NSString * __nullable)leftImage
                                     rightTitle:(NSString * __nullable)rightTitle
                                     rightImage:(NSString * __nullable)rightImage;

/**
 二级页面带返回按钮导航栏

 @param barTitle 导航栏标题
 */
-(void)setupNormalNavigationBarViewBackStyleWithBarTitle:(NSString * __nullable)barTitle;

/**
 一级页面导航栏

 @param barTitle 导航栏标题
 */
-(void)setupNormalNavigationBarViewWithBarTitle:(NSString * __nullable)barTitle;

/// 自定义导航栏（左右按钮都是图标）
/// @param title 标题
/// @param leftImages 左侧按钮图标数组
/// @param rightImages 右侧按钮图标数组
- (void)setupSystemStyleNavigationBarViewWithTitle:(NSString *)title
                                        leftImages:(NSArray *)leftImages
                                       rightImages:(NSArray *__nullable)rightImages;

/**
 使用系统相册服务
 */
-(void)useSystemPhotoAlbumSever;

/**
 添加系统通用样式弹窗（左取消，右确定）

 @param title 标题
 @param message 提示信息
 @param handler 确认事件
 */
-(void)addNormalAlertWithTitle:(NSString*__nullable)title message:(NSString*)message handler:(void(^)(UIAlertAction * _Nonnull action))handler;

/**
 添加只有一个按钮的弹窗

 @param title 标题
 @param message 提示信息
 @param handler 确认事件
 */
- (void)addSingleAlertWithTitle:(NSString *__nullable)title message:(NSString *)message handler:(void (^)(UIAlertAction * _Nonnull action))handler;


/// 关闭播放器处理事件
- (void)handleAudioPlayerCloseAction;

/**
 移除废弃控制器

 @param range 移除范围
 */
-(void)removeDeprecatedViewController:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
