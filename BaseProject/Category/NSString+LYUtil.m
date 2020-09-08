
//
//  NSString+LYUtil.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/6/6.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "NSString+LYUtil.h"

@implementation NSString (LYUtil)

- (unsigned long long)fileSize{
    unsigned long long size = 0;
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    BOOL isExist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if(!isExist) return size;
    
    if (isExist) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            
            size +=[mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else
    {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

- (NSString *)formatJsMethodName {
    if (IsStrEmpty(self)) {
        return self;
    }
    return [self stringByAppendingString:@"()"];
}

@end
