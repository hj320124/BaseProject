//
//  UIViewController+LYUtil.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/20.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "UIViewController+LYUtil.h"

static char customNavigationBarViewKey;
@implementation UIViewController (LYUtil)

- (void)setupSystemStyleNavigationBarViewWithTitle:(NSString *)title leftImages:(NSArray *)leftImages rightImages:(NSArray *)rightImages {
    NSArray *leftBarItemArray = [self p_getBarItemArray:leftImages isLeft:YES];
    NSArray *rightBarItemArray = [self p_getBarItemArray:rightImages isLeft:NO];
    LYNavigationBarView *barView = [LYNavigationBarView createSystemStyleBarWithTitle:title
                                                                     leftBarItemArray:leftBarItemArray
                                                                    rightBarItemArray:rightBarItemArray];
    barView.delegate = self;
    [self.view addSubview:barView];
    self.customNavigationBarView = barView;
}

- (NSArray *)p_getBarItemArray:(NSArray *)imagesArray isLeft:(BOOL)isLeft{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *name in imagesArray) {
        LYNavigationBarItemModel *model = [LYNavigationBarItemModel modelWithImageName:name
                                                                                 title:nil
                                                                                isLeft:isLeft];
        [array addObject:model];
    }
    return array;
}

-(void)setupNormalNavigationBarViewWithBarTitle:(NSString *)barTitle
                                      leftTitle:(NSString *)leftTitle
                                      leftImage:(NSString *)leftImage
                                     rightTitle:(NSString *)rightTitle
                                     rightImage:(NSString *)rightImage{
    LYNavigationBarView * barView = [LYNavigationBarView createGeneralNavigationBarViewWithBarTitle:barTitle
                                                                                        leftTitle:leftTitle
                                                                                        leftImage:leftImage
                                                                                       rightTitle:rightTitle
                                                                                       rightImage:rightImage];
    barView.delegate = self;
    [self.view addSubview:barView];
    self.customNavigationBarView = barView;
}

-(void)setupNormalNavigationBarViewWithBarTitle:(NSString *)barTitle{
    [self setupNormalNavigationBarViewWithBarTitle:barTitle
                                         leftTitle:nil
                                         leftImage:nil
                                        rightTitle:nil
                                        rightImage:nil];
}

-(void)setupNormalNavigationBarViewBackStyleWithBarTitle:(NSString *)barTitle{
    [self setupNormalNavigationBarViewWithBarTitle:barTitle
                                         leftTitle:nil
                                         leftImage:@"icon_back_dark"
                                        rightTitle:nil
                                        rightImage:nil];
}

-(void)setCustomNavigationBarView:(LYNavigationBarView *)customNavigationBarView{
    objc_setAssociatedObject(self, &customNavigationBarViewKey, customNavigationBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LYNavigationBarView*)customNavigationBarView{
    return objc_getAssociatedObject(self, &customNavigationBarViewKey);
}

-(void)navigationBarView:(LYNavigationBarView *)navigationBarView didSelectLeftButton:(UIButton *)sender{
    if (self.navigationController.viewControllers.count > 1) {
       [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)navigationBarView:(LYNavigationBarView *)navigationBarView didSelectLeftBarItemWithIndex:(NSInteger)index {
    if (index == 0) {
        if (self.navigationController.viewControllers.count > 1) {
           [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}



- (void)addNormalAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction * _Nonnull))handler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)addSingleAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction * _Nonnull))handler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:okAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)handleAudioPlayerCloseAction{
    /// ⚠️关闭播放器移除播放器，存在风险
//    // 当有播放器存在时，关闭播放器，不会再进入播放页，直接返回最上级页面
//    NSUInteger total = self.navigationController.childViewControllers.count;
//    LYLog(@"当前导航下控制器：%@",self.navigationController.childViewControllers);
//    if (total < 3) {
//        return;
//    }
//    if (![[LYCommonTool currentViewController] isKindOfClass:[self class]]) {
//        //因为进入登录页面关闭播放器，不用再处理移除播放器事件
//        return;
//    }
//    NSUInteger currentDetailIndex = total - 1;
//    NSUInteger lastPlayerIndex = currentDetailIndex - 1;
//    [self removeDeprecatedViewController:NSMakeRange(lastPlayerIndex, 1)];
}

- (void)removeDeprecatedViewController:(NSRange)range{
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithArray:self.navigationController.childViewControllers];
    [childViewControllers removeObjectsInRange:range];
    [self.navigationController setViewControllers:childViewControllers];
}

@end
