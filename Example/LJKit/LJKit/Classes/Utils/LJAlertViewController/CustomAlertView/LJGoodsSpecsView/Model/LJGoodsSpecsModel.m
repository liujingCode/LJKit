//
//  LJGoodsSpecsModel.m
//  LJKit_Example
//
//  Created by developer on 2019/10/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsModel.h"

@implementation LJGoodsSpecsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemList":[LJGoodsSpecsItemModel class],
             };
}
@end
