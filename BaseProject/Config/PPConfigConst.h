//
//  PPConfigConst.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#ifndef PPConfigConst_h
#define PPConfigConst_h

#import <UIKit/UIKit.h>

/** 色值：主色调(#D14360) */
FOUNDATION_EXPORT NSString *const PPPrimaryColorValue;
/** 色值：主色调-浅色(#EC6C86) */
FOUNDATION_EXPORT NSString *const PPLightPrimaryColorValue;
/** 色值：主色调-深色(#B5324D) */
FOUNDATION_EXPORT NSString *const PPDarkPrimaryColorValue;
/** 色值：辅助色(#28344C) */
FOUNDATION_EXPORT NSString *const PPAssistColorValue;
/** 色值：vip相关色值(#FFE3BB) */
FOUNDATION_EXPORT NSString *const PPVipTextColorValue;
/** 色值：错误提示色(#E42A2A) */
FOUNDATION_EXPORT NSString *const PPErrorColorValue;
/** 色值：大标题文字颜色(#000000) */
FOUNDATION_EXPORT NSString *const PPBigTitleColorValue;
/** 色值：标题文字颜色(#000000) */
FOUNDATION_EXPORT NSString *const PPTitleColorValue;
/** 色值：标题文字颜色(#333333) */
FOUNDATION_EXPORT NSString *const PPHomeTitleColorValue;
/** 色值：副标题文字颜色(#FFFFFF) */
FOUNDATION_EXPORT NSString *const PPSubTitleColorValue;
/** 色值：正文文字颜色(#666666) */
FOUNDATION_EXPORT NSString *const PPMainBodyColorValue;
/** 色值：辅助文字颜色(#BABABA) */
FOUNDATION_EXPORT NSString *const PPAssistTextColorValue;
/** 色值：横线颜色(#DDDDDD) */
FOUNDATION_EXPORT NSString *const PPLineColorValue;
/// 色值：分割线颜色(#E0E0E0)
FOUNDATION_EXPORT NSString *const PPSplitLineColorValue;
/** 色值：页面背景色(#FAFAFA) */
FOUNDATION_EXPORT NSString *const PPBackgroundColorValue;
/** 色值：页面背景色(#F7F7F7) */
FOUNDATION_EXPORT NSString *const PPNewBackgroundColorValue;
/** 色值：视图阴影颜色(#CDCDCD) */
FOUNDATION_EXPORT NSString *const PPShadowColorValue;
/// 色值：少儿简介颜色(#999999)
FOUNDATION_EXPORT NSString *const SEIntroColorValue;
/// 色值：封面边框颜色(#D8D8D8)
FOUNDATION_EXPORT NSString *const PPBorderColorValue;
/// 色值：按钮灰色(#EEEEEE)
FOUNDATION_EXPORT NSString *const PPButtonGrayColorValue;
/// 色值：按钮不能点击颜色(#F4F4F4)
FOUNDATION_EXPORT NSString *const PPButtonUnableColorValue;
/// 色值：列表页使用按钮背景颜色(#F9EFF1)
FOUNDATION_EXPORT NSString *const PPListButtonBackgroundColorValue;
/// 色值：选项卡标题颜色(#777777)
FOUNDATION_EXPORT NSString *const PPTabsTitleColorValue;
/// 色值：少儿主色调(#FF4559)
FOUNDATION_EXPORT NSString *const SEPrimaryColorValue;

/** 字体：大标题字体(20pt) */
UIKIT_EXTERN CGFloat const PPBigTitleFontValue;
/** 字体：标题字体(18pt) */
UIKIT_EXTERN CGFloat const PPTitleFontValue;
/** 字体：子标题字体(16pt) */
UIKIT_EXTERN CGFloat const PPSubTitleFontValue;
/** 字体：正文字体(14pt) */
UIKIT_EXTERN CGFloat const PPMainBodyFontValue;
/** 字体：辅助字体(12pt) */
UIKIT_EXTERN CGFloat const PPAssistFontValue;
/** 字体：辅助字体(11pt) */
UIKIT_EXTERN CGFloat const PPSmallAssistFontValue;

/** 常量：图书内容的比例（宽/高:82/115) */
UIKIT_EXTERN CGFloat const PPBookSizeRatio;
/** 常量：常用间距（15pt）*/
UIKIT_EXTERN CGFloat const PPInCommonUseSpace;
/** 常量：设置统一的请求数据分页个数，默认为8 */
UIKIT_EXTERN NSInteger const PPPageLimitCount;
/** 常量：享听详情头视图高度，200pt */
UIKIT_EXTERN CGFloat const PPAudioDetailHeaderHeight;
/** 常量：悦读详情头视图高度，225pt */
UIKIT_EXTERN CGFloat const PPEBookDetailHeaderHeight;
/** 常量：听荐详情头视图高度，180pt */
UIKIT_EXTERN CGFloat const PPListerRecoDetailHeaderHeight;
/** 常量：课程详情头视图高度，148pt */
UIKIT_EXTERN CGFloat const PPCourseDetailHeaderHeight;
/** 常量：详情底部工具栏高度，55pt */
UIKIT_EXTERN CGFloat const PPDetailBottomToolBarHeight;
/** 常量：大圆角尺寸：5pt */
UIKIT_EXTERN CGFloat const PPBigCornerWidth;
/** 常量：大圆角尺寸：3pt */
UIKIT_EXTERN CGFloat const PPSmallCornerWidth;
/** 常量：详情页默认的书籍介绍的行数：3行 */
UIKIT_EXTERN NSInteger const PPBookDetailIntroduceLines;
/// 常量：少儿馆列表item间距：24.0
UIKIT_EXTERN CGFloat const SEColListItemSpace;
/// 常量：大众馆列表视图cell高度：150pt
UIKIT_EXTERN CGFloat const PPListCellHeight;
/// 常量：少儿馆课程详情titeview高度：160pt
UIKIT_EXTERN CGFloat const SECourseDetailTitleViewHeight;

/// h5：关于我们
FOUNDATION_EXPORT NSString * const PPH5AboutUs;
/// h5：用户协议
FOUNDATION_EXPORT NSString * const PPH5Protocol;
/// h5：隐私协议
FOUNDATION_EXPORT NSString * const PPH5Private;
/// h5：联系我们
FOUNDATION_EXPORT NSString * const PPH5ContactUs;
/// h5：业务合作
FOUNDATION_EXPORT NSString * const PPH5Cooperation;
/// h5：好书频道页
FOUNDATION_EXPORT NSString * const PPH5GoodList;
/// h5：畅销书频道页
FOUNDATION_EXPORT NSString * const PPH5SaleList;

/** 文件名：App数据库名 */
FOUNDATION_EXPORT NSString * const PPDatabaseName;
/** 文件名：书籍表名 */
FOUNDATION_EXPORT NSString * const PPMediumModelTableName;
/** 文件名：目录表名 */
FOUNDATION_EXPORT NSString * const PPCatalogResModelTableName;

/** 微信SDK：APPKey */
FOUNDATION_EXPORT NSString * const WeChatAppID;
/** 微信SDK：APPSecret */
FOUNDATION_EXPORT NSString * const WeChatAppSecret;
/** 微信SDK：取值key-"access_token" */
FOUNDATION_EXPORT NSString * const WeChatAccessToken;
/** 微信SDK：取值key-"openid" */
FOUNDATION_EXPORT NSString * const WeChatOpenId;
/** 微信SDK：取值key-"refresh_token" */
FOUNDATION_EXPORT NSString * const WeChatRefreshToken;
/** 微信SDK：微信apiBaseUrl */
FOUNDATION_EXPORT NSString * const WeChatBaseUrlStr;
/** 微信SDK：获取access_token requestUrl */
FOUNDATION_EXPORT NSString * const WXGetAccessTokenUrlStr;
/** 微信SDK：获取微信用户信息 requestUrl */
FOUNDATION_EXPORT NSString * const WXGetUserInfoUrlStr;

/** 百度SDK：APPKey */
FOUNDATION_EXPORT NSString * const BaiDuAppKey;
/** QQSDK：APPID */
FOUNDATION_EXPORT NSString * const TecentQQAppID;
/** QQSDK：APPKey */
FOUNDATION_EXPORT NSString * const TecentQQAppKey;
/** 新浪微博SDK：APPKey */
FOUNDATION_EXPORT NSString * const SinaBlogAppKey;
/** 新浪微博SDK：APPSecret */
FOUNDATION_EXPORT NSString * const SinaBlogAppSecret;
/** 特殊字符串：AppStore地址 */
FOUNDATION_EXPORT NSString * const AppStoreUrlStr;

/** 文案：充值说明 */
FOUNDATION_EXPORT NSString * const PPRechargeRuleText;
/** 文案：支付说明 */
FOUNDATION_EXPORT NSString * const PPPurchaseRuleText;
/** 文案：活动说明*/
FOUNDATION_EXPORT NSString * const PPCouponRuleText;
/// 文案：凤凰头条标题
FOUNDATION_EXPORT NSString * const PPHeadLineTitleText;

/** 提示语：版本更新 */
FOUNDATION_EXPORT NSString * const PPUpdateVersionTips;
/** 提示语：手机号格式错误 */
FOUNDATION_EXPORT NSString * const PPPhoneNumberErrorTips;
/** 提示语：手机号为空 */
FOUNDATION_EXPORT NSString * const PPPhoneNumberNoneTips;
/** 提示语：没有安装微信 */
FOUNDATION_EXPORT NSString * const PPWeChatUnInstalledTips;
/** 提示语：微信版本低 */
FOUNDATION_EXPORT NSString * const PPWeChatVersionLowerTips;
/** 提示语：网络错误 */
FOUNDATION_EXPORT NSString * const PPNetWorkErrorTips;
/** 提示语：当前移动网络 */
FOUNDATION_EXPORT NSString * const PPNetWorkWWANTips;
/** 提示语：音频播放失败 */
FOUNDATION_EXPORT NSString * const PPAudioPlayerErrorTips;
/** 提示语：内容需要购买 */
FOUNDATION_EXPORT NSString * const PPNeedBuyContentTips;
/** 提示语：修改昵称未填写 */
FOUNDATION_EXPORT NSString * const PPUpdateNicknameNoneTips;
/** 提示语：使用历史数据为空 */
FOUNDATION_EXPORT NSString * const PPUsageHistoryNoneTips;
/** 提示语：我的消息数据为空 */
FOUNDATION_EXPORT NSString * const PPMessageNoneTips;
/** 提示语：我的已购数据为空 */
FOUNDATION_EXPORT NSString * const PPPurchaseRecordNoneTips;
/** 提示语：我的订单数据为空 */
FOUNDATION_EXPORT NSString * const PPOrderNoneTips;
/** 提示语：阅读书签数据为空 */
FOUNDATION_EXPORT NSString * const PPBookMarkNoneTips;
/** 提示语：搜索结果数据为空 */
FOUNDATION_EXPORT NSString * const PPSearchResultNoneTips;
/** 提示语：我的收藏数据为空 */
FOUNDATION_EXPORT NSString * const PPCollectionNoneTips;
/** 提示语：我的下载数据为空 */
FOUNDATION_EXPORT NSString * const PPDownlondNoneTips;
/// 提示语：我的优惠券为空
FOUNDATION_EXPORT NSString * const PPCouponNoneTips;
/** 提示语：无网络占位图文案 */
FOUNDATION_EXPORT NSString * const PPNetworkMissTips;
/// 提示语：邀请好友看分享提示
FOUNDATION_EXPORT NSString * const PPSharePresentTips;
/// 提示语：音频下载提示
FOUNDATION_EXPORT NSString * const PPAudioDownloadTips;
/// 提示语：音频开始下载提示
FOUNDATION_EXPORT NSString * const PPAudioDownloadBeginTips;
/// 提示语：登录协议提示
FOUNDATION_EXPORT NSString * const PPLoginPortocolTips;

/** 通知：token失效 */
FOUNDATION_EXPORT NSString * const PPTokenInvalidNotification;
/** 通知：详情页标题悬停时 */
FOUNDATION_EXPORT NSString * const PPDetailVCTitleViewStopNotification;
/** 通知：详情页标题移动时 */
FOUNDATION_EXPORT NSString * const PPDetailVCTitleViewMoveNotification;
/** 通知：书架视图控制器即将出现 */
FOUNDATION_EXPORT NSString * const PPBookshelfViewWillAppearNotification;
/** 通知：下载进行中 */
FOUNDATION_EXPORT NSString * const PPDownloadProgressNotification;
/** 通知：下载完成 */
FOUNDATION_EXPORT NSString * const PPDownloadCompleteNotification;
/** 通知：下载失败 */
FOUNDATION_EXPORT NSString * const PPDownloadErrorNotification;
/** 通知：内购结果 */
FOUNDATION_EXPORT NSString * const PPInAppPurchaseResultNotification;
/** 通知：购买成功 */
FOUNDATION_EXPORT NSString * const PPPurchaseSuccessNotification;
/** 通知：准备购买 */
FOUNDATION_EXPORT NSString * const PPPreparePurchaseNotification;
/** 通知：登录成功 */
FOUNDATION_EXPORT NSString * const PPLoginSuccessNotification;
/** 通知：收藏状态改变 */
FOUNDATION_EXPORT NSString * const PPCollectStateChangedNotification;
/** 通知：提交新人礼包 */
FOUNDATION_EXPORT NSString * const PPReceiveNewCustoGiftNotification;
/// 通知：凤凰头条热度增加
FOUNDATION_EXPORT NSString * const PPHeadlineHeatHadIncreasedNotification;

/** 系统：universalLink */
FOUNDATION_EXPORT NSString * const PPUniversalLink;
/// 系统：qquniversalLink
FOUNDATION_EXPORT NSString * const PPQQUniversalLink;

/// 有声书标题 - 有声书
FOUNDATION_EXPORT NSString *const PPAudioTitleString;
/// 解读标题 - 好书解读
FOUNDATION_EXPORT NSString *const PPExplainTitleString;
/// 课程标题 - 课程
FOUNDATION_EXPORT NSString *const PPCourseTitleString;
/// 电子书标题 - 电子书
FOUNDATION_EXPORT NSString *const PPEBookTitleString;
/// 专题标题 - 专题
FOUNDATION_EXPORT NSString *const PPSpecialTitleString;
/// 听荐标题 - 头条
FOUNDATION_EXPORT NSString *const PPRecommendTitleString;
/// 凤凰标题 - 凤凰头条
FOUNDATION_EXPORT NSString *const PPHeadlineTitleString;

/// 少儿故事标题 - 故事
FOUNDATION_EXPORT NSString *const SEStoryTitleString;
/// 少儿儿歌标题 - 儿歌
FOUNDATION_EXPORT NSString *const SESongTitleString;
/// 少儿课程标题 - 小学堂
FOUNDATION_EXPORT NSString *const SECourseTitleString;
/// 少儿专题标题 - 专题
FOUNDATION_EXPORT NSString *const SESpecialTitleString;

#endif /* PPConfigConst_h */
