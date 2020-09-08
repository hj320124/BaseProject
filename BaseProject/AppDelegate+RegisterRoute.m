//
//  AppDelegate+RegisterRoute.m
//  BaseProject
//
//  Created by mate on 2018/11/30.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "AppDelegate+RegisterRoute.h"
#import <objc/runtime.h>

@implementation AppDelegate (RegisterRoute)
-(void)registerRouteWithScheme:(NSString*)scheme
{
    [[JLRoutes routesForScheme:scheme] addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
       
        Class class=NSClassFromString(parameters[@"controller"]);
        UIViewController *nextVC=[[class alloc] init];
        [self paramToVC:nextVC param:parameters];
        UIViewController *currentVc=[self currentViewController];
        [currentVc.navigationController pushViewController:nextVC animated:YES];
        
        return YES;
    }];
}

//获取当前的o控制器
-(UIViewController*)currentViewController
{
    UIViewController *currVC=nil;
    UIViewController *Rootvc=self.window.rootViewController;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav=(UINavigationController*)Rootvc;
            UIViewController *v=[nav.viewControllers lastObject];
            currVC=v;
            Rootvc=v.presentedViewController;
        }
        else if ([Rootvc isKindOfClass:[UITabBarController class]])
        {
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

-(void)paramToVC:(UIViewController*)vc param:(NSDictionary<NSString *,NSString *>*)param
{
    //runtime 获取属性
    unsigned int outCount=0;
    //获取属性类表
    objc_property_t *properties=class_copyPropertyList([vc class], &outCount);
    //遍历属性，将属性名称赋值对应字典赋值
    for (int i=0; i<outCount; i++) {
        objc_property_t property=properties[i];
        NSString *key=[NSString stringWithUTF8String:property_getName(property)];
        NSString *value=param[key];
        if ( nil!=value) {
            [vc setValue:value forKey:key];
        }
    }
    
}

@end
