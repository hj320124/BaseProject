//
//  UILabel+LYUtil.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "UILabel+LYUtil.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UILabel (LYUtil)

-(CGSize)getTextSizeWithMaxSize:(CGSize)maxSize{
    NSDictionary *attr = @{NSFontAttributeName : self.font
                           };
    CGRect rect = [self.text boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                          attributes:attr
                                             context:nil];
    return rect.size;
}

-(CGFloat)getTextWidthWithMaxSize:(CGSize)maxSize{
    return [self getTextSizeWithMaxSize:maxSize].width;
}

-(CGFloat)getTextHeightWithMaxSize:(CGSize)maxSize{
    return [self getTextSizeWithMaxSize:maxSize].height;
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

@end
