////  NSString+LJKit.m
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import "NSString+LJKit.h"

@implementation NSString (LJKit)

@end

#pragma mark - 数据校验
@implementation NSString (LJKit_valid)
/// 手机号验证
- (BOOL)lj_isPhoneNumber {
    // 手机号以13， 14，15，17，18，19开头，八个 \d 数字字符
    NSString *regular = @"^(13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[0-9])[0-9]{8}$";
    return [self lj_isValidWithRegular:regular];
}
/// 邮箱验证
- (BOOL)lj_isEmail {
    NSString *regular = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self lj_isValidWithRegular:regular];
}
/// 车牌号验证
- (BOOL)lj_isCarNumber {
    NSString *regular = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    return [self lj_isValidWithRegular:regular];
}
/// 网址验证
- (BOOL)lj_isUrlString {
    NSString *regular = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self lj_isValidWithRegular:regular];
}
/// 纯汉字验证
- (BOOL)lj_isChiness {
    NSString *regular = @"^[\u4e00-\u9fa5]+$";
    return [self lj_isValidWithRegular:regular];
}
/// 纯数字验证
- (BOOL)lj_isNumber {
    NSString *regular = @"^[0-9]*$";
    return [self lj_isValidWithRegular:regular];
}
/// 指定长度的纯数字验证
/// @param length 长度
- (BOOL)lj_isNumberWithLength:(int)length {
    NSString *regular = [NSString stringWithFormat:@"^[0-9]{%d}$",length];
    return [self lj_isValidWithRegular:regular];
}

/// 正则匹配
/// @param regular 校验规则
- (BOOL)lj_isValidWithRegular:(NSString *)regular {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular] evaluateWithObject:self];
}
@end
