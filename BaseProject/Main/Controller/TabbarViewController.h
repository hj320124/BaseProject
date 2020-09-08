//
//  TabbarViewController.h
//  Etrotek biker
//
//  Created by hj on 2017/6/2.
//  Copyright © 2017年 顾洲. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MyTabBar.h"



@interface TabbarViewController : UITabBarController
@property(nonatomic,strong)MyTabBar *TabBar;
@property(nonatomic,assign)CGRect TababrFrame;


-(void)setUpTabBar;
@end
