//
//  FrameObjet.h
//  EtrotekBike
//
//  Created by hj on 2017/11/11.
//  Copyright © 2017年 com.Nanjing-Etrotek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrameObjet : NSObject

@property(nonatomic,strong)NSValue *frameValue;

+(instancetype)shareSingle;

@end
