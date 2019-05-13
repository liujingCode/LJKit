////  NSString+LJKit.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LJKit)

/**
 验证是否是正确的手机号
 @return YES 是; NO 否
 */
- (BOOL)lj_validatePhoneNumber;


/**
 获取字符串在指定字体和宽度后所需要的高度

 @param font 字体
 @param width 宽度
 @return 所需要的高度
 */
- (CGFloat)lj_heightWithFont:(UIFont *)font andWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
