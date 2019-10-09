//
//  LJGoodsSpecsView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 商品规格选择
@interface LJGoodsSpecsView : UIView

/// 规格数组
@property (nonatomic, copy) NSArray *specsList;
/// 所有的选项
@property (nonatomic, copy) NSArray *optionList;

+ (instancetype)defaultView;
@end

NS_ASSUME_NONNULL_END
