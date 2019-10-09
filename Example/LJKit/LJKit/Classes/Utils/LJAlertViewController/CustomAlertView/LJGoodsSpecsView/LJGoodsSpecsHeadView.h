//
//  LJGoodsSpecsHeadView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 商品规格选择头部视图
@interface LJGoodsSpecsHeadView : UIView
/// 商品图片地址
@property (nonatomic, copy) NSString *goodsImageAddress;
/// 价格
@property (nonatomic, assign) float price;
/// 库存数量
@property (nonatomic, assign) int stock;
/// 格式化好的信息
@property (nonatomic, copy) NSString *formatInfoStr;

@end

NS_ASSUME_NONNULL_END
