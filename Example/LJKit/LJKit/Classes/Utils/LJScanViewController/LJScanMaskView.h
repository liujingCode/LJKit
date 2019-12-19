//
//  LJScanMaskView.h
//  LJKit_Example
//
//  Created by developer on 2019/11/5.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJScanMaskView : UIView
/// 蒙版颜色
@property (nonatomic, copy) UIColor *maskColor;
+ (instancetype)maskViewWithFrame:(CGRect)frame andScanRect:(CGRect)scanRect;

/// 开始扫描动画
- (void)startScanAnimation;

/// 停止扫描动画
- (void)stopScanAnimation;
@end

NS_ASSUME_NONNULL_END
