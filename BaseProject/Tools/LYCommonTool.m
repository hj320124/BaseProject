//
//  LYCommonTool.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/18.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "LYCommonTool.h"
#import "NSString+LYUtil.h"

@implementation LYCommonTool

+(UIViewController*)currentViewController{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIViewController * vc = window.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            // 导航栏下的
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+(BOOL)validatePhoneNumber:(NSString *)phoneNumber{
    NSPredicate *rexPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1\\d{10}$"];
    return [rexPre evaluateWithObject:phoneNumber];
//    if (phoneNumber.length != 11) {
//        return NO;
//    }
//    NSString *Moblie = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
//    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
//    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
//    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
//    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Moblie];
//    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if ([regextestMobile evaluateWithObject:phoneNumber] ||
//        [regextestCM evaluateWithObject:phoneNumber] ||
//        [regextestCU evaluateWithObject:phoneNumber] ||
//        [regextestCT evaluateWithObject:phoneNumber]) {
//        return YES;
//    }else{
//        return NO;
//    }
}

+(NSString*)getNotNullStr:(NSString *)orginalStr{
    if (orginalStr == nil || [orginalStr isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return orginalStr;
}

+ (BOOL)isHttpUrl:(NSString *)httpUrl{
    if (httpUrl == nil) {
        return NO;
    }
    if (httpUrl.length < 1){
        return NO;
    }
    if ([httpUrl hasPrefix:@"http"]){
        return YES;
    }
    return NO;
}

#pragma mark -- 获取文件路径

+(NSString*)getDocumentFullPath:(NSString *)appendPath{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:appendPath];
}

+ (NSString *)getCacheFullPath:(NSString *)appendPath{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:appendPath];
}

+ (NSString *)getLibraryFullPath:(NSString *)appendPath{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:appendPath];
}

+(void)createFilePathWithAppendPath:(NSString*)appendPath isDir:(BOOL)isDir type:(LYFilePathTypeDefine)type success:(nonnull void (^)(NSString * _Nonnull))success{
    NSString * path = [self getDocumentFullPath:appendPath];
    if (type == LYFilePathTypeDocument) {
    }else if (type == LYFilePathTypeLibrary){
        path = [self getLibraryFullPath:appendPath];
    }else if (type == LYFilePathTypeCache){
        path = [self getCacheFullPath:appendPath];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        LYTipLog(@"文件地址存在");
        if (success) {
            success(path);
        }
        return;
    }
    // 1文件不存在创建
    BOOL isSuccess = NO;
    if (isDir) {
        // 2文件夹地址
        isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                              withIntermediateDirectories:YES
                                                               attributes:nil
                                                                    error:nil];
        if (isSuccess) {
            LYSuccessLog(@"创建文件夹路径成功");
            if (success) {
                success(path);
            }
        }else{
            LYFailureLog(@"失败时，重复创建直到成功");
            [self createFilePathWithAppendPath:appendPath isDir:YES type:type success:success];
        }
        return;
    }
    // 3文件地址
    isSuccess = [[NSFileManager defaultManager] createFileAtPath:path
                                                        contents:nil
                                                      attributes:nil];
    if (isSuccess) {
        LYSuccessLog(@"创建文件路径成功");
        if (success) {
            success(path);
        }
    }else{
        LYFailureLog(@"失败时，重复创建直到成功");
        [self createFilePathWithAppendPath:appendPath isDir:YES type:type success:success];
    }
}

#pragma mark -- Data LocalStorage

+ (void)archiverData:(id)data storagePath:(NSString *)storagePath{
    if (data == nil) {
        LYLog(@"需归档数据为空");
        return;
    }
    if (@available(iOS 11.0, *)) {
        NSError * error = nil;
        NSData * archivedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
        if (!error) {
            // 直接写入本地
            if ([archivedData writeToFile:storagePath atomically:YES]) {
//                LYSuccessLog(@"存储归档数据成功\n%@",data);
            }else{
                LYFailureLog(@"存储归档数据失败");
            }
        }else{
            LYFailureLog(@"存储归档数据失败");
        }
    } else {
        if ([NSKeyedArchiver archiveRootObject:data toFile:storagePath]) {
//            LYSuccessLog(@"存储归档数据成功\n%@",data);
        }else{
            LYFailureLog(@"存储归档数据失败");
        }
    }
}

+ (id)unarchverData:(Class)classType storagePath:(NSString *)storagePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:storagePath]) {
        return nil;
    }
    if (@available(iOS 11.0, *)) {
        NSError * error = nil;
        NSData * data = [NSData dataWithContentsOfFile:storagePath];
        id unarchivedData = [NSKeyedUnarchiver unarchivedObjectOfClass:classType fromData:data error:&error];
        if (!error) {
//            LYSuccessLog(@"反归档数据成功\n%@",unarchivedData);
            return unarchivedData;
        }else{
            LYFailureLog(@"反归档数据失败");
            return nil;
        }
    } else {
        id unarchivedData = [NSKeyedUnarchiver unarchiveObjectWithFile:storagePath];
        return unarchivedData;
    }
}

+(CGSize)getTextSizeWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text{
    NSDictionary *attr = @{NSFontAttributeName : font
                           };
    CGRect rect = [text boundingRectWithSize:maxSize
                                          options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                       attributes:attr
                                          context:nil];
    return rect.size;
}

+(CGFloat)getTextWidthWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text{
    return [self getTextSizeWithMaxSize:maxSize font:font text:text].width;
}

+(CGFloat)getTextHeightWithMaxSize:(CGSize)maxSize font:(UIFont*)font text:(NSString*)text{
    return [self getTextSizeWithMaxSize:maxSize font:font text:text].height;
}

+ (NSAttributedString *)setParagraphStyleInText:(NSString *)text paragraphParams:(void (^)(NSMutableParagraphStyle * _Nonnull))paragraphParams {
    text = [LYCommonTool getNotNullStr:text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (paragraphParams) {
        paragraphParams(paragraphStyle);
    }
    NSRange range = NSMakeRange(0, [text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

+(NSAttributedString*)setLineSpaceingInText:(NSString *)text lineSpace:(CGFloat)lineSpace{
    text = [LYCommonTool getNotNullStr:text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSRange range = NSMakeRange(0, [text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

+(NSAttributedString*)setLineSpaceingInText:(NSString *)text lineSpace:(CGFloat)lineSpace font:(UIFont*)font{
    NSAttributedString * attrString = [self setLineSpaceingInText:text lineSpace:lineSpace];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:attrString];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attrString length])];
    return attributedString;
}

+(NSAttributedString*)transformHtmlStringToNormalString:(NSString *)htmlString font:(UIFont *)font space:(CGFloat)space{
    if (!htmlString) {
        return [[NSAttributedString alloc]initWithString:@""];
    }
    NSData * htmlData = [htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary * options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                               };
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithData:htmlData
                                                                                         options:options
                                                                              documentAttributes:nil
                                                                                           error:nil];
    NSRange range = NSMakeRange(0, [attributeString length]);
    if (font) {
        [attributeString addAttribute:NSFontAttributeName value:font range:range];
    }
    if (space > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = space;
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    return attributeString;
}

+(NSAttributedString*)transformHtmlStringToNormalString:(NSString *)htmlString font:(UIFont *)font{
    return [self transformHtmlStringToNormalString:htmlString font:font space:0];
}

+(CGSize)getItemAttributeTextSize:(NSAttributedString *)attributeText maxSize:(CGSize)maxSize{
    CGRect rect = [attributeText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}

+(CGFloat)getItemAttributeTextWidth:(NSAttributedString *)attributeText maxSize:(CGSize)maxSize{
    return [self getItemAttributeTextSize:attributeText maxSize:maxSize].width;
}

+(CGFloat)getItemAttributeTextHeight:(NSAttributedString *)attributeText maxSize:(CGSize)maxSize{
    return [self getItemAttributeTextSize:attributeText maxSize:maxSize].height;
}

+ (void)getCacheDataSizeCompletion:(void(^)(NSString * sizeText))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject fileSize];
        size += [SDImageCache sharedImageCache].getSize;   //CustomFile + SDWebImage 缓存
        NSString * sizeText = @"";
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        }else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        }else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        }else {
            sizeText = [NSString stringWithFormat:@"%lluB", size];
        }
        //计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(sizeText);
            }
        });
    });
}

+ (void)clearCache:(void(^)(void))completion{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject  error:nil];
            [mgr createDirectoryAtPath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject  withIntermediateDirectories:YES attributes:nil error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    }];
}

+ (void)callPhoneMethod:(NSString *)phoneNumber{
    NSString *urlStr = [NSString stringWithFormat:@"tel://%@",phoneNumber];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

+ (NSString *)getAppVersionStr{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    return  [dic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppBuildVersionStr{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    return  [dic objectForKey:@"CFBundleVersion"];
}

+ (NSString*)transformNowDateToTimeStamp{
    NSDate * nowDate = [NSDate date];
    NSTimeInterval timeStamp = [nowDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",(long)timeStamp];
}

@end
