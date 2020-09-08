//
//  HomeProtocol.h
//  BaseProject
//
//  Created by mate on 2018/12/20.
//  Copyright © 2018年 mate. All rights reserved.
//  Home类的protocolss🌰

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeProtocol <NSObject>

@end

@protocol TestVCProtocol <NSObject>
//控制器属性
@property(nonatomic,copy)NSString *name;

@optional

-(void)test;

@end


NS_ASSUME_NONNULL_END
