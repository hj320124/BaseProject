//
//  FrameObjet.m
//  EtrotekBike
//
//  Created by hj on 2017/11/11.
//  Copyright © 2017年 com.Nanjing-Etrotek. All rights reserved.
//

#import "FrameObjet.h"

@implementation FrameObjet
static id _instance = nil;
+(id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _instance = [super allocWithZone:zone];
        
    });
    
    return _instance;
}

+(instancetype)shareSingle{
    return [[self alloc]init];
}


@end
