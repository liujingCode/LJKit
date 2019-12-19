//
//  LJScanViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJScanViewController.h"
#import "LJScanMaskView.h"
#import <ZXingObjC/ZXingObjC.h>


@interface LJScanViewController ()<ZXCaptureDelegate>
/// 蒙版(动画)视图
@property (nonatomic, weak) LJScanMaskView *maskView;
/// 预览视图
@property (nonatomic, weak) UIView *previewView;
/// 二维码/条码捕获器
@property (nonatomic, strong) ZXCapture *capture;
/// 第一次配置屏幕横竖屏
@property (nonatomic, assign) BOOL isFirstApplyOrientation;
/// 是否正在扫描
@property (nonatomic, assign,readwrite) BOOL scanning;
@end

@implementation LJScanViewController


#pragma mark - 监听set方法
- (void)setTorch:(BOOL)torch {
    _torch = torch;
    self.capture.torch = torch;
}

#pragma mark - 扫描范围
- (CGRect)scanRect {
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.8;
    CGFloat height = width;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) * 0.5;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
    return CGRectMake(x, y, width, height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self maskView];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startScan];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopScan];
}



#pragma mark - 开始和停止扫描

/// 开始扫描
- (void)startScan {
    if (self.scanning) { // 正在扫描
        return;
    }
    [self.maskView startScanAnimation];
    [self.capture start];
}

/// 停止扫描
- (void)stopScan {
    if (!self.scanning) { // 停止扫描
        return;
    }
    [self.maskView stopScanAnimation];
    [self.capture stop];
}


#pragma mark - ZXCaptureDelegate
/// 扫描结果的回调
/// @param capture 扫描器
/// @param result 扫描结果
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    NSLog(@"扫描结果 = %@",result.text);
}


/// 扫描器开始扫描
/// @param capture 扫描器
- (void)captureCameraIsReady:(ZXCapture *)capture {
    self.scanning = YES;
}


#pragma mark - 懒加载
/// 蒙版动画视图
- (LJScanMaskView *)maskView {
    if (!_maskView) {
        LJScanMaskView *maskView = [LJScanMaskView maskViewWithFrame:self.view.bounds andScanRect:self.scanRect];
        [self.view addSubview:maskView];
        [self.view bringSubviewToFront:maskView];
        _maskView = maskView;
    }
    return _maskView;
}

- (UIView *)previewView {
    if (!_previewView) {
        UIView *previewView = [[UIView alloc] initWithFrame:self.view.bounds];
        previewView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:previewView];
        [self.view sendSubviewToBack:previewView];
        _previewView = previewView;
    }
    return _previewView;
}

/// 捕获器
- (ZXCapture *)capture {
    if (!_capture) {
        ZXCapture *capture = [[ZXCapture alloc] init];
        capture.sessionPreset = AVCaptureSessionPreset1920x1080;
        capture.camera = capture.back;
        capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        capture.delegate = self;
        [self.previewView.layer addSublayer:capture.layer];
        _capture = capture;
    }
    return _capture;
}

#pragma mark - viewDidLayoutSubviews
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  if (_isFirstApplyOrientation) return;
  _isFirstApplyOrientation = TRUE;
  [self applyOrientation];
}

#pragma mark - viewWillTransitionToSize
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
   {
     [self applyOrientation];
   }];
}


#pragma mark - 横竖屏适配
- (void)applyOrientation {
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  float scanRectRotation;
  float captureRotation;
  
  switch (orientation) {
    case UIInterfaceOrientationPortrait:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      captureRotation = 90;
      scanRectRotation = 180;
      break;
    case UIInterfaceOrientationLandscapeRight:
      captureRotation = 270;
      scanRectRotation = 0;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      captureRotation = 180;
      scanRectRotation = 270;
      break;
    default:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
  }
  self.capture.layer.frame = self.previewView.frame;
  CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) (captureRotation / 180 * M_PI));
  [self.capture setTransform:transform];
  [self.capture setRotation:scanRectRotation];
  
  [self applyRectOfInterest:orientation];
}

#pragma mark - 设置扫描范围
- (void)applyRectOfInterest:(UIInterfaceOrientation)orientation {
  CGFloat scaleVideoX, scaleVideoY;
  CGFloat videoSizeX, videoSizeY;
  CGRect transformedVideoRect = self.scanRect;
  if([self.capture.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]) {
    videoSizeX = 1080;
    videoSizeY = 1920;
  } else {
    videoSizeX = 720;
    videoSizeY = 1280;
  }
  if(UIInterfaceOrientationIsPortrait(orientation)) {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeX;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeY;
    
    // Convert CGPoint under portrait mode to map with orientation of image
    // because the image will be cropped before rotate
    // reference: https://github.com/TheLevelUp/ZXingObjC/issues/222
    CGFloat realX = transformedVideoRect.origin.y;
    CGFloat realY = self.capture.layer.frame.size.width - transformedVideoRect.size.width - transformedVideoRect.origin.x;
    CGFloat realWidth = transformedVideoRect.size.height;
    CGFloat realHeight = transformedVideoRect.size.width;
    transformedVideoRect = CGRectMake(realX, realY, realWidth, realHeight);
    
  } else {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeY;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeX;
  }
  
  CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(1.0/scaleVideoX, 1.0/scaleVideoY);
  self.capture.scanRect = CGRectApplyAffineTransform(transformedVideoRect, captureSizeTransform);
}


#pragma mark - dealloc
- (void)dealloc {
  [self.capture.layer removeFromSuperlayer];
}

@end




/**
 1.前置和后置摄像头
 typedef NS_ENUM(NSInteger, AVCaptureDevicePosition) {
 AVCaptureDevicePositionUnspecified = 0,
 AVCaptureDevicePositionBack = 1,
 AVCaptureDevicePositionFront = 2
 } NS_AVAILABLE(10_7, 4_0);

 2.闪光灯开关
 typedef NS_ENUM(NSInteger, AVCaptureFlashMode) {
 AVCaptureFlashModeOff = 0,
 AVCaptureFlashModeOn = 1,
 AVCaptureFlashModeAuto = 2

 } NS_AVAILABLE(10_7, 4_0);

 3.手电筒开关--其实就是相机的闪光灯
 typedef NS_ENUM(NSInteger, AVCaptureTorchMode) {
 AVCaptureTorchModeOff = 0,
 AVCaptureTorchModeOn = 1,
 AVCaptureTorchModeAuto = 2,

 } NS_AVAILABLE(10_7, 4_0);

 4.焦距模式调整
 typedef NS_ENUM(NSInteger, AVCaptureFocusMode) {
 AVCaptureFocusModeLocked = 0,
 AVCaptureFocusModeAutoFocus = 1,
 AVCaptureFocusModeContinuousAutoFocus = 2,

 } NS_AVAILABLE(10_7, 4_0);

 5.曝光量调节
 typedef NS_ENUM(NSInteger, AVCaptureExposureMode) {
 AVCaptureExposureModeLocked = 0,
 AVCaptureExposureModeAutoExpose = 1,
 AVCaptureExposureModeContinuousAutoExposure = 2,
 AVCaptureExposureModeCustom NS_ENUM_AVAILABLE_IOS(8_0) = 3,

 } NS_AVAILABLE(10_7, 4_0);

 6.白平衡
 typedef NS_ENUM(NSInteger, AVCaptureWhiteBalanceMode) {
 AVCaptureWhiteBalanceModeLocked = 0,
 AVCaptureWhiteBalanceModeAutoWhiteBalance = 1,
 AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance = 2,

 } NS_AVAILABLE(10_7, 4_0);

 7.距离调整
 typedef NS_ENUM(NSInteger, AVCaptureAutoFocusRangeRestriction) {
 AVCaptureAutoFocusRangeRestrictionNone = 0,
 AVCaptureAutoFocusRangeRestrictionNear = 1,
 AVCaptureAutoFocusRangeRestrictionFar = 2,

 } NS_AVAILABLE_IOS(7_0);

 作者：Smallwolf_JS
 链接：https://www.jianshu.com/p/10902fb27638
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */
