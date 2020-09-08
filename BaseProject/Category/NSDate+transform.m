//
//  NSDate+transform.m
//  SNEBook
//
//  Created by mate on 2018/9/18.
//  Copyright © 2018年 com.suning.readbook. All rights reserved.
//

#import "NSDate+transform.h"

@implementation NSDate (transform)
+(NSString*)transfromYMD:(NSString*)dateStr;
{
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[dateStr doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
     NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
     fmt.dateFormat = @"yyyy年MM月dd日 HH:mm";
     NSString* dateString = [fmt stringFromDate:date];
    return dateString;
}

+(NSString*)buyRecordTime:(NSString*)dateStr
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *transStr=nil;
    NSDate *date =[fmt dateFromString:dateStr];
    
    NSDateFormatter* fmt2 = [[NSDateFormatter alloc] init];
    fmt2.dateFormat = @"yyyy年M月dd日 HH:mm";
    
    transStr =[fmt2 stringFromDate:date];
    
    return transStr;
}
//四级页评论时间转换
+(NSString *)commentUpdateTime:(NSString *)dateStr
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *transStr=nil;
    NSDate *date =[fmt dateFromString:dateStr];
    
    NSDateFormatter* fmt2 = [[NSDateFormatter alloc] init];
    fmt2.dateFormat = @"yyyy.M.dd/HH:mm";
    
    transStr =[fmt2 stringFromDate:date];
    
    return transStr;
}


@end
