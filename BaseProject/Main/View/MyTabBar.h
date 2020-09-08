//
//  MyTabBar.h
//  Etrotek biker
//
//  Created by hj on 2017/6/2.
//  Copyright © 2017年 顾洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;
@protocol MyTabBarDelegate <NSObject>
@optional
-(void)tabBar:(MyTabBar *)tabBar didClickButton:(int)index;
-(void)tabBardidClickRideButton:(MyTabBar*)rideBtn;

@end

@interface MyTabBar : UIView

@property (nonatomic,strong)NSArray *items;//保存按钮的对象模型

@property (nonatomic,strong)NSMutableArray *buttons;
@property (nonatomic,weak)id<MyTabBarDelegate>delegate;

-(void)BtnClick:(UIButton*)btn;
@end
