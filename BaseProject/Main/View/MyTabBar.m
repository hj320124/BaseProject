//
//  MyTabBar.m
//  Etrotek biker
//
//  Created by hj on 2017/6/2.
//  Copyright © 2017年 顾洲. All rights reserved.
//

#import "MyTabBar.h"
#import "MytabBarButton.h"

@interface MyTabBar ()
//骑车按钮
@property(nonatomic,weak) UIButton *rideButton;
//放按钮的数组

//正在选择的button
@property (nonatomic,weak)UIButton *selectedBtn;



@end

@implementation MyTabBar
//懒加载
-(NSMutableArray*)buttons
{
    if (_buttons==nil) {
        _buttons=[[NSMutableArray alloc] init];
    }
    
    return _buttons;
}


//设置自己的模型
-(void)setItems:(NSArray *)items
{
    _items=items;
    
    for (UITabBarItem *item in _items) {
        MytabBarButton *btn=[MytabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item=item;
        btn.tag=self.buttons.count;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:    UIControlEventTouchDown];
        //设置首页
        if (btn.tag==0) {
            [self BtnClick:btn];
        }
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
  
 
    }
}

//通知tabBar切换控制器
-(void)BtnClick:(UIButton*)btn
{
    _selectedBtn.selected=NO;
    btn.selected=YES;
    _selectedBtn=btn;
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:(int)btn.tag];
    }
}
//
//-(UIButton*)rideButton
//{
//    if (_rideButton==nil) {
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [btn setImage: [UIImage imageNamed:@"运动"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"运动-1"] forState:UIControlStateSelected];
//        
//       
//        [btn sizeToFit];
//        
//        [btn addTarget:self action:@selector(plusBtnClick) forControlEvents:    UIControlEventTouchUpInside ];
//        _rideButton=btn;
//        
//        [self addSubview:_rideButton];
//        
//        
//    }
//    return _rideButton;
//}
//
//
//-(void)plusBtnClick
//{
//    if ([self.delegate respondsToSelector:@selector(tabBardidClickRideButton:)]) {
//        [self.delegate tabBardidClickRideButton:self];
//    }
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x=0;
    CGFloat y=0;
    CGFloat h=self.bounds.size.height;
    CGFloat w=self.bounds.size.width/(self.items.count);
    int i=0;
    
    for (UIView *tabBarBtn in self.buttons) {
        
        x=w*i;
        
        tabBarBtn.frame=CGRectMake(x, y, w, h);
      
        i++;
    }
}

@end
