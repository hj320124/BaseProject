//
//  UIView+ScreensShot.m
//  SNEBook
//
//  Created by mate on 2018/10/8.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "UIView+ScreensShot.h"

@implementation UIView (ScreensShot)
- (UIImage *)screenShot {
    
    if (self && self.frame.size.height && self.frame.size.width) {
        //开始绘制
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
        
    } else {
        
        return nil;
    }
}
@end
