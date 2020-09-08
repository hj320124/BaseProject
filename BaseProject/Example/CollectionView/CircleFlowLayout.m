//
//  CircleFlowLayout.m
//  BaseProject
//
//  Created by mate on 2018/12/26.
//  Copyright © 2018年 mate. All rights reserved.
//

#import "CircleFlowLayout.h"

@implementation CircleFlowLayout

-(instancetype)init
{
    if (self=[super init]) {
        self.isChange=NO;
        self.isFirst=YES;
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    NSLog(@"xxxx=>%i,%i",self.isFirst,self.isChange);
    
    _itemCount=[self.collectionView numberOfItemsInSection:0];
    _attributeArr=[NSMutableArray array];
    CGFloat radius=MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2;
    CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
    //设置每个item的大小为50*50 则半径为25
    for (int i=0; i<_itemCount; i++) {
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //设置item大小
        attris.size = CGSizeMake(50, 50);
        if (self.isFirst&&!self.isChange) {
            //计算每个item的圆心位置
            //计算每个item中心的坐标
            //算出的x y值还要减去item自身的半径大小
            float x = center.x+cosf(2*M_PI/_itemCount*i)*(radius-25);
            float y = center.y+sinf(2*M_PI/_itemCount*i)*(radius-25);
            attris.center = CGPointMake(x, y);
        }
        else if (!self.isFirst&&self.isChange)
        {
           
            
            [UIView animateWithDuration:0.5 animations:^{
                 attris.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
                attris.center=center;
            }];
            
           
        }
        else if (!self.isFirst&&!self.isChange)
        {
            
                float x = center.x+cosf(2*M_PI/self->_itemCount*i)*(radius-25);
                float y = center.y+sinf(2*M_PI/self->_itemCount*i)*(radius-25);
                attris.center = CGPointMake(x, y);
          
        }
        [_attributeArr addObject:attris];
    }

    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//返回设置数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return _attributeArr;

}

//通过所在的indexPath确定位置。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path]; //生成空白的attributes对象，其中只记录了类型是cell以及对应的位置是indexPath
    
    //配置attributes到圆周上
//    if (self.isFirst&&!self.isChange) {
//        //计算每个item的圆心位置
//        //计算每个item中心的坐标
//        //算出的x y值还要减去item自身的半径大小
//        float x = center.x+cosf(2*M_PI/_itemCount*i)*(radius-25);
//        float y = center.y+sinf(2*M_PI/_itemCount*i)*(radius-25);
//        attris.center = CGPointMake(x, y);
//    }
//    else if (!self.isFirst&&self.isChange)
//    {
//
//
//        [UIView animateWithDuration:0.5 animations:^{
//            attris.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
//            attris.center=center;
//        }];
//
//
//    }
//    else if (!self.isFirst&&!self.isChange)
//    {
//
//        float x = center.x+cosf(2*M_PI/self->_itemCount*i)*(radius-25);
//        float y = center.y+sinf(2*M_PI/self->_itemCount*i)*(radius-25);
//        attris.center = CGPointMake(x, y);
//
//    }
   
    return attributes;
}

@end
