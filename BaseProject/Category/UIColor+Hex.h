//
//  UIColor+Hex.h
//  NewTeacher
//
//  Created by szl on 16/1/29.
//  Copyright (c) 2016年 songzhanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *) colorWithHexString: (NSString *)color;
+ (void) colorRGBWithHexString: (unsigned int *)red G:(unsigned int *)green B:(unsigned int *)blue Color:(NSString *)color;
+ (UIImage*) createImageWithColor: (UIColor *) color Size:(CGSize)size;

@end
