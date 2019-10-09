//
//  LJSliderVerifyView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJSliderVerifyView.h"
#import "LJSliderVerifyImageView.h"
#import "LJSliderVerifySliderView.h"

@interface LJSliderVerifyView ()
/// 图片视图
@property (nonatomic, weak) LJSliderVerifyImageView *imageView;
/// 滑块视图
@property (nonatomic, weak) LJSliderVerifySliderView *sliderView;
/// 验证值
@property (nonatomic, assign) float verifyValue;


@property (nonatomic, weak) UIView *topContentView;
/// 标题
@property (nonatomic, weak) UILabel *titleLabel;
/// 关闭按钮
@property (nonatomic, weak) UIButton *closeBtn;
/// 刷新按钮
@property (nonatomic, weak) UIButton *updateBtn;
@end

@implementation LJSliderVerifyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
            __weak typeof(self) weakSelf = self;
                
                self.sliderView.touchMovedCallback = ^(CGFloat sliderValue, BOOL isEnd) {
                    weakSelf.imageView.currentValue = sliderValue;
                    if (!isEnd) {
                        return ;
                    }
                    // 误差小于5  验证通过
                    if (fabs(sliderValue - weakSelf.imageView.verifyPoint.x) < 5.f) {
                        [weakSelf.sliderView showVerifySuccess];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if (weakSelf.resultHandle) {
                                weakSelf.resultHandle(YES);
                            }
                        });
                        
                    } else {
                        [weakSelf.imageView showVerifyFailure];
                        [weakSelf.sliderView showVerifyFailure];
                    }
                };
                
                [self titleLabel];
                [self closeBtn];
                [self updateBtn];
    }
    return self;
}

#pragma mark - 点击按钮
- (void)clickCloseBtn:(UIButton *)sender {
    if (self.closeHandle) {
        self.closeHandle();
    }
}

- (void)clickUpdateBtn:(UIButton *)sender {
    [self.imageView removeFromSuperview];
    [self imageView];
    
    if (self.updateHandle) {
        self.updateHandle();
    }
}

#pragma mark - set方法
- (void)setVerifyImage:(UIImage *)verifyImage {
    _verifyImage = verifyImage;
    CGFloat keyWidth = 40;
    CGFloat leftMargin = keyWidth + 10;
    CGFloat rightMargin = 10;
    CGFloat topMargin = 40;
    self.imageView.verifyPoint = CGPointMake([self getRandomNumber:leftMargin to:self.imageView.frame.size.width - keyWidth - rightMargin], [self getRandomNumber:topMargin to:self.imageView.frame.size.height - keyWidth - topMargin]);
    self.imageView.verifyImage = verifyImage;
    [self updateBtn];
}


// 随机数  包含from 和 to
- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}





#pragma mark - 懒加载
- (LJSliderVerifyImageView *)imageView {
    if (!_imageView) {
        LJSliderVerifyImageView *imageView = [[LJSliderVerifyImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topContentView.frame) + 30, self.frame.size.width - 56, 170)];
        imageView.center = CGPointMake(self.frame.size.width / 2, imageView.center.y);
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (LJSliderVerifySliderView *)sliderView {
    if (!_sliderView) {
        CGFloat height = 40;
        LJSliderVerifySliderView  *sliderView = [[LJSliderVerifySliderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 30, self.imageView.frame.size.width, height)];
        sliderView.center = CGPointMake(self.imageView.center.x, sliderView.center.y);
        [self addSubview:sliderView];
        _sliderView = sliderView;
    }
    return _sliderView;
}

- (UIView *)topContentView {
    if (!_topContentView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:view];
        _topContentView = view;
    }
    return _topContentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"安全验证";
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.center = self.topContentView.center;
        [self.topContentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.center = CGPointMake(btn.center.x, self.topContentView.center.y);
        btn.frame = CGRectMake(self.topContentView.frame.size.width - btn.frame.size.width - 10.f, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        [self.topContentView addSubview:btn];
        _closeBtn = btn;
    }
    return _closeBtn;
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"刷新" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickUpdateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.frame = CGRectMake(self.imageView.frame.size.width - btn.frame.size.width - 10, 10, btn.frame.size.width, btn.frame.size.height);
        [self.imageView addSubview:btn];
        _updateBtn = btn;
    }
    return _updateBtn;
}

@end
