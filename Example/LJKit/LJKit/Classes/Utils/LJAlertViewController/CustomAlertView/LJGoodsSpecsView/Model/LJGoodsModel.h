//
//  LJGoodsModel.h
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJGoodsSpecsModel.h"
#import "LJGoodsOptionModel.h"
NS_ASSUME_NONNULL_BEGIN
/**
 @"id":@"1000",
 @"title":@"24k土豪披风时尚百搭+生命+抗性+强化99+附魔暴击99%",
 @"thumb":@"",
 @"price":@"",
 @"total":@"",
 @"specs":@[],
 @"option":@[]
 */
/// 商品模型
@interface LJGoodsModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 缩略图
@property (nonatomic, copy) NSString *thumbStr;
/// 总数量
@property (nonatomic, copy) NSString *total;
/// 价格
@property (nonatomic, copy) NSString *price;
/// 规格列表
@property (nonatomic, copy) NSArray <LJGoodsSpecsModel *>*specsList;
/// 选项组合列表
@property (nonatomic, copy) NSArray <LJGoodsOptionModel *>*optionList;
@end

NS_ASSUME_NONNULL_END
