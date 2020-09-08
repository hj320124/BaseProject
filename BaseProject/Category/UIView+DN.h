//
//  UIView+DN.h
//  SNEBook
//
//  Created by hj on 2018/5/19.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (DN)

-(CGSize)size;
-(void)setSize:(CGSize)size;
-(void)setSize:(CGSize)size animated:(BOOL)animated;
-(void)setSize:(CGSize)size animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setSize:(CGSize)size animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGPoint)origin;
-(void)setOrigin:(CGPoint)origin;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)x;
-(void)setX:(CGFloat)x;
-(void)setX:(CGFloat)x animated:(BOOL)animated;
-(void)setX:(CGFloat)x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setX:(CGFloat)x animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


-(CGFloat)y;
-(void)setY:(CGFloat)y;
-(void)setY:(CGFloat)y animated:(BOOL)animated;
-(void)setY:(CGFloat)y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setY:(CGFloat)y animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


/**
 *  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;


@end

