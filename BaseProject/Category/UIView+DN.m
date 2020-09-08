//
//  UIView+DN.m
//  SNEBook
//
//  Created by hj on 2018/5/19.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIView+DN.h"
#import <objc/runtime.h>

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;

@implementation UIView (DN)

-(CGSize)size{
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setSize:(CGSize)size animated:(BOOL)animated{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setSize:(CGSize)size animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setSize:(CGSize)size animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
}
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setX:(CGFloat)x animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    
}

-(void)setX:(CGFloat)x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.x = x;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setX:(CGFloat)x animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.x = x;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

-(void)setY:(CGFloat)y animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
    }
}

-(void)setY:(CGFloat)y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.y= y;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setY:(CGFloat)y animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.y = y;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    }
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.width = width;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.width = width;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    }
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.height = height;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.height = height;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

- (void)addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}



@end

