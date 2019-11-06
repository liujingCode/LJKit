//
//  LJScanViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJScanViewController.h"
#import "LJScanView.h"
#import "LJScanMaskView.h"


@interface LJScanViewController ()
/// 扫描框
@property (nonatomic, weak) LJScanView *scanView;
/// 扫描捕获
@property (nonatomic, strong) LJScanCapture *scanCapture;
/// 蒙版
@property (nonatomic, weak) LJScanMaskView *scanMaskView;

/// 打开闪光灯
@property (nonatomic, weak) UIButton *openBtn;
/// 缩放
@property (nonatomic, weak) UISlider *scaleSlider;
@end

@implementation LJScanViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - 默认配置
- (void)setupDefaultConfig {
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.7;
    CGFloat x = (self.view.frame.size.width - width) * 0.5;
    CGFloat y = (self.view.frame.size.height - width) * 0.5;
    self.scanReact = CGRectMake(x, y, width, width);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self scanMaskView];
     [self setupDefaultConfig];
    self.view.backgroundColor = [UIColor blackColor];

//    [self.scanView startScanAnimation];
    self.scanView.frame = constructScanAnimationRect();
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scanView);
        make.top.equalTo(self.scanView.mas_bottom).offset(10);
    }];

    [self.scaleSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scanView);
        make.top.equalTo(self.openBtn.mas_bottom).offset(10);
    }];

    
    self.scanCapture.resultHandle = self.resultHandle;
    [self.scanCapture startScan];
    [self.scanView startScanAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.scanCapture startScan];
}

#pragma mark - 闪光灯
- (void)clickOpenBtn:(UIButton *)sender {
    self.scanCapture.flashEnable = !self.scanCapture.flashEnable;
}
#pragma mark - 焦距缩放
- (void)dragScaleSlider:(UISlider *)sender {
    self.scanCapture.focalScale = sender.value;
}

- (LJScanView *)scanView {
    if (!_scanView) {
        LJScanView *scanView = [[LJScanView alloc] initWithFrame:self.scanReact];
        [self.view addSubview:scanView];
        _scanView = scanView;
    }
    return _scanView;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"闪光灯" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickOpenBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _openBtn = btn;
    }
    return _openBtn;
}

- (UISlider *)scaleSlider {
    if (!_scaleSlider) {
        UISlider *slider = [[UISlider alloc] init];
        slider.minimumValue = 1.0;
        slider.maximumValue = 2.0;
        [slider addTarget:self action:@selector(dragScaleSlider:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        _scaleSlider = slider;
    }
    return _scaleSlider;
}

- (LJScanCapture *)scanCapture {
    if (!_scanCapture) {
        
        LJScanCapture *scanCapture = [LJScanCapture scanWithPreView:self.view andObjectType:@[] andScanRect:constructScanAnimationRect()];
        _scanCapture = scanCapture;
    }
    return _scanCapture;
}

- (LJScanMaskView *)scanMaskView {
    if (!_scanMaskView) {
        LJScanMaskView *maskView = [LJScanMaskView maskViewWithFrame:self.view.bounds andScanRect:constructScanAnimationRect()];
        [self.view addSubview:maskView];
        _scanMaskView = maskView;
        [self.view sendSubviewToBack:maskView];
    }
    return _scanMaskView;
}

CGRect constructScanAnimationRect() {
    CGSize screenXY = [UIScreen mainScreen].bounds.size;
    NSInteger focusFrameWH = screenXY.width / 320 * 220;//as wx
    int offet = 10;
    if (screenXY.height == 568)
        offet = 19;
    
    return CGRectMake((screenXY.width - focusFrameWH) / 2,
                      (screenXY.height - 64 - focusFrameWH - 83 - 50 - offet) / 2 + 64,
                      focusFrameWH,
                      focusFrameWH);
}
@end
