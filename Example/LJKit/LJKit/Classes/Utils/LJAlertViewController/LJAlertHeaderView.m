//
//  LJAlertHeaderView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertHeaderView.h"

@implementation LJAlertHeaderView
@synthesize titleLabel = _titleLabel;
@synthesize messageLabel = _messageLabel;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.top.equalTo(self);
//        }];
//        
//        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.titleLabel);
//            make.top.equalTo(self.titleLabel.mas_bottom);
//            make.bottom.equalTo(self);
//        }];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    self.titleLabel.text = self.title;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.titleLabel.frame.size.height);

    self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, 0);
    self.messageLabel.text = self.message;
    [self.messageLabel sizeToFit];
    self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, self.messageLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.messageLabel.frame));
}

#pragma mark - 监听set方法
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self layoutSubviews];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
    [self layoutSubviews];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel sizeToFit];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        titleLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        UILabel *messageLabel = [[UILabel alloc] init];
        [messageLabel sizeToFit];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:13.0];
        messageLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        [self addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}
@end
