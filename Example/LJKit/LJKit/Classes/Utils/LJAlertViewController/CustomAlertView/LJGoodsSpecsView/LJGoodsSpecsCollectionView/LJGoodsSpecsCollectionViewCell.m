//
//  LJGoodsSpecsCollectionViewCell.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsCollectionViewCell.h"
@interface LJGoodsSpecsCollectionViewCell ()

@end

@implementation LJGoodsSpecsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"数量";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
