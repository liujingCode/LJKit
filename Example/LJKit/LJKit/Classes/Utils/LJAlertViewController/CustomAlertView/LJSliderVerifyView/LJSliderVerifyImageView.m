//
//  LJSliderVerifyImageView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJSliderVerifyImageView.h"

@interface LJSliderVerifyImageView ()
/// 背景图
@property (nonatomic, weak) UIImageView *bgImageView;
/// 填充图
@property (nonatomic, weak) UIImageView *keyImageView;

@end
@implementation LJSliderVerifyImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bgImageView];
        [self keyImageView];
    }
    return self;
}

- (void)showVerifyFailure {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.keyImageView.frame = CGRectMake(- weakSelf.verifyPoint.x, weakSelf.keyImageView.frame.origin.y, weakSelf.keyImageView.frame.size.width, weakSelf.keyImageView.frame.size.height);
    }];
}
- (void)showVerifySuccess {
    
}



- (void)setCurrentValue:(CGFloat)currentValue {
    _currentValue = currentValue;
    self.keyImageView.frame = CGRectMake(- self.verifyPoint.x + currentValue, self.keyImageView.frame.origin.y, self.keyImageView.frame.size.width, self.keyImageView.frame.size.height);
}



- (void)setVerifyImage:(UIImage *)verifyImage {
    _verifyImage = verifyImage;
    self.bgImageView.image = verifyImage;
    self.keyImageView.image = verifyImage;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [maskPath appendPath:[UIBezierPath bezierPathWithCGPath:[self createDefaultPath].CGPath]];
    maskPath.usesEvenOddFillRule = YES;
    
    CAShapeLayer *backMaskLayer = [CAShapeLayer new];
    backMaskLayer.frame = self.bounds;
    backMaskLayer.path = maskPath.CGPath;
    backMaskLayer.fillRule = kCAFillRuleEvenOdd;
    
    CAShapeLayer *frontMaskLayer = [CAShapeLayer new];
    frontMaskLayer.frame = self.bounds;
    frontMaskLayer.path = [self createDefaultPath].CGPath;
    frontMaskLayer.fillRule = kCAFillRuleEvenOdd;
    
    self.bgImageView.layer.mask = backMaskLayer;
    self.keyImageView.layer.mask = frontMaskLayer;
    
}

- (void)setVerifyPoint:(CGPoint)verifyPoint {
    _verifyPoint = verifyPoint;
    self.keyImageView.frame = CGRectMake(- verifyPoint.x, self.keyImageView.frame.origin.y, self.keyImageView.frame.size.width, self.keyImageView.frame.size.height);
}

#pragma mark - path
- (UIBezierPath *)createDefaultPath {
    
//    CGFloat baseX = self getRandomNumber:0 to:<#(int)#>
    
    // 默认  size = 40; point = {0,0};
    
    CGFloat width = 40;
    CGFloat overlapLength = 8.f;
    CGFloat lineLength = (width - overlapLength * 2) * 0.5;
    CGFloat radius = 5.f;
    CGFloat startX = 0.f + self.verifyPoint.x;
    CGFloat startY = overlapLength + self.verifyPoint.y;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startX, startY)];
    [path addLineToPoint:CGPointMake(startX + lineLength, startY)];
    [self addArcPathWithPath:path andStartPoint:CGPointMake(startX + lineLength, startY) endPoint:CGPointMake(startX + overlapLength + lineLength, startY) radius:radius clockwise:YES moreThanHalf:YES];
    [path addLineToPoint:CGPointMake(startX + overlapLength + lineLength * 2, startY)];
    [path addLineToPoint:CGPointMake(startX + overlapLength + lineLength * 2, startY + lineLength)];
    [self addArcPathWithPath:path andStartPoint:CGPointMake(startX + overlapLength + lineLength * 2, startY + lineLength) endPoint:CGPointMake(startX + overlapLength + lineLength * 2, startY + overlapLength + lineLength) radius:radius clockwise:YES moreThanHalf:YES];
    [path addLineToPoint:CGPointMake(startX + overlapLength + lineLength * 2, startY + overlapLength + lineLength * 2)];
    [path addLineToPoint:CGPointMake(startX + overlapLength + lineLength, startY + overlapLength + lineLength * 2)];
    [self addArcPathWithPath:path andStartPoint:CGPointMake(startX + overlapLength + lineLength, startY + overlapLength + lineLength * 2) endPoint:CGPointMake(startX + lineLength, startY + overlapLength + lineLength * 2) radius:radius clockwise:NO moreThanHalf:YES];
    [path addLineToPoint:CGPointMake(startX, startY + overlapLength + lineLength * 2)];
    [path addLineToPoint:CGPointMake(startX, lineLength + overlapLength * 2)];
    [self addArcPathWithPath:path andStartPoint:CGPointMake(startX, startY + lineLength + overlapLength) endPoint:CGPointMake(startX, startY + lineLength) radius:radius clockwise:NO moreThanHalf:YES];
    [path closePath];
    return path;
}

- (void)addArcPathWithPath:(UIBezierPath *)path andStartPoint:(CGPoint)startP endPoint:(CGPoint)endP radius:(CGFloat)radius clockwise:(BOOL)clockwise moreThanHalf:(BOOL)moreThanHalf {
    CGPoint center = [self getCenterFromFirstPoint:startP secondPoint:endP radius:radius clockwise:clockwise moreThanhalf:moreThanHalf];
    CGFloat startA = [self getAngleFromFirstPoint:center secondP:startP];
    CGFloat endA = [self getAngleFromFirstPoint:center secondP:endP];
    [path addArcWithCenter:center radius:radius startAngle:startA endAngle:endA clockwise:clockwise];
}

// 根据两点、半径、顺逆时针获取圆心
- (CGPoint)getCenterFromFirstPoint:(CGPoint)firstP secondPoint:(CGPoint)secondP radius:(CGFloat)radius clockwise:(BOOL)clockwise moreThanhalf:(BOOL)moreThanHalf {
    CGFloat centerX = 0.5 * secondP.x - 0.5 * firstP.x;
    CGFloat centerY = 0.5 * firstP.y - 0.5 * secondP.y;
    centerX = round6f(centerX);
    centerY = round6f(centerY);
    radius = round6f(radius);
    // 获取相似三角形相似比例
    CGFloat scale = sqrt((pow(radius, 2) - (pow(centerX, 2) + pow(centerY, 2))) / (pow(centerX, 2) + pow(centerY, 2)));
    scale = round6f(scale);
    if (clockwise != moreThanHalf) {
        return CGPointMake(centerX + centerY * scale + firstP.x, - centerY + centerX * scale + firstP.y);
    } else {
        return CGPointMake(centerX - centerY * scale + firstP.x, - centerY - centerX * scale + firstP.y);
    }
}

// 获取第二点相对第一点的角度
- (CGFloat)getAngleFromFirstPoint:(CGPoint)firstP secondP:(CGPoint)secondP {
    CGFloat deltaX = secondP.x - firstP.x;
    CGFloat deltaY = secondP.y - firstP.y;
    deltaX = round6f(deltaX);
    deltaY = round6f(deltaY);
    if (deltaX > 0) {
        if (deltaY >= 0) return atanf(deltaY / deltaX);
        return M_PI * 2 + atanf(deltaY / deltaX);
    } else if (deltaX == 0) {
        if (deltaY >= 0) {
            return M_PI_2;
        } else {
            return M_PI_2 * 3;
        }
    }
    return atanf(deltaY / deltaX) + M_PI;
}

// 保留6位小数
CGFloat round6f(CGFloat x) {
    return roundf(x * 1000000) / 1000000.0;
}




#pragma mark - 懒加载UI
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (UIImageView *)keyImageView {
    if (!_keyImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        _keyImageView = imageView;
    }
    return _keyImageView;
}

@end
