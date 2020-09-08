//
//  PPTabBarController.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "PPTabBarController.h"
#import "PPNavigationController.h"
#import "PPTabBar.h"

@interface PPTabBarController ()<PPTabBarDelegate>

@property (nonatomic, strong)NSMutableArray *metaData;

@property (nonatomic, strong)NSMutableArray *items;

@end

@implementation PPTabBarController

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

+ (void)initialize{
}

- (instancetype)init {
    
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 ///适配ios13的tabbar属性
    if(@available(iOS 13.0, *)) {
        UITabBarAppearance* tabbarAppearance = [self.tabBar.standardAppearance copy ];
        tabbarAppearance.backgroundImage = [UIImage imageNamed:@"icon_tabbar_translucent"];
        tabbarAppearance.backgroundColor = [UIColor clearColor];
        tabbarAppearance.backgroundEffect = nil;
        tabbarAppearance.shadowImage = [UIImage imageNamed:@"icon_tabbar_translucent"];
        tabbarAppearance.shadowColor = [UIColor clearColor];
        self.tabBar.standardAppearance = tabbarAppearance;

    }else{
      self.tabBar.backgroundImage = [UIImage new];
      self.tabBar.shadowImage = [UIImage new];

    }
    [self p_setupChildVC];
    ///添加自定义的tabbar
     [self setUpTabBar];
}

- (NSMutableArray *)metaData {
    if (!_metaData) {
        _metaData = [NSMutableArray array];
        [_metaData addObject:@{@"className":@"DWHomeViewController",
                                   @"title":@"首页",
                               @"imageName":@"home"}];

        [_metaData addObject:@{@"className":@"DWMessageViewController",
                                   @"title":@"商城",
                               @"imageName":@"mall"}];

        [_metaData addObject:@{@"className":@"DWSameFityViewController",
                                   @"title":@"书架",
                               @"imageName":@"bookshelf"}];
        
        [_metaData addObject:@{@"className":@"DWMineViewController",
                                   @"title":@"我的",
                               @"imageName":@"mine"}];
    }
    return _metaData;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpTabBar {
    PPTabBar *tabBar = [[PPTabBar alloc] initWithFrame:CGRectMake(0, -10, ScreenWidth, TabBarHeight + 10 )];
    tabBar.backgroundColor = [UIColor clearColor];
    [self.tabBar addSubview:tabBar];
    tabBar.delegate = self;
    tabBar.items = self.items;
    self.myBar = tabBar;
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    self.tabBar.hidden = hidesBottomBarWhenPushed;
}

//实现代理方法
- (void)tabBar:(PPTabBar*)tabBar didClickButton:(int)index {
    self.willSelectIndex = index;
    self.selectedIndex = index;
}

- (void)tabBardidClickMusicButton:(UIButton *)musicBtn {
}

- (void)p_loginSuccess:(NSNotification*)noti {
    NSDictionary * userInfo = noti.userInfo;
    BOOL fromTabbar = [userInfo[@"fromTabbar"] boolValue];
    if (fromTabbar == YES) {
        [self pushToOneTab:2];
    }
}

- (void)p_setupChildVC {
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in self.metaData) {
        NSString * className = dic[@"className"];
        NSString * title = dic[@"title"];
        NSString * imageName = dic[@"imageName"];
        Class vcClass = NSClassFromString(className);
        UIViewController * vc = [[vcClass alloc]init];
        PPNavigationController *nav = [[PPNavigationController alloc]initWithRootViewController:vc];
        vc.tabBarItem.image = [self p_getOriginal:[NSString stringWithFormat:@"icon_tabbar_%@_normal",imageName]];
        vc.tabBarItem.selectedImage = [self p_getOriginal:[NSString stringWithFormat:@"icon_tabbar_%@_selected",imageName]];
        nav.tabBarItem.title = title;
        [self.items addObject:vc.tabBarItem];
        [array addObject:nav];
    }
    self.viewControllers = array;
}

- (UIImage*)p_getOriginal:(NSString*)imageName {
    UIImage * originalImg = [UIImage imageNamed:imageName];
    return [originalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)pushToOneTab:(NSInteger)index {
    if (index >= self.myBar.buttons.count) {
        return;
    }
    UIButton *btn = self.myBar.buttons[index];
    [self.myBar BtnClick:btn];
}

- (void)updateMusicBtnImageWithUrlStr:(NSString *)urlStr {
    if (IsStrEmpty(urlStr)) {
         return;
     }
}

- (void)updateMusicBtnImage {
}

- (void)updateMusicBtnState{
    [self.myBar updateMusicBtnState];
}

- (void)updateProgressView {
    [self.myBar updateProgressView];
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

@end
