//
//  LJScanView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJScanView.h"
@interface LJScanView ()

/// 扫描线
@property (nonatomic, weak) UIImageView *scanLineView;

@end

@implementation LJScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scanLineView.image = [UIImage imageNamed:@"qrcode_scan_line"];
        [self.scanLineView sizeToFit];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.scanLineView.center = CGPointMake(self.bounds.size.width / 2, self.scanLineView.center.y);
}


/// 开始扫描动画
- (void)startScanAnimation {
    CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    lineAnimation.fromValue = @(0);
    lineAnimation.toValue = @(self.frame.size.height);
    lineAnimation.duration = 1.5;
    lineAnimation.repeatCount = NSIntegerMax;
    [self.scanLineView.layer addAnimation:lineAnimation forKey:@"scanLineAnimation"];
}

/// 停止扫描动画
- (void)stopScanAnimation {
    [self.scanLineView.layer removeAnimationForKey:@"scanLineAnimation"];
}

- (UIImageView *)scanLineView {
    if (!_scanLineView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        _scanLineView = imageView;
    }
    return _scanLineView;
}
@end
