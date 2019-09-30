//
//  LJBoxTextFieldViewCell.m
//  LJKit_Example
//
//  Created by developer on 2019/9/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJBoxTextFieldViewCell.h"
@interface LJBoxTextFieldViewCell ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation LJBoxTextFieldViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.lj_borderColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.contentView.lj_borderWidth = 0.5;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"●";
        label.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:label];
        _label = label;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setShowPlaceholderImage:(BOOL)showPlaceholderImage {
    _showPlaceholderImage = showPlaceholderImage;
    self.label.hidden = showPlaceholderImage?NO:YES;
}
@end
