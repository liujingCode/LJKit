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

+ (instancetype)showWithText:(NSString *)text;
+ (instancetype)showWithImage:(UIImage *)image;
+ (instancetype)showWithText:(NSString *)text andImage:(UIImage *)image;





+ (void)showToastWithText:(NSString *)text andDetailText:(NSString *)detailText andImage:(UIImage *)image andDuration:(NSTimeInterval)duration andEnableInteraction:(BOOL)enableInteraction;

+ (void)showProgressWithText:(NSString *)text andImage:(UIImage *)image andEnableInteraction:(BOOL)enableInteraction;

+ (void)showLoadingWithText:(NSString *)text andImage:(UIImage *)image andEnableInteraction:(BOOL)enableInteraction;

+ (void)showWithStyle:(LJToastStyle)style andText:(NSString *)text andDetailText:(NSString *)detailText andImage:(UIImage *)image andDuration:(NSTimeInterval)duration andEnableInteraction:(BOOL)enableInteraction;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
