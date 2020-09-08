//
//  UIView+Animation.h
//  SNEBook
//
//  Created by hj on 2018/5/19.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
- (void)bounce0AnimationWithScale:(float)scale duration:(NSInteger)duration;//开启动画
- (void)bounceCloseAnimation;//关闭动画

@end
