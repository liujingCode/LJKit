//
//  LJAlertViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertViewController.h"
#import "LJAlertContainerView.h"

#pragma mark - frame操作相关
CGFloat ljAlert_screen_width () {
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat ljAlert_screen_height () {
    return [UIScreen mainScreen].bounds.size.height;
}




@interface LJAlertViewController ()
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *alertMessage;
@property (nonatomic, strong) NSMutableArray <LJAlertAction *> *actions;
@property (nonatomic, strong) NSMutableArray <UITextField *> *textFields;

@property (nonatomic, weak) UIControl *backgroundMaskView;
@property (nonatomic, weak) LJAlertContainerView *containerView;


@end

@implementation LJAlertViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(LJAlertViewControllerStyle)alertStyle {
    return [[self alloc] initWith_alert_Title:title message:message preferredStyle:alertStyle];
}

- (instancetype)initWith_alert_Title:(NSString *)title message:(NSString *)message preferredStyle:(LJAlertViewControllerStyle)alertStyle {
    if (self = [super init]) {
        self.alertTitle = title;
        self.alertMessage = message;
        self.alertStyle = alertStyle;
    }
    return self;
}


- (void)addAction:(LJAlertAction *)action {
    if (!action) {
        return;
    }
    [self.actions addObject:action];
}

- (void)addTextField:(UITextField *)textField {
    if (!textField) {
        return;
    }
    [self.textFields addObject:textField];
}

#pragma mark - dismissAlertView
- (void)dismissAlertView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 重写父类方法
// 自定义动画
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationCustom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // 设置数据
    [self setupData];
    
    // 设置默认UI
    [self setupDefaultConfig];
}


#pragma mark - 设置数据
- (void)setupData {
    self.containerView.title = self.alertTitle;
    self.containerView.message = self.alertMessage;
    self.containerView.actions = self.actions;
    self.containerView.textFields = self.textFields;
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//
//}

#pragma mark - 设置默认UI
- (void)setupDefaultConfig {
    self.backgroundMaskView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
//    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.mas_equalTo(300);
//    }];
    
    self.containerView.backgroundColor = [UIColor orangeColor];
    
    
//    __weak typeof(self) weakSelf = self;
//    CGFloat centerX = [UIScreen mainScreen].bounds.size.width / 2;
//    CGFloat centerY = [UIScreen mainScreen].bounds.size.height / 2;
//    self.containerView.layoutCompleteHandle = ^{
//        NSLog(@"布局完成");
//        if (self.alertStyle == LJAlertViewControllerStyleDialog) {
//            self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.8, 0);
//            self.containerView.center = CGPointMake(centerX, centerY);
//        } else if (self.alertStyle == LJAlertViewControllerStyleActionSheet) {
////            CGFloat containerHeight = self.containerView.frame.size.height;
////            self.containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - containerHeight, [UIScreen mainScreen].bounds.size.width, containerHeight);
//        }
//    };
    if (self.alertStyle == LJAlertViewControllerStyleDialog) {
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.center.equalTo(self.view);
        }];
    } else if (self.alertStyle == LJAlertViewControllerStyleActionSheet) {

    }
    
    
    
    
}



#pragma mark - 懒加载
- (NSMutableArray<LJAlertAction *> *)actions {
    if (!_actions) {
        _actions = [NSMutableArray new];
    }
    return _actions;
}

- (NSMutableArray<UITextField *> *)textFields {
    if (!_textFields) {
        _textFields = [NSMutableArray new];
    }
    return _textFields;
}

- (UIControl *)backgroundMaskView {
    if (!_backgroundMaskView) {
        UIControl *backgroundMaskView = [[UIControl alloc] init];
        backgroundMaskView.frame = CGRectMake(0, 0, ljAlert_screen_width(), ljAlert_screen_height());
        [backgroundMaskView addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backgroundMaskView];
        [self.view sendSubviewToBack:backgroundMaskView];
        _backgroundMaskView = backgroundMaskView;
    }
    return _backgroundMaskView;
}

- (LJAlertContainerView *)containerView {
    if (!_containerView) {
        LJAlertContainerView *containerView = [[LJAlertContainerView alloc] init];
        [self.view addSubview:containerView];
        [self.view bringSubviewToFront:containerView];
        _containerView = containerView;
    }
    return _containerView;
}
@end
