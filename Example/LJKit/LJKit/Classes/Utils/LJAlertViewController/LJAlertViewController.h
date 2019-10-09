//
//  LJAlertViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface LJAlertViewController : UIViewController

/// 弹框模式
@property (nonatomic, assign) UIAlertControllerStyle alertStyle;


/**
 使用show
 */

/// 展示自定义view的弹框 (类方法,不需要自定义控制器)
/// @param containerView 自定义view
/// @param alertStyle 弹框类型
+ (instancetype)showWithContainerView:(UIView *)containerView alertStyle:(UIAlertControllerStyle)alertStyle;


/// 展示自定义view的弹框 (对象方法,需要自定义控制器)
/// @param containerView 自定义view
/// @param alertStyle 弹框类型
- (void)showWithContainerView:(UIView *)containerView alertStyle:(UIAlertControllerStyle)alertStyle;

/// 隐藏
- (void)dismissAlert;
@end

NS_ASSUME_NONNULL_END
