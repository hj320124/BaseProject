//
//  UILabel+ChangeLineSpace.h
//  SNEBook
//
//  Created by yanhao on 2018/2/28.
//  Copyright © 2018年 suning. All rights reserved.
//
//UIlabel的行间距和字间距按照需要调节

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpace)

/**
 *  改变行间距
 */
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(CGFloat)space;

/**
 *  改变字间距
 */
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(CGFloat)space;

- (void)changeLineSpaceCenterForLabel:(UILabel *)label WithSpace:(CGFloat)space Font:(UIFont*)font;

/**
 *  改变行间距和字间距
 */
- (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;

/**
 *获取每行文字内容及其行数
 */
+(NSMutableArray *)getLinesArrayOfStringWithWidth:(CGFloat)maxWidth
                                      withTextFont:(UIFont *)font
                                              text:(NSString *)text;

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
                          text:(NSString *)text;
//文字置顶
-(void)alignTop;

//文字置底
-(void)alignBottom;

@end
