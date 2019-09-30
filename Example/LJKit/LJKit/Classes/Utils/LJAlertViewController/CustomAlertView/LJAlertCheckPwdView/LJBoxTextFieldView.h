//
//  LJBoxTextFieldView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 方块类型的输入框
@interface LJBoxTextFieldView : UIView

/// 输入框个数
@property (nonatomic, assign) int boxCount;

/// 输入完成的回调
@property (nonatomic, copy) void (^completeHandle)(NSString *password);
@end

NS_ASSUME_NONNULL_END
