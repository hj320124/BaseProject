//
//  TestVC.m
//  BaseProject
//
//  Created by mate on 2018/11/29.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "TestVC.h"
#import "MBProgressHUD.h"

@interface TestVC ()<MBProgressHUDDelegate>
{
    UIButton *_btn;
}
@property(nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=self.name;
    _btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _btn.backgroundColor=[UIColor redColor];
    
    [_btn addTarget:self action:@selector(CustomTest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
    
    [self test];
    
    
}

-(void)CustomTest
{
    //自定义view
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    UIActivityIndicatorView *IndicatorView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    IndicatorView.color=[UIColor redColor];
    [IndicatorView startAnimating];
    //自定义
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.delegate = self;
    _HUD.customView = IndicatorView;
    [_HUD showAnimated:YES];
    [_HUD hideAnimated:YES afterDelay:3];
    
   
}
//将页面要实现的方法 写在代理里面然后实现
-(void)test
{
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.color=[UIColor clearColor];
    hud.label.text=[NSString stringWithFormat:@"。。。。。%@",_name];
    [hud hideAnimated:YES afterDelay:2];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed=NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
