//
//  LYNavigationBarItemModel.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2020/6/24.
//  Copyright © 2020 PPMG. All rights reserved.
//

#import "LYNavigationBarItemModel.h"

@implementation LYNavigationBarItemModel

+ (LYNavigationBarItemModel *)modelWithImageName:(NSString *)imageName title:(NSString *)title isLeft:(BOOL)isLeft {
    LYNavigationBarItemModel *model = [[LYNavigationBarItemModel alloc] init];
    model.imageName = imageName;
    model.title = title;
    model.isLeft = isLeft;
    return model;
}

+ (LYNavigationBarItemModel *)modelWithLeftImgName:(NSString *)leftImgName {
    return [LYNavigationBarItemModel modelWithImageName:leftImgName
                                                  title:nil
                                                 isLeft:YES];
}

+ (LYNavigationBarItemModel *)modelWithRightImgName:(NSString *)rightimgName {
    return [LYNavigationBarItemModel modelWithImageName:rightimgName
                                                  title:nil
                                                 isLeft:NO];
}

+ (LYNavigationBarItemModel *)modelWithLeftTitle:(NSString *)leftTitle {
    return [LYNavigationBarItemModel modelWithImageName:nil
                                                  title:leftTitle
                                                 isLeft:YES];
}

+ (LYNavigationBarItemModel *)modelWithRightTitle:(NSString *)rightTitle {
    return [LYNavigationBarItemModel modelWithImageName:nil
                                                  title:rightTitle
                                                 isLeft:NO];
}

- (UIImage *)image {
    return [UIImage imageNamed:self.imageName];
}

@end
