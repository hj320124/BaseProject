//
//  NSString+TrimmingAdditions.h
//  SNEBook
//
//  Created by farben on 2018/9/29.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//
/**
 4.去掉最左边的空格  和  去掉最右边的空格
 */
#import <Foundation/Foundation.h>

@interface NSString (TrimmingAdditions)
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

-(NSAttributedString*)getAttributedStringWithLineSpeace:(CGFloat)space Text:(NSString*)text;

//获取富文本的高度
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width ;

+(void)TrimText:(NSString*)text;

+ (BOOL) isEmpty:(NSString *) str;

@end
