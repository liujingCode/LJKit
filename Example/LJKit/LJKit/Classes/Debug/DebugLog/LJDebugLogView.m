//
//  LJDebugLogView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDebugLogView.h"

@interface LJDebugLogView ()
@property (nonatomic, weak) UITextView *textView;
@end

@implementation LJDebugLogView
- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat height = [UIScreen mainScreen].bounds.size.height * 0.4;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - height;
    frame = CGRectMake(0, y, width, height);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        self.textView.frame = self.bounds;
        self.textView.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

- (void)setLogStr:(NSString *)logStr {
    _logStr = logStr;
    if (!logStr) {
        return;
    }
    self.textView.text = logStr;
//    self.textView.layoutManager.allowsNonContiguousLayout = NO;
//    [self.textView scrollRangeToVisible:NSMakeRange(logStr.length - 1, 1)];
    
    
//    CGRect scrollFrame = CGRectMake(0, self.textView.contentSize.height - 44, self.textView.bounds.size.width, 44.0);
//
//    [self.textView scrollRectToVisible:scrollFrame animated:YES];
}

- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:11.0];
        textView.textColor = [UIColor whiteColor];
        [self addSubview:textView];
        _textView = textView;
    }
    return _textView;
}
@end
