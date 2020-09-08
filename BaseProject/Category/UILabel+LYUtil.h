//
//  UILabel+LYUtil.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LYUtil)

/**
 获取label上文本的尺寸

 @param maxSize 最大尺寸范围
 @return 尺寸
 */
-(CGSize)getTextSizeWithMaxSize:(CGSize)maxSize;


/**
 获取label上文本的宽度

 @param maxSize 最大尺寸范围
 @return 宽度
 */
-(CGFloat)getTextWidthWithMaxSize:(CGSize)maxSize;

/**
 获取label上文本的高度

 @param maxSize 最大尺寸范围
 @return 高度
 */
-(CGFloat)getTextHeightWithMaxSize:(CGSize)maxSize;

/**
 *获取每行文字内容及其行数
 */
+(NSMutableArray *)getLinesArrayOfStringWithWidth:(CGFloat)maxWidth
                                     withTextFont:(UIFont *)font
                                             text:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
