//
//  LJToast.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJToast.h"
// duration
static const NSTimeInterval kLJToast_plain_duration            = 3.0;
//
//// duration
//static const NSTimeInterval kLJToast_plain_duration            = 3.0;

@interface LJToast ()
@property (nonatomic, strong) MBProgressHUD *currentHud;
@end


@implementation LJToast
@synthesize progress = _progress;
+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJToast new];
    });
    return instance;
}


+ (instancetype)showToastWithText:(NSString *)text {
    return [self showWithStyle:LJToastStylePlain andText:text andDetailText:nil andImage:nil andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}
+ (instancetype)showToastWithImage:(UIImage *)image {
    return [self showWithStyle:LJToastStylePlain andText:nil andDetailText:nil andImage:image andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}
+ (instancetype)showToastWithText:(NSString *)text andImage:(UIImage *)image {
    return [self showWithStyle:LJToastStylePlain andText:text andDetailText:nil andImage:image andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}

+ (instancetype)showLoadingWithText:(NSString *)text {
    return [self showWithStyle:LJToastStyleLoading andText:text andDetailText:nil andImage:nil andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}
+ (instancetype)showLoadingWithImage:(UIImage *)image {
    return [self showWithStyle:LJToastStyleLoading andText:nil andDetailText:nil andImage:image andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}
+ (instancetype)showLoadingWithText:(NSString *)text andImage:(UIImage *)image {
    return [self showWithStyle:LJToastStyleLoading andText:text andDetailText:nil andImage:image andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}

+ (instancetype)showProgressWithText:(NSString *)text {
    return [self showWithStyle:LJToastStyleProgress andText:text andDetailText:nil andImage:nil andDuration:kLJToast_plain_duration andEnableInteraction:NO];
}


+ (instancetype)showWithStyle:(LJToastStyle)style andText:(NSString *)text andDetailText:(NSString *)detailText andImage:(UIImage *)image andDuration:(NSTimeInterval)duration andEnableInteraction:(BOOL)enableInteraction {
    // 单例对象
    LJToast *sharedToast = [LJToast sharedInstance];
    
    
    MBProgressHUDMode hudMode;
    switch (style) {
        case LJToastStylePlain:
            hudMode = MBProgressHUDModeCustomView;
            break;
        case LJToastStyleProgress:
            hudMode = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        case LJToastStyleLoading:
            hudMode = MBProgressHUDModeCustomView;
            break;
        default:
            hudMode = MBProgressHUDModeCustomView;
            break;
    }
    
    
    
    UIView *superView = enableInteraction?[self lj_toastTopView]:[self lj_toastWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    sharedToast.currentHud = hud;
    // hud模式
    hud.mode = hudMode;
    // 是否强制 HUD 背景框宽高相等
    hud.square = NO;
    
    // 隐藏时将HUD从其父视图中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 中间方框不需要高斯模糊
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 中间方框的背景色
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    
    // 文字的颜色
    hud.contentColor = [UIColor whiteColor];
    // 文字的大小
    hud.label.font = [UIFont systemFontOfSize:16.0];
    hud.detailsLabel.font = [UIFont systemFontOfSize:13.0];
    
    // 图片
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // 标题
    hud.label.text = text;
    // 详细描述
    hud.detailsLabel.text = detailText;
    
    // 普通toast
    if (style == LJToastStylePlain) {
        // 自动消失
        [hud hideAnimated:YES afterDelay:duration];
    }
    
    return sharedToast;
}

#pragma mark - 属性set和get方法
- (float)progress {
    return self.currentHud.progress;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    
    self.currentHud.progress = progress;
}

#pragma mark - dismiss
- (void)dismissToast {
    [self.currentHud hideAnimated:YES afterDelay:0];
}


#pragma mark - 获取window
/// 获取window
+ (UIView *)lj_toastWindow {
    return [UIApplication sharedApplication].delegate.window;
}

/// 获取最顶层controller的view
+ (UIView *)lj_toastTopView {
    return [UIApplication sharedApplication].delegate.window;
}
@end
