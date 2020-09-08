//
//  CollectionViewVC.m
//  testDemo
//
//  Created by mate on 2018/12/19.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "CollectionViewVC.h"
#import "MyCollectionViewFlowLayout.h"
#import "BUIControl.h"
#import "HomeProtocol.h"
//增加的n倍数
#define KAddNums 6
#define KOriginalCount [self.originalArr count]
#define KItemWidth  ([UIScreen mainScreen].bounds.size.width-40)
#define KAutoTime 3

@interface CollectionViewVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger currenRow;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSArray        *originalArr;
@end

@implementation CollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    MyCollectionViewFlowLayout *layout=[[MyCollectionViewFlowLayout alloc] init];
layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
  
    // Do any additional setup after loading the view.
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self loadData];
    [self addBtn];
    
}




-(void)loadData
{
    _originalArr=@[@"1",@"2",@"3",@"4",@"5"];
    self.arr=[NSMutableArray array];
    for (int i=0; i<6; i++) {
        [self.arr addObjectsFromArray:_originalArr];
    }
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.arr.count/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.currenRow = self.arr.count/2;
    
}

-(void)addBtn
{
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    btn.center=self.view.center;
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        //根据代理注册获取控制器，避免依赖，模块化开发
        UIViewController<TestVCProtocol> *TestVC = [[JSObjection defaultInjector] getObject:@protocol(TestVCProtocol) ];
        //注册路由
        NSURL *url=pushUrl(NSStringFromClass([TestVC class]));
        [[JLRoutes routesForScheme:RouteScheme] routeURL:url withParameters:@{@"name":@"collectionView路由跳转"}];
        
    }];
    
}


- (void)addTimer
{
    if (!_timer) {
         _timer = [NSTimer scheduledTimerWithTimeInterval:KAutoTime target:self selector:@selector(nextPage) userInfo:NULL repeats:YES];
    }
   
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed=YES;
    [self addTimer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed=NO;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr.count;
}


// 定时器的内容
- (void)nextPage
{
  
    self.currenRow++;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currenRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

//自动滑动完成触发的方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    self.currenRow=scrollView.contentOffset.x/KItemWidth ;
    NSLog(@"ccc=>%li",self.currenRow);
    
    if (self.currenRow >=KOriginalCount*(KAddNums-2)) {
        self.currenRow =self.arr.count/2+(self.currenRow-self.arr.count/2)%5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currenRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
        
    }
    else if(self.currenRow <KOriginalCount*(KAddNums-4)){
        self.currenRow = KOriginalCount*(KAddNums-4)+self.currenRow;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currenRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
}


#pragma mark ----ScrollView 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.currenRow=scrollView.contentOffset.x/KItemWidth;
     NSLog(@"ccc=>%li",self.currenRow);
    
    if (self.currenRow >=KOriginalCount*(KAddNums-2)) {
         self.currenRow =self.arr.count/2+(self.currenRow-self.arr.count/2)%5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currenRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
       

    }
    else if(self.currenRow <KOriginalCount*(KAddNums-4)){
        self.currenRow = KOriginalCount*(KAddNums-4)+self.currenRow;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currenRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
   
          [self addTimer];
 
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
    // 移除定时器
    [self.timer invalidate];
    self.timer = nil;
    
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, KItemWidth, 100)];
    label.text=[NSString stringWithFormat:@"第%@个",self.arr[indexPath.row]];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    
    [cell.contentView addSubview:label];
   
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KItemWidth ,100 );
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger row=indexPath.row;
    if (indexPath.row>=5) {
        row=indexPath.row%5;
    }
    NSLog(@"点击了==>%li",row);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer=nil;
}

-(void)dealloc
{
    
    NSLog(@"dealloc==>%@",[self class]);
    
}


@end
