//
//  LJAlertViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertViewController.h"
#import "LJAlertContainerView.h"

// 是否是iPhoneX
BOOL isIPhoneX () {
    return [UIApplication sharedApplication].statusBarFrame.size.height > 20;
}

@interface LJAlertViewController ()
@property (nonatomic, weak) UIControl *backgroundMaskView;
@property (nonatomic, weak) UIView *contentView;
@end

@implementation LJAlertViewController


+ (instancetype)showWithContainerView:(UIView *)containerView alertStyle:(UIAlertControllerStyle)alertStyle {
    LJAlertViewController *alertVC = [self new];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVC animated:NO completion:nil];
    });
    
    [alertVC showWithContainerView:containerView alertStyle:alertStyle];
    return alertVC;
}

- (void)showWithContainerView:(UIView *)containerView alertStyle:(UIAlertControllerStyle)alertStyle {
    self.alertStyle = alertStyle;
    
    UIView *contentView = [self createContentViewWithContainerView:containerView];
    [self.view addSubview:contentView];
    // 视图后置
    [self.view sendSubviewToBack:self.backgroundMaskView];
    // 视图前置
    [self.view bringSubviewToFront:contentView];
    
    self.contentView = contentView;
    
    [self showAlert];
}

#pragma mark - 创建contentView
- (UIView *)createContentViewWithContainerView:(UIView *)containerView {
    if (self.contentView) {
        return self.contentView;
    }
    UIView *contentView = [[UIView alloc] initWithFrame:containerView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    [contentView addSubview:containerView];
    
    // 底部安全高度
    if (isIPhoneX() && (self.alertStyle == UIAlertControllerStyleActionSheet)) {
        CGFloat bottomSafeHeight = 34.0;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height + bottomSafeHeight);
        
        UIView *bottomSafeView = [[UIView alloc] init];
        
        bottomSafeView.backgroundColor = [UIColor whiteColor];
        bottomSafeView.frame = CGRectMake(0, containerView.bounds.size.height, screenWidth, bottomSafeHeight);
        bottomSafeView.center = CGPointMake(contentView.center.x, bottomSafeView.center.y);
        [contentView addSubview:bottomSafeView];
    }
    
    return contentView;
}


#pragma mark - 展示和隐藏
// 展示
- (void)showAlert {
    
    if (self.alertStyle == UIAlertControllerStyleAlert) {
        // 初始布局
        self.contentView.center = self.view.center;
        // 动画
        [self showAnimationDialog];
    }
    
    if (self.alertStyle == UIAlertControllerStyleActionSheet) {
        // 初始布局
        CGFloat centerY = self.view.bounds.size.height - self.contentView.bounds.size.height * 0.5;
        self.contentView.center = CGPointMake(self.view.center.x, centerY);
        // 动画
        [self showAnimationActionSheet];
    }
  
}

// 隐藏
- (void)dismissAlert {
    if (self.alertStyle == UIAlertControllerStyleAlert) {
        [self dismissAnimationDialog];
    }
    if (self.alertStyle == UIAlertControllerStyleActionSheet) {
        [self dismissAnimationActionSheet];
    }
}

#pragma mark - 动画
// dialog展示动画
- (void)showAnimationDialog {
    __weak typeof(self) weakSelf = self;
    self.backgroundMaskView.alpha = 0;
    self.contentView.alpha = 0;
    self.contentView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0);
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backgroundMaskView.alpha = 1;
        weakSelf.contentView.alpha = 1;
        weakSelf.contentView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

// actionSheet展示动画
- (void)showAnimationActionSheet {
    __weak typeof(self) weakSelf = self;
    self.backgroundMaskView.alpha = 0;
    weakSelf.contentView.layer.transform = CATransform3DMakeTranslation(0, CGRectGetHeight(weakSelf.view.bounds) - CGRectGetMinY(weakSelf.contentView.frame), 0);
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backgroundMaskView.alpha = 1;
        weakSelf.contentView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
// dialog隐藏动画
- (void)dismissAnimationDialog {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backgroundMaskView.alpha = 0;
        weakSelf.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.contentView.alpha = 1;
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
    
}
// actionSheet隐藏动画
- (void)dismissAnimationActionSheet {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backgroundMaskView.alpha = 0;
        weakSelf.contentView.layer.transform = CATransform3DMakeTranslation(0, CGRectGetHeight(weakSelf.view.bounds) - CGRectGetMinY(weakSelf.contentView.frame), 0);
    } completion:^(BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma mark - modalPresentationStyle
// 自定义动画
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationCustom;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}




#pragma mark - 懒加载
- (UIControl *)backgroundMaskView {
    if (!_backgroundMaskView) {
        UIControl *backgroundMaskView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backgroundMaskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        [backgroundMaskView addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backgroundMaskView];
        _backgroundMaskView = backgroundMaskView;
    }
    return _backgroundMaskView;
}

- (void)dealloc {
    NSLog(@"dealloc = %@",self);
}

@end
