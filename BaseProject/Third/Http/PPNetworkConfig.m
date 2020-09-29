//
//  PPNetWorkConfig.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPNetworkConfig.h"
#import "PPBaseRequest.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@implementation PPNetworkConfig {
    NSMutableArray<id<PPUrlFilterProtocol>> *_urlFilters;
    NSMutableArray<id<PPCacheDirPathFilterProtocol>> *_cacheDirPathFilters;
}

+ (PPNetworkConfig *)sharedConfig {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = @"";
        _cdnUrl = @"";
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _debugLogEnabled = NO;
    }
    return self;
}

- (void)addUrlFilter:(id<PPUrlFilterProtocol>)filter {
    [_urlFilters addObject:filter];
}

- (void)clearUrlFilter {
    [_urlFilters removeAllObjects];
}

- (void)addCacheDirPathFilter:(id<PPCacheDirPathFilterProtocol>)filter {
    [_cacheDirPathFilters addObject:filter];
}

- (void)clearCacheDirPathFilter {
    [_cacheDirPathFilters removeAllObjects];
}

- (NSArray<id<PPUrlFilterProtocol>> *)urlFilters {
    return [_urlFilters copy];
}

- (NSArray<id<PPCacheDirPathFilterProtocol>> *)cacheDirPathFilters {
    return [_cacheDirPathFilters copy];
}

@end

