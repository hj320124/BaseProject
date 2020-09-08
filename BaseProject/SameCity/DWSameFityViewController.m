//
//  DWSameFityViewController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWSameFityViewController.h"


@implementation DWSameFityViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        
    }];
    NSLog(@"分支测试");
}

@end
