//
//  LJGoodsSpecsCountView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 数量选择视图
@interface LJGoodsSpecsCountView : UIView
/// 当前数量
@property (nonatomic, assign) int currentCount;
/// 最大数量
@property (nonatomic, assign) int maxCount;
/// 最小数量
@property (nonatomic, assign) int minCount;
/// 允许输入框输入
@property (nonatomic, assign) BOOL allowInput;
/// 数量发生变化的回调
@property (nonatomic, copy) void (^countChangedHandle) (int count);
@end

NS_ASSUME_NONNULL_END
