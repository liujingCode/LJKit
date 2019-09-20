//
//  LJCrashAlertView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJCrashAlertView.h"
@interface LJCrashAlertView ()
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIButton *bottomButton;
@end


@implementation LJCrashAlertView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat bottomBtnHeight = 44.0;
        CGFloat textViewHeight = self.bounds.size.height - statusHeight - bottomBtnHeight;
        CGFloat width = self.bounds.size.width;
        
        self.textView.frame = CGRectMake(0, statusHeight, width, textViewHeight);
        self.bottomButton.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), width, bottomBtnHeight);
        
    }
    return self;
}

- (void)setCrashInfo:(NSString *)crashInfo {
    _crashInfo = crashInfo;
    self.textView.text = crashInfo;
}

- (void)showAlertView {
    if (self.contentView.hidden) {
        self.contentView.hidden = NO;
    }
}

- (void)clickActionBtn:(UIButton *)sender {
    NSInteger index = sender.tag - 1024;
    self.contentView.hidden = YES;
    if (self.actionCallback) {
        self.actionCallback(index);
    }
}


- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        textView.font = [UIFont systemFontOfSize:12.0];
        textView.editable = NO;
        [self addSubview:textView];
        _textView = textView;
    }
    return _textView;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"闪退处理" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor colorWithRed:199.0/255 green:237.0/255 blue:204.0/255 alpha:1.0];
        [self addSubview:btn];
        _bottomButton = btn;
    }
    return _bottomButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        
        UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.8, 210)];
        contenView.center = self.center;
        contenView.backgroundColor = [UIColor whiteColor];
        contenView.hidden = YES;
        
        [self addSubview:contenView];
        _contentView = contenView;
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"崩溃处理";
        titleLabel.frame = CGRectMake(0, 0, contenView.bounds.size.width, 30.0);
        titleLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [contenView addSubview:titleLabel];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = @"程序即将崩溃,咋办";
        messageLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), contenView.bounds.size.width, 20.0);
        messageLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:13.0];
        [contenView addSubview:messageLabel];
        
        
        
        UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 50, contenView.bounds.size.width, 160)];
        stackView.backgroundColor = [UIColor blackColor];
        // 默认横向排列
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.alignment = UIStackViewAlignmentFill;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.spacing = 1.0;
        [contenView addSubview:stackView];
        
        NSArray <NSString *> *titles = @[@"崩就崩呗",@"分享bug",@"继续正常操作",@"取消"];
        
        for (int i = 0; i < titles.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 1024 + i;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, 0, 40.0);
            btn.backgroundColor = [UIColor grayColor];
            [btn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [stackView addArrangedSubview:btn];
        }
        
        
        
        
    }
    return _contentView;
}
@end
