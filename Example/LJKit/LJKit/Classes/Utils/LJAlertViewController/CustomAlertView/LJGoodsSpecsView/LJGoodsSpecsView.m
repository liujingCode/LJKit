//
//  LJGoodsSpecsView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsView.h"
#import "LJGoodsSpecsHeadView.h"
#import "LJGoodsSpecsCountView.h"
#import "LJGoodsSpecsCollectionView.h"


/// 屏幕宽度
CGFloat screenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

/// 屏幕高度
CGFloat screenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

@interface LJGoodsSpecsView ()
/// 头部视图
@property (nonatomic, weak) LJGoodsSpecsHeadView *headView;
/// 数量视图
@property (nonatomic, weak) LJGoodsSpecsCountView *countView;
/// 选项视图
@property (nonatomic, weak) LJGoodsSpecsCollectionView *collectionView;
/// 确认
@property (nonatomic, weak) UIButton *confirmBtn;
@end

@implementation LJGoodsSpecsView
+ (instancetype)defaultView {
    LJGoodsSpecsView *goodsSpecsView = [LJGoodsSpecsView new];
    goodsSpecsView.frame = CGRectMake(0,0,screenWidth(),screenHeight() * 0.8);
    return goodsSpecsView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewLayouts];
        
        // 设置测试数据
        self.headView.goodsImageAddress = @"";
        self.headView.price = 18.99;
        self.headView.stock = 99;
        self.headView.formatInfoStr = @"已选择:\"红色\"+\"XL码\",数量:9";
        
        self.countView.minCount = 1;
        self.countView.maxCount = 9;
        self.countView.allowInput = NO;
    }
    return self;
}

#pragma mark - 点击事件
- (void)clickConfirmBtn:(UIButton *)sender {
    
}




#pragma mark - 子控件布局
- (void)setupSubviewLayouts {
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.countView.mas_bottom).offset(10);
    }];
    
    
    
    self.headView.backgroundColor = [UIColor whiteColor];
    self.countView.backgroundColor = [UIColor whiteColor];
}



#pragma mark - 懒加载
- (LJGoodsSpecsHeadView *)headView {
    if (!_headView) {
        LJGoodsSpecsHeadView *headView = [LJGoodsSpecsHeadView new];
        [self addSubview:headView];
        _headView = headView;
    }
    return _headView;
}

- (LJGoodsSpecsCollectionView *)collectionView {
    if (!_collectionView) {
        LJGoodsSpecsCollectionView *collectionView = [LJGoodsSpecsCollectionView defaultSpecsCollectionView];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (LJGoodsSpecsCountView *)countView {
    if (!_countView) {
        if (!_countView) {
            LJGoodsSpecsCountView *countView = [[LJGoodsSpecsCountView alloc] init];
            [self addSubview:countView];
            _countView = countView;
        }
        return _countView;
    }
    return _countView;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [btn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}



@end






