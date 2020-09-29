//
//  PPChainRequestAgent.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/19.
//  Copyright © 2020 mate. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PPChainRequest;

///  YTKChainRequestAgent handles chain request management. It keeps track of all
///  the chain requests.
@interface PPChainRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared chain request agent.
+ (PPChainRequestAgent *)sharedAgent;

///  Add a chain request.
- (void)addChainRequest:(PPChainRequest *)request;

///  Remove a previously added chain request.
- (void)removeChainRequest:(PPChainRequest *)request;

@end


NS_ASSUME_NONNULL_END
