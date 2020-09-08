//
//  UIImage+LYCompress.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYCompress)

/**
 获取压缩后的图片二进制数据
 
 @param maxLength 压缩最大字节长度
 @return 压缩后的图片二进制数据
 */
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;

/**
 获取压缩之后图片

 @param maxLength 压缩最大字节长度
 @return 压缩后的图
 */
-(UIImage*)getCompressImageWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
