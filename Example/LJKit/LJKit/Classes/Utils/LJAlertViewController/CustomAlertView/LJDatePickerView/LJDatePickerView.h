//
//  LJDatePickerView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 选择指定范围内的时间
@interface LJDatePickerView : UIView
//// 当前时间
//@property (strong, nonatomic) NSDate *currentDate;
@property (copy, nonatomic) void (^actionHandle) (BOOL isCancel, NSDate * _Nullable selectDate);
@end

NS_ASSUME_NONNULL_END
