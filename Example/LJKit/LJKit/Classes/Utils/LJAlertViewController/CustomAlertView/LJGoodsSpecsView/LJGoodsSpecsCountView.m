//
//  LJGoodsSpecsCountView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsCountView.h"

@interface LJGoodsSpecsCountView ()
/// 左边的文本
@property (nonatomic, weak) UILabel *leftLabel;
/// 数量
@property (nonatomic, weak) UITextField *countTextField;
/// 增加
@property (nonatomic, weak) UIButton *addBtn;
/// 减少
@property (nonatomic, weak) UIButton *reduceBtn;
@end

@implementation LJGoodsSpecsCountView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewLayouts];
    }
    return self;
}

#pragma mark - 点击事件
- (void)clickAddBtn:(UIButton *)sender {
    int count = [self.countTextField.text intValue] + 1;
    if (count > self.maxCount) {
        return;
    }
    self.currentCount = count;
    self.countTextField.text = [NSString stringWithFormat:@"%d",count];
    if (self.countChangedHandle) {
        self.countChangedHandle(count);
    }
}

- (void)clickReduceBtn:(UIButton *)sender {
    int count = [self.countTextField.text intValue] - 1;
    if (count < self.minCount) {
        return;
    }
    self.currentCount = count;
    self.countTextField.text = [NSString stringWithFormat:@"%d",count];
    if (self.countChangedHandle) {
        self.countChangedHandle(count);
    }
}

#pragma mark - 重写set方法
- (void)setAllowInput:(BOOL)allowInput {
    _allowInput = allowInput;
    self.countTextField.userInteractionEnabled = allowInput;
}

- (void)setCurrentCount:(int)currentCount {
    _currentCount = currentCount;
    self.countTextField.text = [NSString stringWithFormat:@"%d",currentCount];
}

#pragma mark - 子控件布局
- (void)setupSubviewLayouts {
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-4);
        make.top.equalTo(self).offset(4);
        make.bottom.equalTo(self).offset(-4);
        make.width.mas_equalTo(40);
    }];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.addBtn);
        make.right.equalTo(self.addBtn.mas_left).offset(-4);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.addBtn);
        make.right.equalTo(self.countTextField.mas_left).offset(-4);
    }];
}

#pragma mark - 懒加载
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        label.text = @"数量";
        [self addSubview:label];
        _leftLabel = label;
    }
    return _leftLabel;
}

- (UITextField *)countTextField {
    if (!_countTextField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        textField.text = @"0";
        [self addSubview:textField];
        _countTextField = textField;
    }
    return _countTextField;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"+" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [btn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"-" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [btn addTarget:self action:@selector(clickReduceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _reduceBtn = btn;
    }
    return _reduceBtn;
}
@end
