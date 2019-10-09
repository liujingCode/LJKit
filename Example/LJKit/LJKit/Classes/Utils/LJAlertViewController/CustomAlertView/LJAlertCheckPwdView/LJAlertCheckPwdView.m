//
//  LJAlertCheckPwdView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertCheckPwdView.h"
#import "LJBoxTextFieldView.h"
@interface LJAlertCheckPwdView()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *dismissBtn;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) LJBoxTextFieldView *pwdView;
@property (nonatomic, weak) UIButton *forgetPwdBtn;
@property (nonatomic, weak) UIButton *confirmBtn;
@end

@implementation LJAlertCheckPwdView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 2;
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViewLayouts];
        
        // 输入完成后的回调
        __weak typeof(self) weakSelf = self;
        self.pwdView.completeHandle = ^(NSString * _Nonnull password) {
            if (!weakSelf.actionHandle) {
                return ;
            }
            weakSelf.actionHandle(LJAlertCheckPwdViewActionComplete, password);
        };
    }
    return self;
}

#pragma mark - 设置子控件约束
- (void)setupSubViewLayouts {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(14);
        make.centerX.equalTo(self);
    }];
    
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(43);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(34);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(46);
    }];
    
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdView.mas_bottom).offset(8);
        make.right.equalTo(self.pwdView);
    }];
}

// 点击关闭
- (void)clickCloseBtn:(UIButton *)sender {
    if (self.actionHandle) {
         self.actionHandle(LJAlertCheckPwdViewActionCancel, nil);
     }
}
// 点击忘记密码
- (void)clickForgetPwdBtn:(UIButton *)sender {
    if (self.actionHandle) {
        self.actionHandle(LJAlertCheckPwdViewActionForgetPwd, nil);
    }
}


#pragma mark - 懒加载UI控件
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithWhite:0.28 alpha:1.0];
        label.font = [UIFont systemFontOfSize:18.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"请输入交易密码";
        [label sizeToFit];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self addSubview:btn];
        _dismissBtn = btn;
    }
    return _dismissBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

- (LJBoxTextFieldView *)pwdView {
    if (!_pwdView) {
        LJBoxTextFieldView *pwdView = [[LJBoxTextFieldView alloc] init];
        pwdView.boxCount = 6;
        [self addSubview:pwdView];
        _pwdView = pwdView;
    }
    return _pwdView;
}

- (UIButton *)forgetPwdBtn {
    if (!_forgetPwdBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(clickForgetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self addSubview:btn];
        _forgetPwdBtn = btn;
    }
    return _forgetPwdBtn;
}


@end
