//
//  LJSandboxViewCell.m
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJSandboxViewCell.h"

@implementation LJSandboxViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.sizeLabel.frame = CGRectMake(self.contentView.frame.size.width - 80, 0, 80, self.contentView.frame.size.height);
    self.nameLabel.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 10 - 80, self.contentView.frame.size.height);
    
}

- (void)setModel:(LJSandboxModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:label];
        _sizeLabel = label;
    }
    return _sizeLabel;
}

@end
