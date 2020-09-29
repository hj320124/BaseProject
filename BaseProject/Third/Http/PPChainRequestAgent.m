//
//  PPChainRequestAgent.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPChainRequestAgent.h"
#import "PPChainRequest.h"

@interface PPChainRequestAgent ()

@property (strong, nonatomic) NSMutableArray<PPChainRequest *> *requestArray;

@end

@implementation PPChainRequestAgent

+ (PPChainRequestAgent *)sharedAgent {
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
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addChainRequest:(PPChainRequest *)request {
    @synchronized(self) {
        [self.requestArray addObject:request];
    }
}

- (void)removeChainRequest:(PPChainRequest *)request {
    @synchronized(self) {
        [self.requestArray removeObject:request];
    }
}


@end
