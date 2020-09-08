//
//  UIControl+LYEnlargeResponse.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (LYEnlargeResponse)

/**
 向上扩大范围
 */
-(UIControl*(^)(CGFloat))enlarge_top;

/**
 向下扩大范围
 */
-(UIControl*(^)(CGFloat))enlarge_bottom;

/**
 向左扩大范围
 */
-(UIControl*(^)(CGFloat))enlarge_left;

/**
 向右扩大范围
 */
-(UIControl*(^)(CGFloat))enlarge_right;

/**
 向四周的扩大范围(上左下右)
 */
-(UIControl*(^)(CGFloat top,CGFloat bottom,CGFloat left,CGFloat right))enlarge_edge;

@end

NS_ASSUME_NONNULL_END
