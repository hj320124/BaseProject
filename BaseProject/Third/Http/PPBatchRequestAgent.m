//
//  PPBatchRequestAgent.m
//  
//
//  Created by imac2015-2 on 2020/5/19.
//

#import "PPBatchRequestAgent.h"
#import "PPBatchRequest.h"

@interface PPBatchRequestAgent()

@property (strong, nonatomic) NSMutableArray<PPBatchRequest *> *requestArray;

@end

@implementation PPBatchRequestAgent

+ (PPBatchRequestAgent *)sharedAgent {
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

- (void)addBatchRequest:(PPBatchRequest *)request {
    @synchronized(self) {
        [self.requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(PPBatchRequest *)request {
    @synchronized(self) {
        [self.requestArray removeObject:request];
    }
}


@end
