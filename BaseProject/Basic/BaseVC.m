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
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)addNavigationBar {
    [self setupNormalNavigationBarViewWithBarTitle:@""
                                         leftTitle:nil
                                         leftImage:@"icon_back_dark"
                                        rightTitle:nil
                                        rightImage:@""];
    self.customNavigationBarView.hideTitle = YES;
    self.customNavigationBarView.lineAlpha = 0;
    self.customNavigationBarView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0];
}

@end
