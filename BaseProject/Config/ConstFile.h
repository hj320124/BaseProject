//
//  ConstFile.h
//  BaseProject
//
//  Created by mate on 2018/11/29.
//  Copyright © 2018年 mate. All rights reserved.
//

#ifndef ConstFile_h
#define ConstFile_h

#endif /* ConstFile_h */

//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)  : NO)

#define SNRBS_iPhoneX ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? YES : NO)

//iPhoneX顶部部偏移量
#define SNRBS_iPhoneX_SPACE_TOP            (SNRBS_iPhoneX ? 24.f : 0)
//iPhoneX底部偏移量
#define SNRBS_iPhoneX_SPACE_BUTTOM         (SNRBS_iPhoneX ? 34.f : 0)

//屏幕长宽
#define SN_SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]

#ifndef kScreenWidth
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#endif
#ifndef kScreenHeight
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
#endif

////打印
#ifdef DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]

//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RouteScheme @"routeScheme"
#define pushUrl(_ref) [NSURL URLWithString:[NSString stringWithFormat:@"%@://push/%@",RouteScheme,_ref]];
