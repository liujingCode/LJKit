//
//  LJToast.h
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LJToastStyle) {
    LJToastStylePlain,
    LJToastStyleLoading,
    LJToastStyleProgress,
};
@interface LJToast : UIView

/// 当前进度
@property (nonatomic, assign) float progress;


/// 展示文字
/// @param text 文本
+ (instancetype)showToastWithText:(NSString *)text;

/// 展示图片
/// @param image 图片
+ (instancetype)showToastWithImage:(UIImage *)image;

/// 展示文本+图片
/// @param text 文本
/// @param image 图片
+ (instancetype)showToastWithText:(NSString *)text andImage:(UIImage *)image;


/// 展示loading
/// @param text 文本
+ (instancetype)showLoadingWithText:(NSString *)text;

/// 展示loading
/// @param image 图片
+ (instancetype)showLoadingWithImage:(UIImage *)image;

/// 展示loading
/// @param text 文本
/// @param image 图片
+ (instancetype)showLoadingWithText:(NSString *)text andImage:(UIImage *)image;


/// 展示进度条
/// @param text 文本
+ (instancetype)showProgressWithText:(NSString *)text;


/// 移除toast
- (void)dismissToast;
@end

NS_ASSUME_NONNULL_END
