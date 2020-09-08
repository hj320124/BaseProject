//
//  MyCollectionViewFlowLayout.m
//  testDemo
//
//  Created by mate on 2018/12/19.
//  Copyright © 2018年 mate. All rights reserved.
//

/*
 *1.将系统的bouns的改变无效的方法设置为yes
 *2.重写attribues方法，计算attribue与center的位置来决定缩放大小
 *2.在滑动中，手离开屏幕确认中心，重写targetPropose方法，找出距离屏幕最近的item，并返回这个点给系统
 
 */

#import "MyCollectionViewFlowLayout.h"

@interface MyCollectionViewFlowLayout()

@property (nonatomic,assign) CGFloat centerScale;

@property (nonatomic,assign) CGFloat nearbyScale;

@end

@implementation MyCollectionViewFlowLayout

-(instancetype)init
{
    if (self=[super init]) {
        _centerScale = 0.9f;
        _nearbyScale = 0.7f;
    }
    return self;
}

//让本地的方法无效
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    //取到系统默认的attrubute
    NSArray *attributes=[self deepCopyArr:[super layoutAttributesForElementsInRect:rect]];
    //计算当前collectionview中间的位置x
    CGFloat currentCenterX=self.collectionView.contentOffset.x+self.collectionView.bounds.size.width/2;
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        CGFloat itemX=attribute.center.x;
        CGFloat delta=ABS(itemX-currentCenterX);
       // 这里取最小值是因为距离大于一个collectionView宽度的计算出来也没有用,不会显示
        //
        delta = MIN(delta, self.collectionView.bounds.size.width);
        //算出缩放,距离越远，缩放越大
        CGFloat scale=(self.nearbyScale-self.centerScale)*delta/self.collectionView.bounds.size.width+self.centerScale;
        attribute.transform=CGAffineTransformMakeScale(1, scale);
        
    }
    
    return attributes;
}


//-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//
//{
//    // 1.1拿到系统已经算好的布局.
//
//    NSArray *attributes =[self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]] ;
//
//    // 1.2 计算当前collectionView的中间位置的x值
//
//    CGFloat currentCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0;
//
//    // 1.3遍历当前rect内所有layoutAttributes,计算它跟currentCenterX的距离,距离越远,计算出的缩放值越小,再赋值给layoutAttributes
//
//    for (UICollectionViewLayoutAttributes *attri in attributes) {
//
//        CGFloat itemCenterX = attri.center.x;
//
//        CGFloat delta = ABS(currentCenterX - itemCenterX);
//
//        // 这里取最小值是因为距离大于一个collectionView宽度的计算出来也没有用,不会显示
//
//        delta = MIN(delta, self.collectionView.bounds.size.width);
//
//        CGFloat scale = (self.nearbyScale - self.centerScale) * delta / self.collectionView.bounds.size.width + self.centerScale;
//
//        attri.transform = CGAffineTransformMakeScale(1, scale);
////        attri.transform = CGAffineTransformMakeRotation(45);
//
//    }
//
//    return attributes;
//
//}

//当手放开的时候,让离中间最近的item居中.当我们手滑动collectionView后离开,系统会立即调用下面的方法,proposedContentOffset就是系统算好的原本的目标位置,重写该方法,找出离得最近的item,根据这个item计算出新的targetContentOffset并返回给系统,即可实现.

//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//
//    CGRect rect;
//    rect.origin.y=0;
//    rect.origin.x=proposedContentOffset.x;
//    rect.size=self.collectionView.frame.size;
//    //找出离中心最近的点
//    NSArray *attribues=[self layoutAttributesForElementsInRect:rect];
//    CGFloat centerX=proposedContentOffset.x+self.collectionView.bounds.size.width/2;
//    CGFloat targetOffsetX=MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attribue in attribues) {
//
//        if (ABS(targetOffsetX)>ABS(centerX-attribue.center.x)) {
//            targetOffsetX=attribue.center.x-centerX;
//        }
//
//    }
//
//    return CGPointMake(targetOffsetX+proposedContentOffset.x, proposedContentOffset.y);
//
//}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity

{
    // final rect

    CGRect rect;

    rect.origin.y = 0;

    rect.origin.x = proposedContentOffset.x;

    rect.size = self.collectionView.frame.size;

    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];

    // find nearest item

    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;

    CGFloat targetOffSetX = MAXFLOAT;

    for (UICollectionViewLayoutAttributes *attribute in attributes) {

        if (ABS(targetOffSetX) > ABS(centerX - attribute.center.x)) {

            targetOffSetX = attribute.center.x - centerX;

        }

    }

    return CGPointMake(proposedContentOffset.x + targetOffSetX, proposedContentOffset.y);
}


-(void)prepareLayout
{
    [super prepareLayout];
//     CGFloat left=20;
//    self.sectionInset=UIEdgeInsetsMake(0, left, 0, left);
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal; self.collectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    
}

-(NSArray*)deepCopyArr:(NSArray*)arr
{
    NSMutableArray *arrM=[NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribue in arr) {
        [arrM addObject:[attribue copy]];
    }

    return arrM;
}
//-(void)prepareLayout
//
//{
//    [super prepareLayout];
//
////    CGFloat left = (self.collectionView.bounds.size.width - self.itemSize.width) / 2.0;
//
//    CGFloat left =20;
////
//    self.sectionInset = UIEdgeInsetsMake(0, left, 0, left);
//
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//    // 让collectionView滑动的慢一点,分页效果就出来了.
//
//    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
//
//}
//
//
//-(NSArray *)deepCopyWithArray:(NSArray *)arr {
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (UICollectionViewLayoutAttributes *attr in arr) {
//        [arrM addObject:[attr copy]];
//
//    }
//    return arrM;
//
//
//}



@end
