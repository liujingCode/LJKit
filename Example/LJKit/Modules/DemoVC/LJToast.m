//
//  LJToast.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJToast.h"
@interface LJToast ()
@property (nonatomic, strong) MBProgressHUD *currentHud;
@end


@implementation LJToast

+ (void)showWithStyle:(LJToastStyle)style andText:(NSString *)text andDetailText:(NSString *)detailText andImage:(UIImage *)image andDuration:(NSTimeInterval)duration andEnableInteraction:(BOOL)enableInteraction {
    
}

+ (void)showToastWithText:(NSString *)text andDetailText:(NSString *)detailText andImage:(UIImage *)image andDuration:(NSTimeInterval)duration andEnableInteraction:(BOOL)enableInteraction; {
    
    UIView *superView = [LJToast lj_toastWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    // 自定义toast
    hud.mode = MBProgressHUDModeCustomView;
    // 是否强制 HUD 背景框宽高相等
    hud.square = NO;
    
    // 背景色
//    hud.backgroundColor = [UIColor redColor];
    // 隐藏时将HUD从其父视图中移除
    hud.removeFromSuperViewOnHide = YES;
    // 中间方框的背景色
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    // 文字的颜色
    hud.contentColor = [UIColor whiteColor];
    // 文字的大小
    hud.label.font = [UIFont systemFontOfSize:24.0];
    hud.detailsLabel.font = [UIFont systemFontOfSize:13.0];
    
    
    
    // 图片
    image = nil;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // 标题
    hud.label.text = text;
    // 详细描述
    hud.detailsLabel.text = detailText;
    // 自动消失
    [hud hideAnimated:YES afterDelay:10];
}

+ (void)showProgressWithText:(NSString *)text andImage:(UIImage *)image andEnableInteraction:(BOOL)enableInteraction {
    UIView *superView = [LJToast lj_toastWindow];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        // 自定义toast
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        // 是否强制 HUD 背景框宽高相等
        hud.square = NO;
        
        // 背景色
    //    hud.backgroundColor = [UIColor redColor];
        // 隐藏时将HUD从其父视图中移除
        hud.removeFromSuperViewOnHide = YES;
        // 中间方框的背景色
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        // 文字的颜色
        hud.contentColor = [UIColor whiteColor];
        // 文字的大小
        hud.label.font = [UIFont systemFontOfSize:24.0];
        hud.detailsLabel.font = [UIFont systemFontOfSize:13.0];
        
        
        
        // 图片
//        image = nil;
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // 标题
        hud.label.text = text;
        // 自动消失
        [hud hideAnimated:YES afterDelay:10];
}




#pragma mark - 获取window

/// 获取window
+(UIView *)lj_toastWindow {
    return [UIApplication sharedApplication].delegate.window;
}
@end
