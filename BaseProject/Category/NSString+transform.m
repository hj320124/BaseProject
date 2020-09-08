//
//  NSString+transform.m
//
//
//  Created by  hj on 16/12/6.
//  
//

#import "NSString+transform.h"

@implementation NSString (transform)

+(NSString *)trans16To10:(NSString*)str
{
   return  [NSString stringWithFormat:@"%ld",strtoul([str UTF8String],0,16)];
}

+(NSMutableAttributedString*)setTexFontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor AndStr:(NSMutableAttributedString*)changeStr
{
    [changeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    [changeStr addAttribute:NSFontAttributeName value:font range:range];
    
    
    return changeStr;
}

+(void)setTextColor:(UILabel*)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor andStr:(NSString *)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    [label setAttributedText:str];
}
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor andStr:(NSString *)text andSpaceRange:(NSRange)sRange andSpace:(float)space{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange  strrange=  [text rangeOfString:text];
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    [str addAttributes:@{NSKernAttributeName : @(space)} range:strrange];
    [label setAttributedText:str];

}
@end
