//
//  LJAlertViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LJAlertViewControllerStyle) {
    LJAlertViewControllerStyleDialog,
    LJAlertViewControllerStyleActionSheet,
};
@interface LJAlertViewController : UIViewController

/// 弹框模式
@property (nonatomic, assign) LJAlertViewControllerStyle alertStyle;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(LJAlertViewControllerStyle)alertStyle;

- (void)addAction:(LJAlertAction *)action;
- (void)addTextField:(UITextField *)textField;
@end

NS_ASSUME_NONNULL_END
