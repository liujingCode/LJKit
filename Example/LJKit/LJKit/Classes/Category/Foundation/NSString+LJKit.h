////  NSString+LJKit.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LJKit)


@end

#pragma mark - 数据校验
/// 文本校验
@interface NSString (LJKit_valid)
/// 手机号验证
- (BOOL)lj_isPhoneNumber;
/// 邮箱验证
- (BOOL)lj_isEmail;
/// 车牌号验证
- (BOOL)lj_isCarNumber;
/// 网址验证
- (BOOL)lj_isUrlString;
/// 纯汉字验证
- (BOOL)lj_isChiness;
/// 纯数字验证
- (BOOL)lj_isNumber;
/// 指定长度的纯数字验证
/// @param length 长度
- (BOOL)lj_isNumberWithLength:(int)length;


/// 正则匹配
/// @param regular 校验规则
- (BOOL)lj_isValidWithRegular:(NSString *)regular;

@end

NS_ASSUME_NONNULL_END
