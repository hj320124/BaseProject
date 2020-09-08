//
//  CircleFlowLayout.h
//  BaseProject
//
//  Created by mate on 2018/12/26.
//  Copyright © 2018年 mate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleFlowLayout : UICollectionViewFlowLayout
{
    NSMutableArray *_attributeArr;
    NSInteger       _itemCount;
}
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL isFirst;

@end

NS_ASSUME_NONNULL_END
