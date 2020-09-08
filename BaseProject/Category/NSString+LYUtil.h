//
//  NSString+LYUtil.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/6/6.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYUtil)

/**
 当前路径下的文字大小

 @return 文件大小
 */
- (unsigned long long)fileSize;

- (NSString *)formatJsMethodName;

@end

NS_ASSUME_NONNULL_END
