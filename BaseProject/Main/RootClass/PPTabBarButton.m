//
//  PPTabBarButton.m
//  PhoenixBookPub
//
//  Created by imac2015-2 on 2019/11/5.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "PPTabBarButton.h"

@implementation PPTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor: [UIColor colorWithHexString:@"#A0A6B3"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:PPPrimaryColorValue] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.clipsToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:PPSmallAssistFontValue];
    }
    return self;
}

//传递模型

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    //    kvo监听属性的变化
    [item addObserver:self forKeyPath:@"title" options:  NSKeyValueObservingOptionNew  context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setTitle:_item.title forState: UIControlStateNormal ];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //imageView的高度
    CGFloat imageX = 0;
    CGFloat imageY = 3;
    CGFloat imageW = 30;
    CGFloat imageH = 30;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    //    //titleLabel的高度
    CGFloat titleX = 0;
    CGFloat titleY = imageH + 2;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = 15;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.imageView.centerX = self.titleLabel.centerX;
}

- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"title"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
}


@end
