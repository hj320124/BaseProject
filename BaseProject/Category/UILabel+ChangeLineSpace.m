//
//  UILabel+ChangeLineSpace.m
//  SNEBook
//
//  Created by yanhao on 2018/2/28.
//  Copyright © 2018年 suning. All rights reserved.
//
//UIlabel的行间距和字间距按照需要调节

#import "UILabel+ChangeLineSpace.h"
#import <CoreText/CoreText.h>

@implementation UILabel (ChangeLineSpace)

/**
 *  改变行间距
 */
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(CGFloat)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    label.attributedText = attributedString;
//    [label sizeToFit];
    
}

/**
 *  改变行间距居中
 */
- (void)changeLineSpaceCenterForLabel:(UILabel *)label WithSpace:(CGFloat)space Font:(UIFont*)font   {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail ];
     paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    //    [label sizeToFit];
    
}

/**
 *  改变字间距
 */
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(CGFloat)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

/**
 *  改变行间距和字间距
 */
- (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
-(CGSize)boundingRectWithWidth:(CGFloat)maxWidth
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing
                          text:(NSString *)text
{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    //#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

/**
 *获取每行文字内容及其行数
*/
+ (NSMutableArray *)getLinesArrayOfStringWithWidth:(CGFloat)maxWidth
                                      withTextFont:(UIFont *)font
                                              text:(NSString *)text
{

    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,maxWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return linesArray;
}

//文字置顶
-(void)alignTop
{
    CGSize fonitSize=[self.text sizeWithFont:self.font];
    double finalHeight=fonitSize.height*self.numberOfLines;
    double finalWidth=self.frame.size.width;
    CGSize theStringSize=[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinestToPad=(finalHeight-theStringSize.height)/fonitSize.height;
    for (int i=0; i<=newLinestToPad; i++) {
        self.text=[self.text stringByAppendingString:@" \n"];
    }
}

//文字置底
-(void)alignBottom
{
    
}







@end
