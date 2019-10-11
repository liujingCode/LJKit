//
//  LJGoodsOptionSelectedModel.h
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJGoodsSpecsModel;
@class LJGoodsOptionModel;
NS_ASSUME_NONNULL_BEGIN

/// 已经选择了的商品
@interface LJGoodsOptionSelectedModel : NSObject
/// id
@property (nonatomic, copy) NSString *optionid;
/// 数量
@property (nonatomic, assign) int count;
/// 规格列表
@property (nonatomic, copy) NSArray <LJGoodsSpecsModel *>*specsList;

/// 已经确定了商品
@property (nonatomic, strong) LJGoodsOptionModel *optionModel;
@end

NS_ASSUME_NONNULL_END
