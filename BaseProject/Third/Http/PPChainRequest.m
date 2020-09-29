//
//  PPChainRequest.m
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//
#import "PPChainRequest.h"
#import "PPChainRequestAgent.h"
#import "PPNetworkPrivate.h"
#import "PPBaseRequest.h"

@interface PPChainRequest()<PPBaseRequestDelegate>

@property (strong, nonatomic) NSMutableArray<PPBaseRequest *> *requestArray;

@property (strong, nonatomic) NSMutableArray<PPChainCallback> *requestCallbackArray;

@property (assign, nonatomic) NSUInteger nextRequestIndex;

@property (strong, nonatomic) PPChainCallback emptyCallback;

@end

@implementation PPChainRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _nextRequestIndex = 0;
        _requestArray = [NSMutableArray array];
        _requestCallbackArray = [NSMutableArray array];
        _emptyCallback = ^(PPChainRequest *chainRequest, PPBaseRequest *baseRequest) {
            // do nothing
        };
    }
    return self;
}

- (void)start {
    if (self.nextRequestIndex > 0) {
        PPLog(@"Error! Chain request has already started.");
        return;
    }

    if ([self.requestArray count] > 0) {
        [self tellObserversRequestWillStart];
        [self startNextRequest];
        [[PPChainRequestAgent sharedAgent] addChainRequest:self];
    } else {
        PPLog(@"Error! Chain request array is empty.");
    }
}

- (void)stop {
    [self tellObserversRequestWillStop];
    [self clearRequest];
    [[PPChainRequestAgent sharedAgent] removeChainRequest:self];
    [self tellObserversRequestDidStop];
}

- (void)addRequest:(PPBaseRequest *)request callback:(PPChainCallback)callback {
    [self.requestArray addObject:request];
    if (callback != nil) {
        [self.requestCallbackArray addObject:callback];
    } else {
        [self.requestCallbackArray addObject:self.emptyCallback];
    }
}

- (NSArray<PPBaseRequest *> *)requestArray {
    return _requestArray;
}

- (BOOL)startNextRequest {
    if (self.nextRequestIndex < [self.requestArray count]) {
        PPBaseRequest *request = self.requestArray[self.nextRequestIndex];
        self.nextRequestIndex++;
        request.delegate = self;
        [request clearCompletionBlock];
        [request start];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Network Request Delegate

- (void)requestDidFinished:(PPBaseRequest *)request {
    NSUInteger currentRequestIndex = self.nextRequestIndex - 1;
    PPChainCallback callback = self.requestCallbackArray[currentRequestIndex];
    callback(self, request);
    if (![self startNextRequest]) {
        [self tellObserversRequestWillStop];
        if ([self.delegate respondsToSelector:@selector(chainRequestFinished:)]) {
            [self.delegate chainRequestFinished:self];
            [[PPChainRequestAgent sharedAgent] removeChainRequest:self];
        }
        [self tellObserversRequestDidStop];
    }
}

- (void)requestDidFailed:(PPBaseRequest *)request {
    [self tellObserversRequestWillStop];
    if ([self.delegate respondsToSelector:@selector(chainRequestFailed:failedBaseRequest:)]) {
        [self.delegate chainRequestFailed:self failedBaseRequest:request];
        [[PPChainRequestAgent sharedAgent] removeChainRequest:self];
    }
    [self tellObserversRequestDidStop];
}

- (void)clearRequest {
    NSUInteger currentRequestIndex = self.nextRequestIndex - 1;
    if (currentRequestIndex < [self.requestArray count]) {
        PPBaseRequest *request = self.requestArray[currentRequestIndex];
        [request stop];
    }
    [self.requestArray removeAllObjects];
    [self.requestCallbackArray removeAllObjects];
}

#pragma mark - Request Accessoies

- (void)addObserver:(id<PPBaseRequestObserver>)observer {
    if (!self.observersArray) {
        self.observersArray = [NSMutableArray array];
    }
    [self.observersArray addObject:observer];
}

@end

