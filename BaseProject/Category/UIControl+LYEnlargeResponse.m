//
//  UIControl+LYEnlargeResponse.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "UIControl+LYEnlargeResponse.h"

static char topKey;
static char bottomKey;
static char leftKey;
static char rightKey;

@implementation UIControl (LYEnlargeResponse)

-(UIControl * _Nonnull (^)(CGFloat))enlarge_top{
    return ^UIControl*(CGFloat top){
        [self setTop:top];
        return self;
    };
}

-(UIControl * _Nonnull (^)(CGFloat))enlarge_bottom{
    return ^UIControl*(CGFloat bottom){
        [self setBottom:bottom];
        return self;
    };
}

-(UIControl * _Nonnull (^)(CGFloat))enlarge_left{
    return ^UIControl*(CGFloat left){
        [self setLeft:left];
        return self;
    };
}

-(UIControl * _Nonnull (^)(CGFloat))enlarge_right{
    return ^UIControl*(CGFloat right){
        [self setRight:right];
        return self;
    };
}

-(UIControl * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))enlarge_edge{
    return ^UIControl*(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
        [self setTop:top];
        [self setBottom:bottom];
        [self setLeft:left];
        [self setRight:right];
        return self;
    };
}

-(void)setTop:(CGFloat)top{
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setBottom:(CGFloat)bottom{
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setLeft:(CGFloat)left{
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setRight:(CGFloat)right{
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGRect)responseRect{
    NSNumber * topNum = objc_getAssociatedObject(self, &topKey);
    NSNumber * bottomNum = objc_getAssociatedObject(self, &bottomKey);
    NSNumber * leftNum = objc_getAssociatedObject(self, &leftKey);
    NSNumber * rightNum = objc_getAssociatedObject(self, &rightKey);
    
    CGFloat top = topNum ? topNum.floatValue : 0;
    CGFloat bottom = bottomNum ? bottomNum.floatValue : 0;
    CGFloat left = leftNum ? leftNum.floatValue : 0;
    CGFloat right = rightNum ? rightNum.floatValue : 0;
    
    return CGRectMake(self.bounds.origin.x - left,
                      self.bounds.origin.y - top,
                      self.bounds.size.width + left + right,
                      self.bounds.size.height + top + bottom);
}

// 扩大实际点击面积
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self responseRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}

@end
