//
//  UIButton+LJKit.h
//  LJKit_Example
//
//  Created by developer on 2019/11/15.
//  Copyright © 2019 liujing. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LJKit)

@end



/// 协议按钮
@interface LJAgreementButton : UIControl
/// 是否同意
@property (nonatomic, assign,readonly) BOOL isAgree;

/// 文本属性配置
@property (nonatomic, copy) NSDictionary <NSAttributedStringKey,id>*textAttributes;
/// 协议属性配置
@property (nonatomic, copy) NSDictionary <NSAttributedStringKey,id>*agreementAttributes;

/// 初始化协议按钮
/// @param string 字符串 示例:请先阅读并同意:<a>《注册协议》</a>
+ (instancetype)buttonWithString:(NSString *)string;

/// 初始化协议按钮
/// @param string 字符串 示例:请先阅读并同意:《注册协议》
/// @param agreementString 协议字符串 示例:《注册协议》
+ (instancetype)buttonWithString:(NSString *)string andAgreementString:(NSString *)agreementString;
@end


/// 倒计时按钮
@interface LJCountDownButton : UIControl
/// 倒计时数
@property (nonatomic, assign) NSTimeInterval count;

/// 点击按钮的回调
@property (nonatomic, copy) void (^clickHandle) (void);
/// 开始倒计时
- (void)startCountDown;
/// 结束倒计时
- (void)stopCountDown;
@end


NS_ASSUME_NONNULL_END
