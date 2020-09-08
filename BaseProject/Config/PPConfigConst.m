//
//  PPConfigConst.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/17.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "PPConfigConst.h"

#pragma mark -- About Color
NSString *const PPPrimaryColorValue = @"#D14360";
NSString *const PPLightPrimaryColorValue = @"#FE6178";
NSString *const PPDarkPrimaryColorValue = @"#BD364A";
NSString *const PPAssistColorValue = @"#28344C";
NSString *const PPVipTextColorValue = @"FFE3BB";
NSString *const PPErrorColorValue = @"#E42A2A";
NSString *const PPBigTitleColorValue = @"#000000";
NSString *const PPTitleColorValue = @"#000000";
NSString *const PPHomeTitleColorValue = @"#333333";
NSString *const PPSubTitleColorValue = @"#FFFFFF";
NSString *const PPMainBodyColorValue = @"#666666";
NSString *const PPAssistTextColorValue = @"#BABABA";
NSString *const PPLineColorValue = @"#DDDDDD";
NSString *const PPSplitLineColorValue = @"#E0E0E0";
NSString *const PPBackgroundColorValue = @"#FAFAFA";
NSString *const PPNewBackgroundColorValue = @"#F7F7F7";
NSString *const PPShadowColorValue = @"#CDCDCD";
NSString *const SEIntroColorValue = @"#999999";
NSString *const PPBorderColorValue = @"#D8D8D8";
NSString *const PPButtonGrayColorValue = @"#EEEEEE";
NSString *const PPButtonUnableColorValue = @"#F4F4F4";
NSString *const PPListButtonBackgroundColorValue = @"#F9EFF1";
NSString *const PPTabsTitleColorValue = @"#777777";
NSString *const SEPrimaryColorValue = @"#FF4559";

#pragma mark -- About FontSize

CGFloat const PPBigTitleFontValue = 20.0;
CGFloat const PPTitleFontValue = 18.0;
CGFloat const PPSubTitleFontValue = 16.0;
CGFloat const PPMainBodyFontValue = 14.0;
CGFloat const PPAssistFontValue = 12.0;
CGFloat const PPSmallAssistFontValue = 11.0;

#pragma mark -- About ConstValue

CGFloat const PPBookSizeRatio = (82/115.0);
CGFloat const PPInCommonUseSpace = 15.0;
NSInteger const PPPageLimitCount = 10;
CGFloat const PPAudioDetailHeaderHeight = 200.0;
CGFloat const PPEBookDetailHeaderHeight = 225.0;
CGFloat const PPListerRecoDetailHeaderHeight = 180.0;
CGFloat const PPCourseDetailHeaderHeight = 148.0;
CGFloat const PPDetailBottomToolBarHeight = 55.0;
CGFloat const PPBigCornerWidth = 5.0;
CGFloat const PPSmallCornerWidth = 3.0;
NSInteger const PPBookDetailIntroduceLines = 3;
CGFloat const SEColListItemSpace = 24.0;
CGFloat const PPListCellHeight = 150.0;
CGFloat const SECourseDetailTitleViewHeight = 160.0;

#pragma mark -- About h5

NSString * const PPH5AboutUs = @"about";
NSString * const PPH5Protocol = @"agreement";
NSString * const PPH5Private = @"privacy";
NSString * const PPH5ContactUs = @"contact-us";
NSString * const PPH5Cooperation = @"cooperation";
NSString * const PPH5GoodList = @"good-list";
NSString * const PPH5SaleList = @"sale-list";

#pragma mark -- About fileName

NSString * const PPDatabaseName = @"PhoenixBookPubDB";
NSString * const PPMediumModelTableName = @"PPMediumModelTable";
NSString * const PPCatalogResModelTableName = @"PPCatalogResModelTable";

#pragma mark -- About Tips

NSString * const PPUpdateVersionTips = @"检测到新版本，是否前往更新";
NSString * const PPPhoneNumberNoneTips = @"手机号不能为空";
NSString * const PPPhoneNumberErrorTips = @"手机号码格式有误";
NSString * const PPWeChatUnInstalledTips = @"请先安装微信客户端";
NSString * const PPWeChatVersionLowerTips = @"当前微信版本过低";
NSString * const PPNetWorkErrorTips = @"网络异常，请检查网络设置";
NSString * const PPNetWorkWWANTips = @"当前为移动网络，是否继续使用";
NSString * const PPAudioPlayerErrorTips = @"播放失败，请稍后重试";
NSString * const PPNeedBuyContentTips = @"您还没有订购此内容，请先去购买哦";
NSString * const PPUpdateNicknameNoneTips = @"请填写需要修改的昵称";
NSString * const PPUsageHistoryNoneTips = @"暂无使用历史";
NSString * const PPMessageNoneTips = @"暂无消息";
NSString * const PPPurchaseRecordNoneTips = @"暂无购买记录";
NSString * const PPOrderNoneTips = @"暂无订单";
NSString * const PPBookMarkNoneTips = @"您还没有添加书签哦 ~";
NSString * const PPSearchResultNoneTips = @"找不到相关作品";
NSString * const PPCollectionNoneTips = @"暂无收藏";
NSString * const PPDownlondNoneTips = @"暂无下载记录";
NSString * const PPCouponNoneTips = @"暂无优惠券";
NSString * const PPNetworkMissTips = @"很抱歉，当前网络异常，请稍后再试";
NSString * const PPSharePresentTips = @"分享20个知识礼物，邀请好友一起来读!";
NSString * const PPAudioDownloadTips = @"请选择需要下载的音频";
NSString * const PPAudioDownloadBeginTips = @"开始下载音频";
NSString * const PPLoginPortocolTips = @"请先阅读并同意凤凰书苑用户协议与隐私政策";

NSString * const PPRechargeRuleText = @"充值/赠送说明：\n1.书币的兑换比例为1元=1书币。\n2.充值金额/赠送金额不能提现、不能退款，仅限于iOS APP购买、虚拟产品使用，iOS系统与非iOS系统余额不能通用。\n3.充值到账时间可能有延时，请勿在短时间（1-10分钟）内重复充值。如扣款一小时后仍未到账，可拨打“凤凰书苑”客服电话400-106-6600，我们会及时为您解决。";
NSString * const PPCouponRuleText = @"1.书币的兑换比例为1元=1书币。\n2.充值金额/赠送金额不能提现、不能退款，仅限于iOS APP购买、虚拟产品使用，iOS系统与非iOS系统余额不能通用。\n3.充值到账时间可能有延时，请勿在短时间（1-10分钟）内重复充值。如扣款一小时后仍未到账，可拨打“凤凰书苑”客服电话400-106-6600，我们会及时为您解决。";
NSString * const PPPurchaseRuleText = @"支付说明：\n1.您将购买的商品为虚拟内容服务，购买后不支持退订、转让和退换，请斟酌确认。\n2.购买后可在“我的已购”区查看和使用。";
NSString * const PPHeadLineTitleText = @"凤凰头条，以“这世界，需要解释”为口号，每天一个话题，用极具启发性的思想洞见，为你解释这个世界。";

#pragma mark -- About OpenPlatform

NSString * const WeChatAppID = @"wx8df52c50da9474d4";
NSString * const WeChatAppSecret = @"76a9051aaa77bee8ec0d989daa3a1cf4";
NSString * const WeChatAccessToken = @"access_token";
NSString * const WeChatOpenId = @"openid";
NSString * const WeChatRefreshToken = @"refresh_token";
NSString * const WeChatBaseUrlStr = @"https://api.weixin.qq.com";
NSString * const WXGetAccessTokenUrlStr = @"/sns/oauth2/access_token";
NSString * const WXGetUserInfoUrlStr = @"/sns/userinfo";

NSString * const BaiDuAppKey = @"2c4aab6150";
NSString * const TecentQQAppID = @"101623450";
NSString * const TecentQQAppKey = @"053ec34764ea67165b5150c1b1c6d173";
NSString * const SinaBlogAppKey = @"2713704693";
NSString * const SinaBlogAppSecret = @"3e7d9d59053e68d6e191277aa89e7bc6";

NSString * const AppStoreUrlStr = @"https://itunes.apple.com/cn/app/linkmore/id1468074230?mt=8";

#pragma mark -- About Notification

NSString * const PPTokenInvalidNotification = @"PPTokenInvalidNotfication";
NSString * const PPDetailVCTitleViewStopNotification = @"PPDetailVCTitleViewStopNotification";
NSString * const PPDetailVCTitleViewMoveNotification = @"PPDetailVCTitleViewMoveNotification";
NSString * const PPBookshelfViewWillAppearNotification = @"PPBookshelfViewWillAppearNotification";
NSString * const PPDownloadProgressNotification = @"PPDownloadProgressNotification";
NSString * const PPDownloadCompleteNotification = @"PPDownloadCompleteNotification";
NSString * const PPDownloadErrorNotification = @"PPDownloadErrorNotification";
NSString * const PPInAppPurchaseResultNotification = @"PPInAppPurchaseResultNotification";
NSString * const PPPurchaseSuccessNotification = @"PPPurchaseSuccessNotification";
NSString * const PPPreparePurchaseNotification = @"PPPreparePurchaseNotification";
NSString * const PPLoginSuccessNotification = @"PPLoginSuccessNotification";
NSString * const PPCollectStateChangedNotification = @"PPCollectStateChangedNotification";
NSString * const PPReceiveNewCustoGiftNotification = @"PPReceiveNewCustoGiftNotification";
NSString * const PPHeadlineHeatHadIncreasedNotification = @"PPHeadlineHeatHadIncreasedNotification";

NSString * const PPUniversalLink = @"https://app.ppmbook.com/";
NSString * const PPQQUniversalLink = @"https://app.ppmbook.com/qq_conn/101623450";

#pragma mark >> DefineTitle <<

NSString *const PPAudioTitleString = @"有声书";
NSString *const PPExplainTitleString = @"好书解读";
NSString *const PPCourseTitleString = @"课程";
NSString *const PPEBookTitleString = @"电子书";
NSString *const PPSpecialTitleString = @"专题";
NSString *const PPRecommendTitleString = @"听荐";
NSString *const PPHeadlineTitleString = @"凤凰头条";

NSString *const SEStoryTitleString = @"故事";
NSString *const SESongTitleString = @"儿歌";
NSString *const SESpecialTitleString = @"专题";
NSString *const SECourseTitleString = @"小学堂";
