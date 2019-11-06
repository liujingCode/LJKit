//
//  LJScanViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJScanCapture.h"

NS_ASSUME_NONNULL_BEGIN

/// 二维码扫描
@interface LJScanViewController : UIViewController
/// 动画区域,默认为扫描区域
@property (nonatomic,assign) CGRect animationRect;
/// 扫描区域,默认为:center.x,center.y,width * 70,width * 70
@property (nonatomic,assign) CGRect scanReact;
/// 是否支持手势缩放,默认NO
@property (nonatomic,assign) BOOL gestureScaleEnable;
/// 提示打开闪光灯的阈值,有默认值
@property (nonatomic,assign) CGFloat flashOnBrightnessThreshold;
/// 提示关闭闪光灯的阈值,有默认值
@property (nonatomic,assign) CGFloat flashOffBrightnessThreshold;
/// 扫描结果的回调
@property (nonatomic, copy) LJScanCaptureResultHandle resultHandle;
@end

NS_ASSUME_NONNULL_END
