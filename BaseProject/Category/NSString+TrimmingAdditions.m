//
//  NSString+TrimmingAdditions.m
//  SNEBook
//
//  Created by farben on 2018/9/29.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "NSString+TrimmingAdditions.h"

@implementation NSString (TrimmingAdditions)
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (location; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (length; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    NSLog(@"str --->:%@",[self substringWithRange:NSMakeRange(location, length - location)]);
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width  {
   
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
   
   
}
+(void)TrimText:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
  
    
}
//判断是否全是空格
+ (BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        
        return true;
        
       } else {
            
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            
           NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
            
           if ([trimedString length] == 0) {
                
            return true;
                
            } else {
                    
            return false;
                    
          }
            
        }
    
}


@end
