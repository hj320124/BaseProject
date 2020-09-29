//
//  LYNavgationBarView.m
//  PhoenixBookPub
//
//  Created by beckmoon on 2019/5/20.
//  Copyright © 2019 beckmoon. All rights reserved.
//

#import "LYNavigationBarView.h"
#import "LYCommonTool.h"
@interface LYNavigationBarView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) NSArray *leftBarItemArray;
@property (nonatomic, strong) NSArray *rightBarItemArray;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat leftBarItemX;// 左侧控件x轴位置
@property (nonatomic, assign) CGFloat rightBarItemX;// 右侧控件x轴位置
@property (nonatomic, assign) CGFloat barItemHeight;// 控件的高度
@property (nonatomic, assign) CGFloat controlSpacing;//控件之间间距

@end

@implementation LYNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame
                     barTitle:(NSString *)barTitle
                    leftTitle:(NSString *)leftTitle
                    leftImage:(NSString *)leftImage
                   rightTitle:(NSString *)rightTitle
                   rightImage:(NSString *)rightImage {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubviewsWithBarTitle:barTitle
                                leftTitle:leftTitle
                                leftImage:leftImage
                               rightTitle:rightTitle
                               rightImage:rightImage];
    }
    return self;
}

+ (LYNavigationBarView *)createGeneralNavigationBarViewWithBarTitle:(NSString *)barTitle
                                                          leftTitle:(NSString *)leftTitle
                                                          leftImage:(NSString *)leftImage
                                                         rightTitle:(NSString *)rightTitle
                                                         rightImage:(NSString *)rightImage {
    CGRect generalRect = CGRectMake(0, 0, ScreenWidth, NavgationFullHeight);
    LYNavigationBarView *navigationBarView =
    [[LYNavigationBarView alloc] initWithFrame:generalRect
                                      barTitle:barTitle
                                     leftTitle:leftTitle
                                     leftImage:leftImage
                                    rightTitle:rightTitle
                                    rightImage:rightImage];
    return navigationBarView;
}

- (void)p_setupSubviewsWithBarTitle:(NSString *)barTitle
                          leftTitle:(NSString *)leftTitle
                          leftImage:(NSString *)leftImage
                         rightTitle:(NSString *)rightTitle
                         rightImage:(NSString *)rightImage {
    [self p_addBottomLine];
    [self p_addLeftButton:leftTitle leftImage:leftImage];
    [self p_addRightButton:rightTitle rightImage:rightImage];
    [self p_addBarTitleLabel:barTitle];
}

-(void)p_addBottomLine{
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.frame = CGRectMake(0, self.height-1, self.width, 1);
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:PPLineColorValue];
    [self addSubview:self.bottomLine];
}

-(void)setBackgroundImage:(NSString *)backgroundImage{
    _backgroundImage = backgroundImage;
    if (!_backgroundImage) {
        return;
    }
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.frame = self.bounds;
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundImageView.clipsToBounds = YES;
    if ([backgroundImage hasPrefix:@"http"] || [backgroundImage hasPrefix:@"https"]) {
        [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:backgroundImage]];
    }else{
        self.backgroundImageView.image = [UIImage imageNamed:backgroundImage];
    }
    [self insertSubview:self.backgroundImageView atIndex:0];
}

-(void)p_addBarTitleLabel:(NSString *)barTitle{
    if (barTitle == nil) {
        return;
    }
    self.titleLabel = [[UILabel alloc]init];
//    self.titleLabel.text = barTitle;
    self.titleText = barTitle;
    self.titleLabel.font = UIFont.systemFont(PPTitleFontValue);
    self.titleLabel.textColor = [UIColor colorWithHexString:PPTitleColorValue];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    CGFloat titleLeft = self.leftButton ? (self.leftButton.right+15) : 15;
    CGFloat titleRight = self.rightButton ? (self.rightButton.width+30) : 15;
    CGFloat titleMagin = (titleLeft > titleRight ? titleLeft : titleRight);
    CGFloat titleWidth = ScreenWidth - 2*titleMagin;
    self.titleLabel.frame = CGRectMake(titleMagin, StatusBarHeight, titleWidth, 44);
}

-(void)p_addLeftButton:(NSString *)leftTitle
             leftImage:(NSString *)leftImage{
    if ((leftTitle == nil) && (leftImage == nil)) {
        return;
    }
    self.leftButton = [self p_createBarButtonWithButtonTitle:leftTitle
                                                   imageName:leftImage
                                                      action:@selector(p_clickLeftButton)];
    if (leftTitle) {
        [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
        CGFloat textWidth = [self.leftButton.titleLabel getTextWidthWithMaxSize:CGSizeMake(100, MAXFLOAT)];
        self.leftButton.frame = CGRectMake(15,StatusBarHeight, ceilf(textWidth), 44);
        self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    if (leftImage) {
        UIImage * image = [UIImage imageNamed:leftImage];
        [self.leftButton setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
        self.leftButton.frame = CGRectMake(15, StatusBarHeight, image.size.width, 44);
        if ([leftImage isEqualToString:@"icon_back_dark"]) {
          self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        }
        self.leftButton.enlarge_edge(0,15,0,15);
    }
}

-(void)p_addRightButton:(NSString *)rightTitle
             rightImage:(NSString *)rightImage{
    if ((rightTitle == nil) && (rightImage == nil)) {
        return;
    }
    self.rightButton =
    [self p_createBarButtonWithButtonTitle:rightTitle
                                 imageName:rightImage
                                    action:@selector(p_clickRightButton)];
    if (rightTitle) {
        CGFloat textWidth = [self.rightButton.titleLabel getTextWidthWithMaxSize:CGSizeMake(100, MAXFLOAT)];
        self.rightButton.frame = CGRectMake(self.width - textWidth - 15,StatusBarHeight, ceilf(textWidth), 44);
        self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    if (rightImage) {
        UIImage * image = [UIImage imageNamed:rightImage];
        self.rightButton.frame = CGRectMake(self.width - image.size.width - 15, StatusBarHeight, image.size.width, 44);
        self.rightButton.enlarge_edge(0,15,0,15);
    }
}

- (void)addRightButtonItem:(NSString *)rightTitle
                rightImage:(NSString *)rightImage {
    if ((rightTitle == nil) && (rightImage == nil)) {
           return;
       }
       self.rightButton =
       [self p_createBarButtonWithButtonTitle:rightTitle
                                    imageName:rightImage
                                       action:@selector(p_clickRightButton)];
       if (rightTitle) {
           CGFloat textWidth = [self.rightButton.titleLabel getTextWidthWithMaxSize:CGSizeMake(100, MAXFLOAT)];
           self.rightButton.frame = CGRectMake(self.width - textWidth - 15,StatusBarHeight, ceilf(textWidth), 44);
           self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
       }
       if (rightImage) {
           UIImage * image = [UIImage imageNamed:rightImage];
           self.rightButton.frame = CGRectMake(self.width - image.size.width - 15, StatusBarHeight, image.size.width, 44);
           self.rightButton.enlarge_edge(0,15,0,15);
       }
    
}

- (UIButton *)p_createBarButtonWithButtonTitle:(NSString *)buttonTitle
                                     imageName:(NSString *)imageName
                                        action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    if (buttonTitle) {
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:PPTitleColorValue] forState:UIControlStateNormal];
        button.titleLabel.font = UIFont.systemFont(15);
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    return button;
}

- (void)pageScrollToChangeColorAlpha:(CGFloat)alpha {
    self.titleColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
    self.lineAlpha = alpha;
}

-(void)p_clickLeftButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarView:didSelectLeftButton:)]) {
        [self.delegate navigationBarView:self didSelectLeftButton:self.leftButton];
    }
}

-(void)p_clickRightButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarView:didSelectRightButton:)]) {
        [self.delegate navigationBarView:self didSelectRightButton:self.rightButton];
    }
}

-(void)setHideLine:(BOOL)hideLine{
    _hideLine = hideLine;
    self.bottomLine.hidden = _hideLine;
}

- (void)setLineAlpha:(CGFloat)lineAlpha{
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:PPLineColorValue alpha:lineAlpha];
}

-(void)setBackImage:(NSString *)backImage{
    _backImage = backImage;
    if (!_backImage) {
        return;
    }
    [self.leftButton setImage:[UIImage imageNamed:_backImage] forState:UIControlStateNormal];
}

- (void)setRightImage:(NSString *)rightImage{
    _rightImage = rightImage;
    if (!_rightImage) {
        return;
    }
    [self.rightButton setImage:[UIImage imageNamed:_rightImage] forState:UIControlStateNormal];
}

- (void)setTitleText:(NSString *)titleText{
    if (!titleText) {
        return;
    }
    _titleText = titleText;
    if (titleText.length > 0) {
        self.titleLabel.hidden = NO;
    }else{
        self.titleLabel.hidden = YES;
    }
    self.titleLabel.text = titleText;
}

- (void)setTitleColor:(UIColor *)titleColor{
    if (!titleColor) {
        return;
    }
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setHideTitle:(BOOL)hideTitle{
    if (_hideTitle == hideTitle) {
        return;
    }
    _hideTitle = hideTitle;
    self.titleLabel.hidden = hideTitle;
}

#pragma mark -- 以下是新增方法

+ (LYNavigationBarView *)createSystemStyleBarWithTitle:(NSString *)title leftBarItemArray:(NSArray<LYNavigationBarItemModel *> *)leftBarItemArray rightBarItemArray:(NSArray<LYNavigationBarItemModel *> *)rightBarItemArray {
    CGRect rect = CGRectMake(0, 0, ScreenWidth, NavgationFullHeight);
    LYNavigationBarView *barView = [[LYNavigationBarView alloc] initWithFrame:rect
                                                                        title:title
                                                             leftBarItemArray:leftBarItemArray
                                                            rightBarItemArray:rightBarItemArray];
    return barView;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title leftBarItemArray:(NSArray<LYNavigationBarItemModel *> *)leftBarItemArray rightBarItemArray:(NSArray<LYNavigationBarItemModel *> *)rightBarItemArray {
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.leftBarItemArray = leftBarItemArray;
        self.rightBarItemArray = rightBarItemArray;
        [self p_initData];
        [self p_initSubviews];
    }
    return self;
}

- (void)p_initData {
    self.leftBarItemX = 15;
    self.rightBarItemX = self.width-15;
    self.controlSpacing = 20;
    self.barItemHeight = self.height-StatusBarHeight;
}

- (void)p_initSubviews {
    // 左边区域
    if (self.leftBarItemArray.count > 0) {
        NSMutableArray *leftItems = [NSMutableArray array];
        [self.leftBarItemArray enumerateObjectsUsingBlock:^(LYNavigationBarItemModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self p_addButtonWithModel:model
                                                   action:@selector(p_clickLeftBarItem:)];

            button.tag = 1000+idx;
            [leftItems addObject:button];
        }];
        self.leftItems = leftItems;
    }
    
    // 右边区域
    if (self.rightBarItemArray.count > 0) {
        NSMutableArray *rightItems = [NSMutableArray array];
        [self.rightBarItemArray enumerateObjectsUsingBlock:^(LYNavigationBarItemModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self p_addButtonWithModel:model
                                                   action:@selector(p_clickRightBarItem:)];
            button.tag = 2000+idx;
            [rightItems addObject:button];
        }];
        self.rightItems = rightItems;
    }
    
    if (self.title) {
        // 标题
        CGFloat titleLeft = self.leftBarItemX;
        CGFloat titleRight = self.width - self.rightBarItemX;
        CGFloat titleMagin = (titleLeft > titleRight ? titleLeft : titleRight);
        CGFloat titleWidth = self.width - 2*titleMagin;
        UILabel *labal = [[UILabel alloc] init];
        labal.frame = CGRectMake(titleMagin, StatusBarHeight, titleWidth, self.barItemHeight);
        labal.font = UIFont.systemFont(PPTitleFontValue);
        labal.textColor = [UIColor colorWithHexString:PPTitleColorValue];
        labal.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labal];
        self.titleLabel = labal;
        self.titleText = self.title;
    }
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.frame = CGRectMake(0, self.height-1, self.width, 1);
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:PPLineColorValue];
    [self addSubview:self.bottomLine];
}

- (UIButton *)p_addButtonWithModel:(LYNavigationBarItemModel *)model action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    CGFloat width = 0;
    if (model.imageName) {
        // 如果是图片
        width = model.image.size.width;
        [button setImage:model.image forState:UIControlStateNormal];
    } else if (model.title) {
        // 如果是标题
        width = [LYCommonTool getTextWidthWithMaxSize:CGSizeMake(self.width/2-15, self.height)
                                                 font:UIFont.systemFont(15)
                                                 text:model.title];
        width = ceilf(width);
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        button.titleLabel.font = UIFont.systemFont(15);
    }
    
    if (model.isLeft) {
        button.frame = CGRectMake(self.leftBarItemX, StatusBarHeight, width, self.barItemHeight);
        self.leftBarItemX += width+self.controlSpacing;
        button.enlarge_edge(0, 15, 0, 15);
    } else {
        self.rightBarItemX -= width;
        button.frame = CGRectMake(self.rightBarItemX, StatusBarHeight, width, self.barItemHeight);
        self.rightBarItemX -= self.controlSpacing;
        button.enlarge_edge(0, 15, 0, 15);
    }
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)p_clickLeftBarItem:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarView:didSelectLeftBarItemWithIndex:)]) {
        [self.delegate navigationBarView:self didSelectLeftBarItemWithIndex:sender.tag-1000];
    }
}

- (void)p_clickRightBarItem:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarView:didSelectRightBarItemWithIndex:)]) {
        [self.delegate navigationBarView:self didSelectRightBarItemWithIndex:sender.tag-2000];
    }
}

@end
