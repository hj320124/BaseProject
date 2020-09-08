//
//  TabbarViewController.m
//  Etrotek biker
//
//  Created by hj on 2017/6/2.
//  Copyright © 2017年 顾洲. All rights reserved.
//

#import "TabbarViewController.h"
#import "MyNavigationViewController.h"
#import "MytabBarButton.h"
#import "MyTabBar.h"
#import "FrameObjet.h"
#import "DWHomeViewController.h"
#import "DWMineViewController.h"
#import "DWSameFityViewController.h"
#import "DWMessageViewController.h"

static  const NSValue *fameValue;


@interface TabbarViewController ()<MyTabBarDelegate>
{
    NSValue *frameValue;
}
@property(nonatomic ,strong)NSMutableArray *items;


@end

@implementation TabbarViewController



-(NSMutableArray *)items
{
    if (_items==nil) {
        _items=[[NSMutableArray alloc] init];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self addAllSubController];
    
    
    
//    [self loadUserData];
//    [self timerMethodC];
    
//改变系统自带tabBar的颜色
   
    
    [[UITabBarItem
     appearance] setTitleTextAttributes:[NSDictionary
                                         dictionaryWithObjectsAndKeys: [UIColor greenColor],
                                         UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    

    
    self.hidesBottomBarWhenPushed=NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToOne) name:@"change" object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToOne) name:@"turnToHomePage" object:nil];
    
    
}



-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    if (!_TabBar) {
//        [self setUpTabBar];
//    }
   
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:frameValue forKey:@"frameValue"];

    self.tabBar.hidden=YES;

}

//移除系统自带的tabBarButton
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.moveMentVc.navigationController.navigationBar.hidden = false;
//    self.myVc.navigationController.navigationBar.hidden = false;
//    _TabBar.hidden = NO;
//    NSLog(@"-0000000-");
//    for (UIView *tabBarBUtton in self.tabBar.subviews) {
//        if ([tabBarBUtton isKindOfClass:NSClassFromString(@"tabBarButton")]) {
//            [tabBarBUtton removeFromSuperview];
//
//        }
//    }
    
//    [self.tabBar removeFromSuperview];
    
//    if (!_TabBar) {
//        [self setUpTabBar];
//
//    }
//
//    NSLog(@"viewWillAppear");
//
//     [self.tabBar removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSValue *value=[FrameObjet shareSingle].frameValue;
////
    
    
    self.TabBar.frame=self.tabBar.frame;
    
    //NSLog(@"%@ggg",self.TabBar);
    
  //NSLog(@"viewDidAppear");
    
//    
}







-(instancetype)init
{
    if (self=[super init]) {

        [self setUpTabBar];
       
    }

    return self;
}



// 添加子控制器
- (void) addAllSubController{
    
    
    [self addOneSubController:[DWHomeViewController new] image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_highlight" ] title:@"首页"];
    
    [self addOneSubController:[DWSameFityViewController new] image:[UIImage imageNamed:@"mycity_normal"] selectedImage:[UIImage imageNamed:@"mycity_highlight" ] title:@"定位"];
    
     [self addOneSubController:[DWMineViewController new] image:[UIImage imageNamed:@"account_normal"] selectedImage:[UIImage imageNamed:@"account_highlight" ] title:@"我的"];
    
    [self addOneSubController:[DWMessageViewController new] image:[UIImage imageNamed:@"message_normal"] selectedImage:[UIImage imageNamed:@"message_highlight" ] title:@"消息"];
    


}

// 设置一个子控制器

- (void) addOneSubController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    vc.view.frame=self.view.bounds;
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
//    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -10);
    [self.items addObject:vc.tabBarItem];

    MyNavigationViewController *nav = [[MyNavigationViewController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    
}

-(void)setUpTabBar
{
  // [self.tabBar removeFromSuperview];
   MyTabBar *tabBar=[[MyTabBar alloc] initWithFrame:self.tabBar.frame];
    //NSLog(@"gggggg%@",self.tabBar);
   
    tabBar.backgroundColor=[UIColor  colorWithRed:123/255.0 green:22/255.0 blue:42/255.0 alpha:1];
//    tabBar.
    [self.view addSubview:tabBar];
    
    tabBar.delegate=self;
    tabBar.items=self.items;
    _TabBar=tabBar;
    
    
}

//实现代理方法
-(void)tabBar:(MyTabBar*)tabBar didClickButton:(int)index;
{
    self.selectedIndex=index;
}


-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    //NSLog(@"-----====隐藏tabbar-------====");
    _TabBar.hidden=hidesBottomBarWhenPushed;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
@end
