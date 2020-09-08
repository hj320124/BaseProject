//
//  PPNavigationController.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "PPNavigationController.h"
#import "PPTabBarController.h"

@interface PPNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation PPNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

+ (void)initialize {
    // 设置默认系统导航栏样式
//    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexStr:PPPrimaryColorValue],
//                                                         NSFontAttributeName:[UIFont systemFontOfSize:PPTitleFontValue]};
//    //自定义导航栏的返回按钮图片和背景图片
//    [[UINavigationBar appearance]setBackIndicatorImage:[UIImage imageNamed:@"icon_back_dark"]];
//    [[UINavigationBar appearance]setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back_dark"]];
//    //设置返回按钮标题偏移量使之看不到
//    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        // 重写push事件，隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 关于旋转的设置

@end
