//
//  CircleCollectionVC.m
//  BaseProject
//
//  Created by mate on 2018/12/26.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "CircleCollectionVC.h"
#import "CircleFlowLayout.h"
#import "BUIControl.h"
@interface CircleCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,assign)BOOL     is_Click;
@property(nonatomic,strong)CircleFlowLayout *circleLayout;

@end

@implementation CircleCollectionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CircleFlowLayout * layout = [[CircleFlowLayout alloc]init];
    _circleLayout=layout;
    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 400, 400) collectionViewLayout:layout];
    collect.delegate=self;
    collect.dataSource=self;
    collect.center=self.view.center;
    collect.backgroundColor=[UIColor clearColor];
    
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collect];
    _collectionView=collect;
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    btn.center=self.view.center;
    self.circleLayout.isChange=NO;
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        self.circleLayout.isFirst=NO;
        self.circleLayout.isChange=!self.circleLayout.isChange;
        [self.circleLayout invalidateLayout];
        
        
    }];
    self.arr=[NSMutableArray array];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 25;
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%li",indexPath.row);
}

//返回设置数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
     NSInteger itemCount=[self.collectionView numberOfItemsInSection:0];
    CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
    
    for (int i=0; i<itemCount; i++) {
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (self.is_Click) {
            [UIView animateWithDuration:0.5 animations:^{
             attris.transform = CGAffineTransformMakeTranslation(center.x, center.y);
            }];
           
        }else
        {
            [UIView animateWithDuration:0.5 animations:^{
                attris.transform =CGAffineTransformIdentity;
            }];
        }
        
       [_arr addObject:attris];
    }
    
    return _arr;
    
}

@end
