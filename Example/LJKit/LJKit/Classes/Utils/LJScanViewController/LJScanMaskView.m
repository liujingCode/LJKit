//
//  LJScanMaskView.m
//  LJKit_Example
//
//  Created by developer on 2019/11/5.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJScanMaskView.h"
#import "LJScanAnimationView.h"
@interface LJScanMaskView ()
/// 扫描范围
@property (nonatomic, assign) CGRect scanRect;
/// 扫描动画
@property (nonatomic, weak) LJScanAnimationView *animationView;
@end

@implementation LJScanMaskView

+ (instancetype)maskViewWithFrame:(CGRect)frame andScanRect:(CGRect)scanRect {
    LJScanMaskView *maskView = [[LJScanMaskView alloc] initWithFrame:frame andScanRect:scanRect];
    return maskView;
}

- (instancetype)initWithFrame:(CGRect)frame andScanRect:(CGRect)scanRect{
    if (self = [super initWithFrame:frame]) {
        self.scanRect = scanRect;
        [self bgPath];
        [self bezierPath];
        
        [self animationView];
        [self startScanAnimation];
        
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)bgPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:self.scanRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4].CGColor;
//    fillLayer.fillColor = [UIColor clearColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.layer addSublayer:fillLayer];
}

- (void )bezierPath {
    CGFloat x = self.scanRect.origin.x;
    CGFloat y = self.scanRect.origin.y;
    CGFloat width = self.scanRect.size.width;
    CGFloat height = self.scanRect.size.height;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bgRect];
    
    //绿色四个角落
    UIBezierPath *cornerBezierPath = [UIBezierPath bezierPath];

    [cornerBezierPath moveToPoint:CGPointMake(x, y+30)];//左上角
    [cornerBezierPath addLineToPoint:CGPointMake(x, y)];
    [cornerBezierPath addLineToPoint:CGPointMake(x+30, y)];

    [cornerBezierPath moveToPoint:CGPointMake(x+height-30, y)];//右上角
    [cornerBezierPath addLineToPoint:CGPointMake(x+height, y)];
    [cornerBezierPath addLineToPoint:CGPointMake(x+height, y+30)];

    [cornerBezierPath moveToPoint:CGPointMake(x+height, y+height-30)];//左上角
    [cornerBezierPath addLineToPoint:CGPointMake(x+height, y+height)];
    [cornerBezierPath addLineToPoint:CGPointMake(x+height-30, y+height)];

    [cornerBezierPath moveToPoint:CGPointMake(x+30, y+height)];//左上角
    [cornerBezierPath addLineToPoint:CGPointMake(x, y+height)];
    [cornerBezierPath addLineToPoint:CGPointMake(x, y+height-30)];

    CAShapeLayer *cornerShapLayer = [CAShapeLayer layer];
    cornerShapLayer.backgroundColor = UIColor.clearColor.CGColor;
    cornerShapLayer.path = cornerBezierPath.CGPath;
    cornerShapLayer.lineWidth = 3.0;
    cornerShapLayer.strokeColor = [UIColor orangeColor].CGColor;
    cornerShapLayer.fillColor = UIColor.clearColor.CGColor;
    [self.layer addSublayer:cornerShapLayer];
    
//    return path;
}


/// 开始扫描动画
- (void)startScanAnimation {
    [self.animationView startScanAnimation];
}

/// 停止扫描动画
- (void)stopScanAnimation {
    [self.animationView stopScanAnimation];
}


- (LJScanAnimationView *)animationView {
    if (!_animationView) {
        LJScanAnimationView *animationView = [[LJScanAnimationView alloc] initWithFrame:self.scanRect];
        [self addSubview:animationView];
        _animationView = animationView;
    }
    return _animationView;
}

@end
