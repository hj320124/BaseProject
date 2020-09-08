//
//  PPTabBar.h
//  PhoenixBookPub
//
//  Created by imac2015-2 on 2019/11/5.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPTabBar;
@protocol PPTabBarDelegate <NSObject>
@optional

- (void)tabBar:(PPTabBar *)tabBar didClickButton:(int)index;

- (void)tabBardidClickMusicButton:(UIButton *)rideBtn;

@end

@interface PPTabBar : UIView

@property (nonatomic,strong) NSArray *items;//保存按钮的对象模型
//音乐按钮
@property (nonatomic,strong) UIButton *musicBtn;

@property (nonatomic,strong) NSMutableArray *buttons;

@property (nonatomic,weak) id<PPTabBarDelegate>delegate;

@property (nonatomic,strong) UIImageView *musicBgView;


- (void)BtnClick:(UIButton *)btn;
/**
 更新播放按钮的图片
 @param photoStr 图片的地址
 */
- (void)updateMusicBtnImage:(NSString *)photoStr;

/// 更新播放按钮状态
- (void)updateMusicBtnState;

///  更新进度条
- (void)updateProgressView;
@end

