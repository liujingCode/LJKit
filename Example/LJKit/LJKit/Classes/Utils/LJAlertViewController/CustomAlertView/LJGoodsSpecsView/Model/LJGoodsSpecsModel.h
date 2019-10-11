//
//  LJGoodsSpecsModel.h
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJGoodsSpecsItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LJGoodsSpecsModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 规格选项列表
@property (nonatomic, copy) NSArray <LJGoodsSpecsItemModel *>*itemList;
@end

NS_ASSUME_NONNULL_END
