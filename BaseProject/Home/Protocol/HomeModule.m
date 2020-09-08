//
//  HomeModule.m
//  BaseProject
//
//  Created by mate on 2018/12/20.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "HomeModule.h"
#import "TestVC.h"
#import "HomeProtocol.h"

@implementation HomeModule

+(void)load
{
    JSObjectionInjector *injector=[JSObjection defaultInjector];
    injector= injector? :[JSObjection createInjector];
    injector=[injector withModule:[[self alloc] init] ];
    [JSObjection setDefaultInjector:injector];
    
}

//绑定对象
-(void)configure
{
    [self bindClass:[TestVC class] toProtocol:@protocol(TestVCProtocol)];
}
@end
