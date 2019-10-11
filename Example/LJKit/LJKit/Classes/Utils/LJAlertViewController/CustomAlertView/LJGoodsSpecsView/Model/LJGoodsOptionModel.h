//
//  LJGoodsOptionModel.h
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 @"id":@"",
 @"goodsid":@"1000",
 @"thumb":@"",
 @"price":@"9.9",
 @"stock":@"100",
 @"title":@"红色+L码",
 @"specs":@"10000101_10000203"
 */
@interface LJGoodsOptionModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 缩略图
@property (nonatomic, copy) NSString *thumb;
/// 价格
@property (nonatomic, copy) NSString *price;
/// 库存
@property (nonatomic, copy) NSString *stock;
/// 规格
@property (nonatomic, copy) NSString *specs;
@end

NS_ASSUME_NONNULL_END
