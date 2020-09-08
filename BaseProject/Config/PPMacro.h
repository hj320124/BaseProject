//
//  PPMacro.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#ifndef PPMacro_h
#define PPMacro_h

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScaleWidth(R) (ScreenWidth < ScreenHeight ? ScreenWidth : ScreenHeight)/375*R
#define ceilfScaleWidth(R) ceilf((ScreenWidth < ScreenHeight ? ScreenWidth : ScreenHeight)/375*R)
#define ScaleHeight(R) (ScreenWidth < ScreenHeight ? ScreenHeight : ScreenWidth)/667*R

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] nativeBounds].size) : NO)
#define iPhone6_7_8 ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] nativeBounds].size) : NO)

#if TARGET_IPHONE_SIMULATOR
#define iPhone6P_7P_8P ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] nativeBounds].size) : NO)
#else
#define iPhone6P_7P_8P ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] nativeBounds].size) : NO)
#endif

#define iPhoneX_XS ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] nativeBounds].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] nativeBounds].size) : NO)
#define iPhoneXSMAX ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ?CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] nativeBounds].size) : NO)

#define IsFullScreen (iPhoneXR ||iPhoneX_XS || iPhoneXSMAX)
#define NavgationBarHeight 44
/**
 状态栏高度
 */
#define StatusBarHeight (IsFullScreen ? 44 : 20)
/**
 导航栏高度
 */
#define NavgationFullHeight (IsFullScreen ? 88 : 64)
/**
 底部按钮安全高度
 */
#define BottomSafeHeight (IsFullScreen ? 34 : 0)
/**
 底导航高度
 */
#define TabBarHeight (IsFullScreen ? 83 : 49)

/**
 __weak弱引用
 */
#define LYWeakSelf __weak typeof(self) weakSelf = self;
#define LYStrongSelf __strong typeof(type) strongSelf = self;

#define LYViewMaxY(view) CGRectGetMaxY(view.frame)


#ifdef DEBUG

#define LYLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define LYSuccessLog(FORMAT, ...) fprintf(stderr,"✅✅✅ %s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define LYFailureLog(FORMAT, ...) fprintf(stderr,"❗️❗️❗️%s-第%d行 %s\n",__FUNCTION__,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define LYTipLog(FORMAT, ...) fprintf(stderr,"⚠️⚠️⚠️ %s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define LYLog(FORMAT, ...) nil
#define LYSuccessLog(FORMAT, ...) nil
#define LYFailureLog(FORMAT, ...) nil
#define LYTipLog(FORMAT, ...) nil

#endif

#define MainAppDelegate ((PPAppDelegate*)[UIApplication sharedApplication].delegate)

#endif /* PPMacro_h */

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
//路由相关
#define RouteScheme @"routeScheme"
#define pushUrl(_ref) [NSURL URLWithString:[NSString stringWithFormat:@"%@://push/%@",RouteScheme,_ref]];

//是否和少儿有关
#define isChild(_ref) (_ref == PPMediumTypeSECourse || \
                       _ref == PPMediumTypeSEStory  || \
                       _ref == PPMediumTypeSEPictureBook || \
                       _ref == PPMediumTypeSEPocketAudio  || \
                       _ref == PPMediumTypeSEChildrenSong)
