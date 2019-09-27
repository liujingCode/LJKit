//
//  LJAlertFooterView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAlertFooterView.h"

@implementation LJAlertFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 44.0;
    CGFloat width = self.frame.size.width;
    
    // 垂直布局
    BOOL verticalLayout = YES;
    NSArray *subviews = self.subviews;
    for (int i = 0; i < subviews.count; i ++) {
        UIView *subView = subviews[i];
        if (![subView isKindOfClass:[LJAlertActionButton class]]) {
            break;
        }
        // y坐标
        y = height * i;
        
        LJAlertActionButton *button = (LJAlertActionButton *)subView;
        button.frame = CGRectMake(x, y, width, height);
    }
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.subviews.lastObject.frame));
//    if (self.layoutCompleteHandle) {
//        self.layoutCompleteHandle();
//    }
}

- (void)setActions:(NSMutableArray<LJAlertAction *> *)actions {
    _actions = actions;

    
    for (int i = 0; i < actions.count; i ++) {
//        LJAlertAction *currentAction = actions[i];
        LJAlertActionButton *button = [LJAlertActionButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor colorWithWhite:0.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [button setTitle:@"测试" forState:UIControlStateNormal];
        
        [self addSubview:button];
    }
    [self layoutSubviews];
}
@end



#pragma mark - LJAlertActionButton
@implementation LJAlertActionButton

@end
