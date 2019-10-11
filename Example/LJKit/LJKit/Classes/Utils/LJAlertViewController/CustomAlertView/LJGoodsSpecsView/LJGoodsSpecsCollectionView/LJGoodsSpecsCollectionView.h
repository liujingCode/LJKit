//
//  LJGoodsSpecsCollectionView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJGoodsSpecsModel;
@class LJGoodsOptionModel;
NS_ASSUME_NONNULL_BEGIN

@interface LJGoodsSpecsCollectionView : UICollectionView
/// 规格列表
@property (nonatomic, copy) NSArray <LJGoodsSpecsModel *>*specsList;
/// 选项组合列表
@property (nonatomic, copy) NSArray <LJGoodsOptionModel *>*optionList;

@property(copy, nonatomic) void (^clickOptionItemHandle) (NSArray <NSIndexPath *>*selectedIndexPaths, LJGoodsOptionModel *optionModel);


+ (instancetype)defaultSpecsCollectionView;
@end

NS_ASSUME_NONNULL_END
