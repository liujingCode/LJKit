//
//  LJAlertCheckPwdView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LJAlertCheckPwdViewAction) {
    LJAlertCheckPwdViewActionComplete = 0,
    LJAlertCheckPwdViewActionCancel,
    LJAlertCheckPwdViewActionForgetPwd,
};

typedef void (^LJAlertCheckPwdViewActionHandle)(LJAlertCheckPwdViewAction action, NSString * _Nullable password);

/// 方块密码
@interface LJAlertCheckPwdView : UIView
/// 事件回调
@property (nonatomic, copy) LJAlertCheckPwdViewActionHandle actionHandle;
@end

NS_ASSUME_NONNULL_END
