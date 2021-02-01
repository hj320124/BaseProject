//
//  DWHomeViewController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWHomeViewController.h"
#import "HomeProtocol.h"
#import "CollectionViewVC.h"
#import "CircleCollectionVC.h"
#import "testDTO.h"
#import "NSData+AES.h"
#import "GBEncodeTool.h"
@implementation DWHomeViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor blueColor];
    [btn addTarget:self action:@selector(hah) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [btn2 setTitle:@"跳转" forState:UIControlStateNormal];
    btn2.backgroundColor=[UIColor blueColor];
    [btn2 addTarget:self action:@selector(huhu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    NSArray *arr=@[@"1",@"2",@"3",@"4",@"5"];
    NSArray *pp=[arr subarrayWithRange:NSMakeRange(0, 3)];
    NSArray *pp1=[arr subarrayWithRange:NSMakeRange(0, 2)];
    NSLog(@"xxxxxxxx===xxxxx==%@,%@",pp,pp1);
    
    NSArray *mm=[NSArray array];
    for (int i=0; i<mm.count; i++) {
        NSString *ss=mm[i];
        NSLog(@"ppp==>%@",ss);
    }
    
    
    
}

-(void)hah
{
    //根据代理注册获取控制器，避免依赖，模块化开发
    UIViewController<TestVCProtocol> *TestVC = [[JSObjection defaultInjector] getObject:@protocol(TestVCProtocol) ];
    //注册路由
    NSURL *url=pushUrl(NSStringFromClass([TestVC class]));
    [[JLRoutes routesForScheme:RouteScheme] routeURL:url withParameters:@{@"name":@"路由跳转+模块化"}];
}

-(void)huhu
{

    
    NSURL *url=pushUrl(NSStringFromClass([CircleCollectionVC class]));
    [[JLRoutes routesForScheme:RouteScheme] routeURL:url withParameters:nil];
}
@end
