//
//  UIFont+LYUtil.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/19.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "UIFont+LYUtil.h"

@implementation UIFont (LYUtil)

+(UIFont * _Nonnull (^)(CGFloat))systemFont{
    return ^UIFont*(CGFloat fontSize){
        return [UIFont systemFontOfSize:[self p_adaptSmallScreen:fontSize]];
    };
}

+(UIFont * _Nonnull (^)(CGFloat))boldSystemFont{
    return ^UIFont*(CGFloat fontSize){
        return [UIFont boldSystemFontOfSize:[self p_adaptSmallScreen:fontSize]];
    };
}

+ (UIFont * _Nonnull (^)(CGFloat))pingFangFont {
    return ^UIFont *(CGFloat fontSize) {
        return [UIFont fontWithName:@"PingFangSC-Medium"
                               size:[self p_adaptSmallScreen:fontSize]];
    };
}

// 适配4.7寸以下的屏幕
+(CGFloat)p_adaptSmallScreen:(CGFloat)orignalSize{
    return iPhone5 ? (orignalSize)*(ScreenWidth)/375 : orignalSize;
}

@end
