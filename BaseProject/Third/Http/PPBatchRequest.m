//
//  PPBatchRequest.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import "PPBatchRequest.h"
#import "PPNetworkPrivate.h"
#import "PPBatchRequestAgent.h"
#import "PPRequest.h"

@interface PPBatchRequest() <PPBaseRequestDelegate>

@property (nonatomic, assign) NSInteger finishedCount;

@property (nonatomic, strong) NSArray<PPRequest *> *requestArray;

@property (nonatomic, strong) PPRequest *failedRequest;

@end

@implementation PPBatchRequest

- (instancetype)initWithRequestArray:(NSArray<PPRequest *> *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (PPRequest * req in self.requestArray) {
            if (![req isKindOfClass:[PPRequest class]]) {
                PPLog(@"Error, request item must be PPRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (self.finishedCount > 0) {
        PPLog(@"Error! Batch request has already started.");
        return;
    }
    self.failedRequest = nil;
    [[PPBatchRequestAgent sharedAgent] addBatchRequest:self];
    [self tellObserversRequestWillStart];
    for (PPRequest * req in self.requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self tellObserversRequestWillStop];
    self.delegate = nil;
    [self clearRequest];
    [self tellObserversRequestDidStop];
    [[PPBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(PPBatchRequest *batchRequest))success
                                    failure:(void (^)(PPBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(PPBatchRequest *batchRequest))success
                              failure:(void (^)(PPBatchRequest *batchRequest))failure {
    self.batchRequsetSuccessBlock = success;
    self.batchRequestfailureBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.batchRequsetSuccessBlock  = nil;
    self.batchRequestfailureBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (PPRequest *request in self.requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestDidFinished:(PPRequest *)request {
    self.finishedCount++;
    if (self.finishedCount == self.requestArray.count) {
        [self tellObserversRequestWillStop];
        if ([self.delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [self.delegate batchRequestFinished:self];
        }
        if (self.batchRequsetSuccessBlock) {
            self.batchRequsetSuccessBlock(self);
        }
        [self clearCompletionBlock];
        [self tellObserversRequestDidStop];
        [[PPBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)requestDidFailed:(PPRequest *)request {
    self.failedRequest = request;
    [self tellObserversRequestWillStop];
    // Stop
    for (PPRequest *req in self.requestArray) {
        [req stop];
    }
    // Callback
    if ([self.delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [self.delegate batchRequestFailed:self];
    }
    if (self.batchRequestfailureBlock) {
        self.batchRequestfailureBlock(self);
    }
    // Clear
    [self clearCompletionBlock];
    [self tellObserversRequestDidStop];
    [[PPBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)clearRequest {
    for (PPRequest * req in self.requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - 监听对象

- (void)addObserver:(id<PPBaseRequestObserver>)observer {
    if (!self.observersArray) {
        self.observersArray = [NSMutableArray array];
    }
    [self.observersArray addObject:observer];
}

@end

