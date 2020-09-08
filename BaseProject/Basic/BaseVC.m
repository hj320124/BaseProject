//
//  BaseVC.m
//  BaseProject
//
//  Created by mate on 2018/12/24.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "BaseVC.h"
#import <YYKit.h>
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomBackButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];

}


/**
 *设置返回按钮
 */
-(void)setCustomBackButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 10, 7, 10)];
    [leftBtn setImage:[UIImage imageNamed:@"NavigatonBack"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, 64, 44)];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];

}



-(void)hiddenLeftNavigationButton
{
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton=YES;
}


@end
