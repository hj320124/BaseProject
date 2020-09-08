//
//  SystemInfo.h
//  BaseProject
//
//  Created by hj on 2019/1/24.
//  Copyright © 2019 mate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IOS11_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS10_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS9_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS8_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS7_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS6_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS5_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS4_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS3_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"3.0" options:NSNumericSearch] != NSOrderedAscending )

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define IS_IPHONE_5     [SNSystemInfo is_iPhone_5];

NS_ASSUME_NONNULL_BEGIN

@interface SystemInfo : NSObject
/*系统版本*/
+ (NSString *)osVersion;

/*硬件版本*/
+ (NSString *)platform;

/*硬件版本名称*/
+ (NSString *)platformString;

/*系统当前时间 格式：yyyy-MM-dd HH:mm:ss*/
+ (NSString *)systemTimeInfo;

/*软件版本*/
+ (NSString *)appVersion;

/*是否是iPhone5*/
+ (BOOL)is_iPhone_5;

// 4 or 4s
+ (BOOL)is_iPhone_4s;

//6
+ (BOOL)is_iPhone_6;

//6p
+ (BOOL)is_iPhone_6P;


/*是否越狱*/
+ (BOOL)isJailBroken;

/*越狱版本*/
+ (NSString *)jailBreaker;


+ (BOOL)isAllowedNotification;

/* iPhone X系列（真机版）*/
+ (BOOL)isIPhoneXSerial;

/* 获取物理分辨率 解决放大模式分辨率变化的问题*/
+ (NSString *)getDevicePhysicalResolution;


@end

NS_ASSUME_NONNULL_END
