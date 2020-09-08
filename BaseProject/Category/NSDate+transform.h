//
//  NSDate+transform.h
//  SNEBook
//
//  Created by mate on 2018/9/18.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (transform)
/*
 *时间戳转化成时间字符串
 */
+(NSString*)transfromYMD:(NSString*)dateStr;
/*
 *时间字符串成时间字符串（）
 */
+(NSString*)buyRecordTime:(NSString*)dateStr;


/*
 *时间字符串成时间字符串（yyyy.M.dd/HH:mm）
 */
+(NSString *)commentUpdateTime:(NSString *)dateStr;
@end
