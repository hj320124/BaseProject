//
//  PPTabBar.m
//  PhoenixBookPub
//
//  Created by imac2015-2 on 2019/11/5.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "PPTabBar.h"
#import "PPTabBarButton.h"

static NSString * const PPTaBbarMusicBtnAnimationKey = @"PPTaBbarMusicBtnAnimationKey";

@interface PPTabBar ()
//正在选择的button
@property (nonatomic,weak)   UIButton *selectedBtn;

@property (nonatomic,strong) UIImageView *bgView;

@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,assign) BOOL isRotate;//是否在旋转

@end

@implementation PPTabBar

//设置自己的模型
- (void)setItems:(NSArray *)items {
    _items = items;
    for (UITabBarItem *item in _items) {
        PPTabBarButton *btn = [PPTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents: UIControlEventTouchDown];
        //设置首页
        if (btn.tag == 0) {
            [self BtnClick:btn];
        }
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

//通知tabBar切换控制器
- (void)BtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
      [self.delegate tabBar:self didClickButton:(int)btn.tag];
    }
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
}

- (UIButton *)musicBtn {
    if (_musicBtn == nil) {
        _musicBtn = [[UIButton alloc] init];
        [_musicBtn setImage: [UIImage imageNamed:@"icon_tabbar_musicPause"] forState:UIControlStateNormal];
        [_musicBtn addTarget:self action:@selector(musicBtnClick) forControlEvents:    UIControlEventTouchUpInside ];
        [self addSubview:_musicBtn];
    }
    return _musicBtn;
}

- (void)musicBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBardidClickMusicButton:)]) {
        [self.delegate tabBardidClickMusicButton:self.musicBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, BottomSafeHeight, 0));
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(BottomSafeHeight);
    }];
    
    CGFloat x = 0;
    CGFloat y = 10;
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width / (self.items.count + 1);
    int i = 0;
    for (UIView *tabBarBtn in self.buttons) {
        x = w * i;
        tabBarBtn.frame = CGRectMake(x, y, w, h);
        i++;
        if (i == 2) {
            i = 3;
            self.musicBgView.frame = CGRectMake(x, 2, 42, 42);
            self.musicBgView.centerX = self.centerX;
            self.musicBtn.frame = self.musicBgView.frame;
        }
    }
}

- (void)updateMusicBtnImage:(NSString *)photoStr {
    if (IsStrEmpty(photoStr)) {
        return;
    }
    self.isRotate = NO;
    if (!self.isRotate) {
        [self rotate360DegreeWithImageView:self.musicBgView];
    }
}

- (void)updateMusicBtnState {
}

- (void)updateProgressView {
}

//图片旋转方法
- (void)rotate360DegreeWithImageView:(UIView *)imageView {
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2.0, 0.0, 0.0, 1.0) ];
    animation.duration = 3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    [imageView.layer addAnimation:animation forKey:PPTaBbarMusicBtnAnimationKey];
    self.isRotate = YES;
}

//懒加载
- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [[NSMutableArray alloc] init];
    }
    
    return _buttons;
}

- (UIImageView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"icon_tabbar_bgView"];
        _bgView.contentMode= UIViewContentModeScaleAspectFill;
        _bgView.clipsToBounds=YES;
        [self addSubview:_bgView];
        [self sendSubviewToBack:_bgView];
    }
    return _bgView;
}

- (UIImageView *)musicBgView {
    if (_musicBgView == nil) {
        _musicBgView = [[UIImageView alloc] init];
        _musicBgView.contentMode= UIViewContentModeScaleAspectFill;
        _musicBgView.clipsToBounds=YES;
        _musicBgView.userInteractionEnabled = YES;
        _musicBgView.backgroundColor = [UIColor whiteColor];
        _musicBgView.layer.cornerRadius = 21.5;
        [self insertSubview:_musicBgView aboveSubview:self.bgView];
    }
    return _musicBgView;
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
    }
    return _whiteView;
}

@end
