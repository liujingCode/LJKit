////  UIImage+LJKit.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LJKit)
/**
 根据颜色创建一张1*1的图片
 
 @param color 图片颜色
 @return 大小为1*1的图片
 */
+ (instancetype)lj_imageWithColor:(UIColor *)color;

/**
 根据颜色创建一张图片

 @param size 图片尺寸
 @param color 图片颜色
 @return 大小为指定尺寸的图片
 */
+ (instancetype)lj_imageWithSize:(CGSize)size andColor:(UIColor *)color;

/**
 圆角图片
 
 @param radius 圆角值
 @return 剪裁好的图片
 */
- (instancetype)lj_imageWithCornerRadius:(CGFloat)radius;


@end

NS_ASSUME_NONNULL_END
