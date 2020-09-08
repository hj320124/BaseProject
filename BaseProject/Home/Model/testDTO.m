//
//  testDTO.m
//  BaseProject
//
//  Created by hj on 2019/1/17.
//  Copyright © 2019 mate. All rights reserved.
//

#import "testDTO.h"

@implementation testDTO

-(instancetype)copyWithZone:(NSZone *)zone
{
    testDTO *tdo=[[[self class] alloc ] init];
    tdo.address=self.address;
    return tdo;
}
@end
