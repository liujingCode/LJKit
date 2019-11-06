//
//  LJScanCapture.h
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LJScanCaptureResultHandle)(NSString *result);
@interface LJScanCapture : NSObject
/// 开启闪光灯
@property (nonatomic, assign) BOOL flashEnable;
/// 缩放
@property (nonatomic, assign) float focalScale;
/// 扫描结果的回调
@property (nonatomic, copy) LJScanCaptureResultHandle resultHandle;
+(instancetype)scanWithPreView:(UIView*)preView andObjectType:(NSArray*)objTypes andScanRect:(CGRect)scanRect;

/// 开始扫码
- (void)startScan;

/// 停止扫码
- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
