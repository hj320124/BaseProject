//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (Awesome)
static char overlayKey;
static char gradientLayerKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer
{
    return objc_getAssociatedObject(self, &gradientLayerKey);
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer
{
    objc_setAssociatedObject(self, &gradientLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20 + SNRBS_iPhoneX_SPACE_TOP)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_shadowColors:(NSArray *)colors locations:(NSArray<NSNumber *> *)locations height:(CGFloat)height {
    if (!self.overlay) {
        return;
    }
    
    if (!self.gradientLayer) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        //layer.colors = colors;
        //layer.locations = locations;
        layer.opacity = 0.7;
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1.0);
        //layer.frame = CGRectMake(0, CGRectGetHeight(self.overlay.frame), [UIScreen mainScreen].bounds.size.width, height);
        [self.overlay.layer addSublayer:layer];
        
        self.gradientLayer = layer;
    }
    
    self.gradientLayer.colors = colors;
    self.gradientLayer.locations = locations;
    self.gradientLayer.frame = CGRectMake(0, CGRectGetHeight(self.overlay.frame), [UIScreen mainScreen].bounds.size.width, height);;
}

- (void)lt_shadowColor:(UIColor *)backgroundColor {
    [self lt_shadowColors:@[(__bridge id)backgroundColor.CGColor, (__bridge id)backgroundColor.CGColor] locations:@[@0, @1.0] height:0.5];
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.gradientLayer removeFromSuperlayer];
    self.gradientLayer = nil;
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
