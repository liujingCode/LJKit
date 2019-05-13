////  UIView+LJKit.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LJKit)
/** 宽度 */
@property(assign, nonatomic) CGFloat lj_width;
/** 高度 */
@property(assign, nonatomic) CGFloat lj_height;
/** 坐标X */
@property(assign, nonatomic) CGFloat lj_x;
/** 坐标Y */
@property(assign, nonatomic) CGFloat lj_y;
/** 中心点X */
@property(assign, nonatomic) CGFloat lj_centerX;
/** 中心点Y */
@property(assign, nonatomic) CGFloat lj_centerY;
/** Size */
@property(assign, nonatomic) CGSize lj_size;
/** 坐标 */
@property(assign, nonatomic) CGPoint lj_origin;

/** 圆角半径 */
@property(assign, nonatomic) IBInspectable CGFloat lj_cornerRadius;
/** 边框颜色 */
@property(copy, nonatomic) IBInspectable UIColor *lj_borderColor;
/** 边框宽度 */
@property(assign, nonatomic) IBInspectable CGFloat lj_borderWidth;
/** 阴影透明度 */
@property (assign, nonatomic) IBInspectable CGFloat lj_shadowOpacity;
/** 阴影偏移量 */
@property (assign, nonatomic) IBInspectable CGSize lj_shadowOffset;
/** 阴影半径 */
@property (assign, nonatomic) IBInspectable CGFloat lj_shadowRadius;

// 弹框

/**
 提示框
 @param title 需要提示的内容
 */
- (void)showWithTitle:(NSString *)title;
/**
 提示框
 @param title 需要提示的内容
 @param image 图片
 */
- (void)showWithTitle:(NSString *)title andImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
