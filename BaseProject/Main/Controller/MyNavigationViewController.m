  //
//  MyNavigationViewController.m
//  Etrotek biker
//
//  Created by hj on 2017/6/2.
//  Copyright © 2017年 顾洲. All rights reserved.
//

#import "MyNavigationViewController.h"
//#import "UIBarButtonItem+Item.h"
#import "AppDelegate.h"
//#import "AppColor.h"
#import "UINavigationController+SJVideoPlayerAdd.h"
#import <objc/message.h>

#define ATKeyWindow     [[UIApplication sharedApplication] keyWindow]
#define ATNavViewW      [UIScreen mainScreen].bounds.size.width

#define ATAnimationDuration     0.5f
#define ATMinX                  (0.3f * ATNavViewW)

#define enableDrag (!self.disableDragBack && self.viewControllers.count > 1 && !self.topViewController.disableDragBack)

typedef NS_ENUM(int, ATNavMovingStateEnumes) {
    ATNavMovingStateStanby = 0,
    ATNavMovingStateDragBegan,
    ATNavMovingStateDragChanged,
    ATNavMovingStateDragEnd,
    ATNavMovingStateDecelerating,
};

@interface MyNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    NSMutableDictionary *dic;
}
// navigation controller 最顶部的controller
@property (nonatomic, weak) UIViewController *activeVController;

/**
 *  黑色的蒙版
 */
@property (nonatomic, strong) UIView *lastScreenBlackMask;
/**
 *  显示上一个界面的截屏
 */
@property (nonatomic, strong) UIImageView *lastScreenShotView;
/**
 *  显示上一个界面的截屏黑色背景
 */
@property (nonatomic,retain) UIView *backgroundView;
/**
 *  存放截屏的字典数组 key：控制器指针字符串  value：截屏图片
 */
@property (nonatomic,retain) NSMutableDictionary *screenShotsDict;
/**
 *  正在移动
 */
@property (nonatomic,assign) ATNavMovingStateEnumes movingState;

@end

@implementation MyNavigationViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.navigationBar.barTintColor=[UIColor grayColor];
//    dic=[NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName]=[UIColor redColor];
//    dic[NSFontAttributeName]=[UIFont systemFontOfSize:20];
//    self.navigationBar.titleTextAttributes=dic;
//    self.navigationBar.tintColor=[UIColor blackColor];
//    self.navigationBar.backIndicatorImage=nil;
//    self.navigationBar.backIndicatorTransitionMaskImage=nil;
//    self.interactivePopGestureRecognizer.enabled=NO;
//    self.navigationBar.translucent = NO;
//}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    //屏幕将要转到时执行
//    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {  //如果是模向时执行啥事件
//        // 重新加载一个view文件
//        NSLog(@"cccccccccccccccccccc");
//        
//        [UIView animateWithDuration:0.2f animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(M_PI*2);
//            self.view.bounds = CGRectMake(0, 0, WIDTH, HEIGHT);
//        }];
//        
//        
//    }else {
//        
//        //如果是纵向时执行啥事件
//        // 重新加载一个View文件
//        [UIView animateWithDuration:0.2f animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(90 * M_PI/180.0);
//            self.view.bounds = CGRectMake(0, -((self.view.frame.size.height - self.view.frame.size.width)/4), WIDTH, HEIGHT);
//        }];
//        NSLog(@"kkkkkkkkkkkkkkkkkkkkk");
//        
//        
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
#pragma mark -  拦截所有push方法
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//      [super pushViewController:viewController animated:YES];
////    NSLog(@"-----====拦截到了====nsl");
//    
//        if (self.viewControllers.count >1) {
//            // 如果navigationController的字控制器个数大于两个就隐藏
//            viewController.tabBarController.hidesBottomBarWhenPushed = YES;
////            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage hj_imageWithFloder:Common Named:@"fanhui"] highImage:[UIImage hj_imageWithFloder:Common Named:@"fanhui"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside]  ;
//        }
//    
//    
//    
//    }

    
//-(UIViewController*)popViewControllerAnimated:(BOOL)animated
//{
//
//    UIViewController *vc=[super popViewControllerAnimated:animated];
//
////    NSLog(@"%@")
//
//    if (self.viewControllers.count >1) {
//        // 如果navigationController的字控制器个数大于两个就隐藏
//        vc.tabBarController.hidesBottomBarWhenPushed = YES;
//
//    }
//    else
//    {
//        vc.tabBarController.hidesBottomBarWhenPushed=NO;
//
//    }
//
//
//
//    return vc;
//
//}
-(void)back
{
    [self popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        //self.interactivePopGestureRecognizer.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 为导航控制器view，添加拖拽手手势
    self.sj_backgroundColor = [UIColor whiteColor];
    self.sj_transitionMode = SJScreenshotTransitionModeShifting;
    self.sj_gestureType = SJFullscreenPopGestureType_Full;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count == 1) {
        self.activeVController = nil;
    } else {
        self.activeVController = viewController;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.activeVController == self.topViewController);
    }
    return YES;
}

#pragma mark - statusbar & Orientations
- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}




@end
