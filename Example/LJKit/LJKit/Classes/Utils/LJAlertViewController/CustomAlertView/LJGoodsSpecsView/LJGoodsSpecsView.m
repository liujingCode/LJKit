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
#import "LJGoodsModel.h"
#import "LJGoodsOptionSelectedModel.h"


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

/// 商品
@property (nonatomic, strong) LJGoodsModel *goods;

/// 已经选择了的规格
@property (nonatomic, strong) LJGoodsOptionSelectedModel *selectedModel;

/// 已经选择了的规格
@property (nonatomic, copy) NSArray<NSIndexPath *> *selectedIndexPaths;
@end

@implementation LJGoodsSpecsView
+ (instancetype)defaultViewWithGoods:(LJGoodsModel *)goods {
    LJGoodsSpecsView *goodsSpecsView = [LJGoodsSpecsView new];
    goodsSpecsView.goods = goods;
    goodsSpecsView.frame = CGRectMake(0,0,screenWidth(),screenHeight() * 0.8);
    return goodsSpecsView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewLayouts];
        self.selectedModel = [LJGoodsOptionSelectedModel new];
    }
    return self;
}

#pragma mark - 重写set
- (void)setGoods:(LJGoodsModel *)goods {
    _goods = goods;
    __weak typeof(self) weakSelf = self;
    
    // 头部
    self.headView.goodsImageAddress = goods.thumbStr;
    self.headView.price = [goods.price floatValue];
    self.headView.stock = [goods.total intValue];
    self.headView.closeHandle = ^{
        if (weakSelf.dismissHandle) {
            weakSelf.dismissHandle(weakSelf.selectedModel,YES);
        }
    };
    
    // 数量加减
    if ([goods.total intValue] <= 0) {
        self.countView.currentCount = 0;
        self.countView.minCount = 0;
        self.countView.maxCount = 0;
    } else {
        self.countView.currentCount = 1;
        self.countView.minCount = 1;
        self.countView.maxCount = [goods.total intValue];
    }
    self.countView.allowInput = NO;
    self.countView.countChangedHandle = ^(int count) {
        [weakSelf formatInfoStrWithSelectedIndexPath:weakSelf.selectedIndexPaths];
    };
    
    // 选项规格
    self.collectionView.specsList = self.goods.specsList;
    // 移除库存为0的选项
    NSMutableArray *tempOptionList = [NSMutableArray arrayWithArray:self.goods.optionList];
    for (LJGoodsOptionModel *optionModel in tempOptionList) {
        if ([optionModel.stock intValue] <= 0) {
            [tempOptionList removeObject:optionModel];
        }
    }
    self.collectionView.optionList = tempOptionList.mutableCopy;
    self.collectionView.clickOptionItemHandle = ^(NSArray<NSIndexPath *> * _Nonnull selectedIndexPaths, LJGoodsOptionModel * _Nonnull optionModel) {
        weakSelf.selectedModel.optionModel = optionModel;
        [weakSelf formatInfoStrWithSelectedIndexPath:selectedIndexPaths];
    };
    
    // 初始化头部的商品信息
    [self formatInfoStrWithSelectedIndexPath:nil];
}

#pragma mark - 格式化描述信息
- (void)formatInfoStrWithSelectedIndexPath:(NSArray <NSIndexPath *>*)selectedIndexPaths  {
    self.selectedIndexPaths = selectedIndexPaths;
    NSMutableString *mStr = nil;
    if (self.goods.specsList.count == 0) {// 不需要选择规格
        self.confirmBtn.enabled = YES;
        
        self.headView.stock = [self.goods.total intValue];
        mStr = [NSMutableString stringWithString:@"已选择:"];
        [mStr appendString:[NSString stringWithFormat:@" 数量:%d", self.countView.currentCount]];
    } else {
        if (self.selectedModel.optionModel) { // 全都已经选择,确定了商品
            self.confirmBtn.enabled = YES;
            
            self.headView.stock = [self.selectedModel.optionModel.stock intValue];
            self.headView.price = [self.selectedModel.optionModel.price floatValue];
            
            self.countView.maxCount = [self.selectedModel.optionModel.stock intValue];
            if (self.countView.currentCount > [self.selectedModel.optionModel.stock intValue]) {
                self.countView.currentCount = [self.selectedModel.optionModel.stock intValue];
            }
            
            mStr = [NSMutableString stringWithString:@"已选择:"];
            [mStr appendString:[NSString stringWithFormat:@"%@",self.selectedModel.optionModel.title]];
            [mStr appendString:[NSString stringWithFormat:@" 数量:%d,", self.countView.currentCount]];
        } else { // 选择了部分规格(还没确定商品)
            self.confirmBtn.enabled = NO;
            
            self.headView.stock = [self.goods.total intValue];
            mStr = [NSMutableString stringWithString:@"请选择:"];
            for  (LJGoodsSpecsModel *model in self.goods.specsList) {
                [mStr appendString:[NSString stringWithFormat:@"%@,",model.title]];
            }
            for (int i = 0; i < selectedIndexPaths.count; i ++) {
                NSIndexPath *currentIndexPath = selectedIndexPaths[i];
                if (currentIndexPath.section < self.goods.specsList.count) {
                    LJGoodsSpecsModel *model = self.goods
                    .specsList[currentIndexPath.section];
                    // 删除美白选择的option title
                    [mStr deleteCharactersInRange:[mStr rangeOfString:[NSString stringWithFormat:@"%@,",model.title]]];
                }
            }
        }
        // 删除最后一个逗号
        [mStr deleteCharactersInRange:NSMakeRange(mStr.length - 1, 1)];
    }
    self.headView.formatInfoStr = mStr;
}

#pragma mark - 点击事件
- (void)clickConfirmBtn:(UIButton *)sender {
    if (self.dismissHandle) {
        self.dismissHandle(self.selectedModel,NO);
    }
}




#pragma mark - 子控件布局
- (void)setupSubviewLayouts {
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.height.mas_equalTo(200);
    }];
    
//    [self.collectionView layoutIfNeeded];
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self).offset(-10);
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
        [btn setTitle:@"请选择商品属性" forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [btn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}



@end






