//
//  LYCommonTool.h
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/18.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LYFilePathTypeDefine){
    LYFilePathTypeDocument,
    LYFilePathTypeLibrary,
    LYFilePathTypeCache,
};
@interface LYCommonTool : NSObject

/**
 获取当前控制器

 @return 当前控制器
 */
+(UIViewController*)currentViewController;

/**
 判断手机号格式是否正确

 @param phoneNumber 预判断手机号
 @return 是否是格式
 */
+(BOOL)validatePhoneNumber:(NSString*)phoneNumber;

/**
 返回非nil字符串
 
 @param orginalStr 原始字符串
 @return 最终的字符串
 */
+(NSString *)getNotNullStr:(NSString*)orginalStr;

/**
 是否是有效链接

 @param httpUrl url字符串
 @return 是否为有效链接
 */
+(BOOL)isHttpUrl:(NSString*)httpUrl;

/**
 Doucment地址

 @param appendPath 拼接地址
 @return 全地址
 */
+(NSString*)getDocumentFullPath:(NSString*)appendPath;

/**
 Cache地址

 @param appendPath 拼接地址
 @return 全地址
 */
+(NSString*)getCacheFullPath:(NSString*)appendPath;

/**
 Library地址

 @param appendPath 拼接地址
 @return 全地址
 */
+(NSString*)getLibraryFullPath:(NSString*)appendPath;

/**
 创建文件路径

 @param appendPath 文件或文件夹名
 @param isDir 是否为文件夹
 @param type 相对路径
 @param success 成功回调
 */
+(void)createFilePathWithAppendPath:(NSString*)appendPath isDir:(BOOL)isDir type:(LYFilePathTypeDefine)type success:(void(^)(NSString*path))success;

/**
 归档

 @param data 归档数据
 @param storagePath 归档路径
 */
+(void)archiverData:(nonnull id)data storagePath:(nonnull NSString*)storagePath;

/**
 反归档

 @param classType 固定存放数据类型
 @param storagePath 反归档路径
 @return 反归档获取到的数据
 */
+(id)unarchverData:(Class)classType storagePath:(NSString*)storagePath;

/**
 获取文本size

 @param maxSize 最大尺寸
 @param font 字体大小
 @param text 文本
 @return textSize
 */
+(CGSize)getTextSizeWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text;

/**
 获取文本宽度

 @param maxSize 最大尺寸
 @param font 字体大小
 @param text 文本
 @return textWidth
 */
+(CGFloat)getTextWidthWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text;

/**
 获取文本高度

 @param maxSize 最大尺寸
 @param font 字体大小
 @param text 文本
 @return textHeight
 */
+(CGFloat)getTextHeightWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text;

/**
 设置文本行间距
 
 @param text 文本
 @param lineSpace 行间距
 */
+(NSAttributedString*__nullable)setLineSpaceingInText:(NSString*__nullable)text lineSpace:(CGFloat)lineSpace;

/// 设置文本段落属性
/// @param text 文本
/// @param paragraphParams 段落参数
+ (NSAttributedString* )setParagraphStyleInText:(NSString *)text
                                paragraphParams:(void(^)(NSMutableParagraphStyle *paragraphStyle))paragraphParams;

/**
 设置文本行间距（方便计算自适应行高）
 
 @param text 文本
 @param lineSpace 行间距
 @param font 文本字体大小
 */
+(NSAttributedString*__nullable)setLineSpaceingInText:(NSString *__nullable)text lineSpace:(CGFloat)lineSpace font:(UIFont*__nullable)font;

/**
 带有html标签的字符串转化为普通字符串(设置间距)
 
 @param htmlString 标签
 @param font 字体
 @param space 间距
 */
+(NSAttributedString*__nullable)transformHtmlStringToNormalString:(NSString *__nullable)htmlString
                                                             font:(UIFont *__nullable)font
                                                            space:(CGFloat)space;
/**
 带有html标签的字符串转化为普通字符串
 
 @param htmlString 含标签的字串
 @param font 字体
 */
+(NSAttributedString*__nullable)transformHtmlStringToNormalString:(NSString*__nullable)htmlString
                                                             font:(UIFont*__nullable)font;

/**
 计算富文本的尺寸
 
 @param attributeText 富文本
 @param maxSize 输入文本的最大尺寸
 */
+(CGSize)getItemAttributeTextSize:(NSAttributedString*__nullable)attributeText
                          maxSize:(CGSize)maxSize;
/**
 计算富文本的宽度
 
 @param attributeText 富文本
 @param maxSize 输入文本的最大尺寸
 */
+(CGFloat)getItemAttributeTextWidth:(NSAttributedString*__nullable)attributeText
                            maxSize:(CGSize)maxSize;
/**
 计算富文本的高度
 
 @param attributeText 富文本
 @param maxSize 输入文本的最大尺寸
 */
+(CGFloat)getItemAttributeTextHeight:(NSAttributedString*__nullable)attributeText
                             maxSize:(CGSize)maxSize;

/**
 获取缓存大小

 @param completion 完成回调
 */
+(void)getCacheDataSizeCompletion:(void(^)(NSString * sizeText))completion;

/**
 清除缓存

 @param completion 完成回调
 */
+(void)clearCache:(void(^)(void))completion;


/**
 调用系统打电话方法

 @param phoneNumber 电话号码
 */
+(void)callPhoneMethod:(NSString*__nullable)phoneNumber;

/**
 获取App版本号

 @return app版本号
 */
+(NSString*)getAppVersionStr;

/**
 获取App构建版本号

 @return app构建版本号
 */
+ (NSString *)getAppBuildVersionStr;

/**
 获取当前时间戳

 @return 时间戳
 */
+ (NSString*)transformNowDateToTimeStamp;

@end

NS_ASSUME_NONNULL_END
