//
//  UIView+Animation.m
//  SNEBook
//
//  Created by hj on 2018/5/19.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
#pragma mark---动画
- (void)bounce0AnimationWithScale:(float)scale duration:(NSInteger)duration{
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationDidStop)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.1f);
    [UIView commitAnimations];
}



- (void)bounce1AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationDidStop)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.95f);
    [UIView commitAnimations];
}

- (void)bounce2AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void)bounceCloseAnimation {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceCloseAnimationDidStop)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001f, 0.001f);
    [UIView commitAnimations];
    
}

- (void)bounceCloseAnimationDidStop {
    
    [self removeFromSuperview];
    
}
@end
