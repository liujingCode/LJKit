//
//  LJGoodsSpecsCollectionView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJGoodsSpecsCollectionView : UICollectionView
/// 规格数组
@property (nonatomic, copy) NSArray *specsList;
/// 所有的选项
@property (nonatomic, copy) NSArray *optionList;

+ (instancetype)defaultSpecsCollectionView;
@end

NS_ASSUME_NONNULL_END
