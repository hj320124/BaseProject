//
//  NSString+transform.h

//
//  Created by  hj on 16/12/6.
// 
//

#import <Foundation/Foundation.h>

@interface NSString (transform)
//16进制转10进制
+(NSString *)trans16To10:(NSString*)str;
//改变一行字中某几个字的大小颜色
+(NSMutableAttributedString*)setTexFontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor AndStr:(NSMutableAttributedString*)changeStr;
//改变一行字中某几个字的大小颜色
+(void)setTextColor:(UILabel*)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor andStr:(NSString*)text;
//改变一行字中某几个字的大小颜色
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor andStr:(NSString *)text andSpaceRange:(NSRange)sRange andSpace:(float)space;
@end
