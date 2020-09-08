//
//  UIView+Shadow.h
//  SNEBook
//
//  Created by hj on 2018/5/9.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//  添加阴影的方法

#import <UIKit/UIKit.h>

@interface UIView (Shadow)
@property(nonatomic,strong)UIColor *shadowColor;//阴影颜色
/*
 * 默认的添加阴影的方法
 */
-(void)BeShadow;
/*
 * 可以设置阴影的偏移量
 * @parma X Y 偏移量
 */
-(void)BeShadowWithOffSetX:(CGFloat)X OffsetY:(CGFloat)Y;
/*
 *比较消耗性能的添加阴影圆角方法
 */
-(void)BeShadowDiscoverNew;
/*
 *给按钮添加渐变的阴影
 */
-(void)buttonShadowNew;
/*
 *专门给发现页面添加阴影的方法（阴影颜色不一样）
 *@parma X Y 偏移量
 */
-(void)BeShadowDiscoverWithOffSetX:(CGFloat)X OffsetY:(CGFloat)Y;

-(void)buttonShadowLeftAndRight;

@end
