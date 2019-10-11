//
//  LJGoodsModel.m
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsModel.h"

@implementation LJGoodsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"specsList":[LJGoodsSpecsModel class],
             @"optionList":[LJGoodsOptionModel class],
             };
}
@end
