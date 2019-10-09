//
//  LJSliderVerifySliderView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

static CGFloat leftMargin = 2.0;

#import "LJSliderVerifySliderView.h"
@interface LJSliderVerifySliderView ()
/// 标题
@property (nonatomic, weak) UILabel *titleLabel;
/// 指示器
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
/// 滑块
@property (nonatomic, weak) UIImageView *sliderIconView;
/// 滑块
@property (nonatomic, weak) UIView *sliderIconContentView;
@end

@implementation LJSliderVerifySliderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.lj_borderColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        self.lj_borderWidth = 0.5;
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];;
        [self setupSubViewLayouts];
    }
    return self;
}

- (void)panSliderIconView:(UIPanGestureRecognizer *)gesture {
    //视图前置操作
    [gesture.view.superview bringSubviewToFront:gesture.view];
    CGFloat centerX = gesture.view.center.x;
    CGPoint translation = [gesture translationInView:self.sliderIconContentView];
    CGFloat margin = 0.0;
    // width = 44 两边的间距为 2
    if (centerX <= (margin + gesture.view.frame.size.width * 0.5)) {
        centerX = margin + gesture.view.frame.size.width * 0.5;
    }
    if (centerX >= (self.frame.size.width - gesture.view.frame.size.width * 0.5 - margin)) {
        centerX = self.frame.size.width - gesture.view.frame.size.width * 0.5 - margin;
    }
    gesture.view.center = CGPointMake(centerX + translation.x, gesture.view.center.y);
    [gesture setTranslation:CGPointZero inView:self.sliderIconContentView];

    

    if ((gesture.state == UIGestureRecognizerStateEnded) || ( gesture.state == UIGestureRecognizerStateCancelled)) {
        if (self.touchMovedCallback) {
            self.touchMovedCallback(self.sliderIconContentView.frame.origin.x - leftMargin,YES);
        }
    } else {
        if (self.touchMovedCallback) {
            self.touchMovedCallback(self.sliderIconContentView.frame.origin.x - leftMargin,NO);
        }
    }
    
}

- (void)showVerifyFailure {
    CGFloat margin = 2.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.sliderIconContentView.frame = CGRectMake(margin, self.sliderIconContentView.frame.origin.y, self.sliderIconContentView.frame.size.width, self.sliderIconContentView.frame.size.height);
    }];
}
- (void)showVerifySuccess {
    self.sliderIconContentView.hidden = YES;
    [self.indicatorView startAnimating];
    self.titleLabel.hidden = YES;
    self.indicatorView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        self.titleLabel.hidden = NO;
        self.indicatorView.hidden = YES;
        self.titleLabel.text = @"验证通过";
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
        }];
    });
}


#pragma mark - 设置子控件约束
- (void)setupSubViewLayouts {
    [self.sliderIconContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftMargin);
        make.top.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-2);
        make.width.mas_equalTo(40);
//        make.top.left.bottom.equalTo(self);
    }];
    
    [self.sliderIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.sliderIconContentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(44);
        make.right.equalTo(self).offset(-10);
        make.top.bottom.equalTo(self);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
}


#pragma mark - 懒加载UI
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"向右滑块完成拼图";
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
        indicatorView.color = [UIColor colorWithWhite:0.3 alpha:1.0];;
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIImageView *)sliderIconView {
    if (!_sliderIconView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_slider_slider"]];
        imageView.center = self.sliderIconContentView.center;
        [self.sliderIconContentView addSubview:imageView];
        _sliderIconView = imageView;
    }
    return _sliderIconView;
}

- (UIView *)sliderIconContentView {
    if (!_sliderIconContentView) {
        UIView *view = [[UIView alloc] init];
        view.lj_shadowColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        view.lj_shadowOffset = CGSizeMake(1, 1);
        view.lj_shadowRadius = 1;
    
        view.backgroundColor = [UIColor whiteColor];
        UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panSliderIconView:)];
        [view addGestureRecognizer:pan];
        [self addSubview:view];
        _sliderIconContentView = view;
    }
    return _sliderIconContentView;
}
@end
