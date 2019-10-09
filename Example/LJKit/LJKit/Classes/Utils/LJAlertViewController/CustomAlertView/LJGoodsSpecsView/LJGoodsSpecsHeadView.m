//
//  LJGoodsSpecsHeadView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsHeadView.h"

@interface LJGoodsSpecsHeadView ()
/// 商品图片
@property (nonatomic, weak) UIImageView *goodsImageView;
/// 价格
@property (nonatomic, weak) UILabel *priceLabel;
/// 库存
@property (nonatomic, weak) UILabel *stockLabel;
/// 格式化的描述信息
@property (nonatomic, weak) UILabel *formatInfoLabel;
/// 关闭按钮
@property (nonatomic, weak) UIButton *closeBtn;
@end

@implementation LJGoodsSpecsHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewLayouts];
    }
    return self;
}

#pragma mark - 重写set方法
- (void)setGoodsImageAddress:(NSString *)goodsImageAddress {
    _goodsImageAddress = goodsImageAddress;
}
- (void)setPrice:(float)price {
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",price];
}

- (void)setStock:(int)stock {
    _stock = stock;
    self.stockLabel.text = [NSString stringWithFormat:@"库存:%d",stock];
}

- (void)setFormatInfoStr:(NSString *)formatInfoStr {
    _formatInfoStr = formatInfoStr;
    self.formatInfoLabel.text = formatInfoStr;
}
#pragma mark - 点击事件
- (void)clickCloseBtn:(UIButton *)sender {
    
}

#pragma mark - 子控件布局
- (void)setupSubviewLayouts {
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(8);
        make.bottom.equalTo(self).offset(-8);
        make.width.mas_equalTo(self.goodsImageView.mas_height).multipliedBy(1);
    }];
    
    [self.formatInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(10);
        make.bottom.equalTo(self.goodsImageView).offset(-4);
    }];
    
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formatInfoLabel);
        make.bottom.equalTo(self.formatInfoLabel.mas_top).offset(-4);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formatInfoLabel);
        make.bottom.equalTo(self.stockLabel.mas_top).offset(-4);
    }];
}


#pragma mark - 懒加载
- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        _goodsImageView = imageView;
    }
    return _goodsImageView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor redColor];
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)stockLabel {
    if (!_stockLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:label];
        _stockLabel = label;
    }
    return _stockLabel;
}

- (UILabel *)formatInfoLabel {
    if (!_formatInfoLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        [self addSubview:label];
        _formatInfoLabel = label;
    }
    return _formatInfoLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [btn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _closeBtn = btn;
    }
    return _closeBtn;
}

@end
