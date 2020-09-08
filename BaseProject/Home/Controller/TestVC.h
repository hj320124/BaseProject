//
//  TestVC.h
//  BaseProject
//
//  Created by mate on 2018/11/29.
//  Copyright © 2018年 mate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestVC : BaseVC<TestVCProtocol>
@property(nonatomic,copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
