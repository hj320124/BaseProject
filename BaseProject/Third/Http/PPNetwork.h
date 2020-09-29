//
//  Header.h
//  BaseProject
//
//  Created by imac2015-2 on 2020/5/21.
//  Copyright © 2020 mate. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef _PPNETWORK_
    #define _PPNETWORK_

#if __has_include(<PPNetwork/PPNetwork.h>)

    FOUNDATION_EXPORT double PPNetworkVersionNumber;
    FOUNDATION_EXPORT const unsigned char PPNetworkVersionString[];

    #import <PPNetwork/PPRequest.h>
    #import <PPNetwork/PPBaseRequest.h>
    #import <PPNetwork/PPNetworkAgent.h>
    #import <PPNetwork/PPBatchRequest.h>
    #import <PPNetwork/PPBatchRequestAgent.h>
    #import <PPNetwork/PPChainRequest.h>
    #import <PPNetwork/PPChainRequestAgent.h>
    #import <PPNetwork/PPNetworkConfig.h>

#else

    #import "PPRequest.h"
    #import "PPBaseRequest.h"
    #import "PPNetworkAgent.h"
    #import "PPBatchRequest.h"
    #import "PPBatchRequestAgent.h"
    #import "PPChainRequest.h"
    #import "PPChainRequestAgent.h"
    #import "PPNetworkConfig.h"

#endif /* __has_include */

#endif /* _PPNETWORK_ */

