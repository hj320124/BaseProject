//
//  PPTabBarController.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//  自定义TabbarCongtoller

#import <UIKit/UIKit.h>
@class PPTabBar;
NS_ASSUME_NONNULL_BEGIN

@interface PPTabBarController : UITabBarController

@property(nonatomic,strong)PPTabBar *myBar;

@property(nonatomic,assign)NSInteger willSelectIndex; //上个页面的index

/// 跳转任意一个控制器
/// @param index tabbar控制器的index
- (void)pushToOneTab:(NSInteger)index;
/// 更新播放按钮的图片
/// @param urlStr 图片url
- (void)updateMusicBtnImageWithUrlStr:(NSString *)urlStr;
/// 更新播放按钮的状态
- (void)updateMusicBtnState;

@end

NS_ASSUME_NONNULL_END
