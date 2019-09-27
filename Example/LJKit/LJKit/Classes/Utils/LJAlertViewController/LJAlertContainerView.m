//
//  LJAlertContainerView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertContainerView.h"
@interface LJAlertContainerView ()
@property (nonatomic, weak) LJAlertHeaderView *headerScrollView;
@property (nonatomic, weak) LJAlertFooterView *footerScrollView;
@end
@implementation LJAlertContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self.headerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(self);
//        }];
//        
//        [self.footerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.headerScrollView);
//            make.top.equalTo(self.headerScrollView.mas_bottom);
//            make.bottom.equalTo(self);
//        }];
    }
    return self;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.headerScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerScrollView.frame.size.height);
    self.footerScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.headerScrollView.frame), self.frame.size.width, self.footerScrollView.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.footerScrollView.frame));
    NSLog(@"%s",__FUNCTION__);
    if (self.layoutCompleteHandle) {
        self.layoutCompleteHandle();
    }
}

#pragma mark - 监听set方法
- (void)setTitle:(NSString *)title {
    _title = title;
    self.headerScrollView.title = title;
}
- (void)setMessage:(NSString *)message {
    _message = message;
    self.headerScrollView.message = message;
}

- (void)setActions:(NSMutableArray<LJAlertAction *> *)actions {
    _actions = actions;
    self.footerScrollView.actions = actions;
}

- (void)setLayoutCompleteHandle:(LJAlertFooterViewLayoutCompleteHandle)layoutCompleteHandle {
    _layoutCompleteHandle = layoutCompleteHandle;
//    self.footerScrollView.layoutCompleteHandle = layoutCompleteHandle;
}


#pragma mark - 懒加载
- (LJAlertHeaderView *)headerScrollView {
    if (!_headerScrollView) {
        LJAlertHeaderView *headerScrollView = [[LJAlertHeaderView alloc] init];
        [self addSubview:headerScrollView];
        _headerScrollView = headerScrollView;
    }
    return _headerScrollView;
}

- (LJAlertFooterView *)footerScrollView {
    if (!_footerScrollView) {
        LJAlertFooterView *footerScrollView = [[LJAlertFooterView alloc] init];
        [self addSubview:footerScrollView];
        _footerScrollView = footerScrollView;
    }
    return _footerScrollView;
}
@end
