//
//  LJGoodsSpecsCollectionView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsCollectionView.h"
#import "LJGoodsSpecsCollectionViewCell.h"
#import "LJGoodsSpecsModel.h"
#import "LJGoodsOptionModel.h"
#import "ORSKUDataFilter.h"


@interface LJGoodsSpecsCollectionHeadView : UICollectionReusableView

/* title */
@property(weak, nonatomic) UILabel *titleLabel;

@end
@implementation LJGoodsSpecsCollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        self.titleLabel = label;
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(12);
        }];
    }
    return self;
}
@end






@interface LJGoodsSpecsCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource,ORSKUDataFilterDataSource>
@property(strong, nonatomic) ORSKUDataFilter *dataFilter;
@end

@implementation LJGoodsSpecsCollectionView

+ (instancetype)defaultSpecsCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 44);
//    LJGoodsSpecsCollectionView *collectionView = [[LJGoodsSpecsCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    LJGoodsSpecsCollectionView *collectionView = [[LJGoodsSpecsCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = collectionView;
    collectionView.dataSource = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[LJGoodsSpecsCollectionViewCell class] forCellWithReuseIdentifier:@"LJGoodsSpecsCollectionViewCell"];
    [collectionView registerClass:[LJGoodsSpecsCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJGoodsSpecsCollectionHeadView"];
    
//    [collectionView reloadData];
//    [collectionView layoutIfNeeded];
    
    
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerClass:[LJGoodsSpecsCollectionViewCell class] forCellWithReuseIdentifier:@"LJGoodsSpecsCollectionViewCell"];
    }
    return self;
}

#pragma mark - 重写set方法
- (void)setSpecsList:(NSArray<LJGoodsSpecsModel *> *)specsList {
    _specsList = specsList;
    [self reloadData];
}

#pragma mark - UIcollectionView dataSource and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.specsList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.specsList[section].itemList.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
        LJGoodsSpecsCollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJGoodsSpecsCollectionHeadView" forIndexPath:indexPath];
        headerView.titleLabel.text = self.specsList[indexPath.section].title;
        return headerView;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(100.0, 34.0);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJGoodsSpecsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJGoodsSpecsCollectionViewCell" forIndexPath:indexPath];
    LJGoodsSpecsModel *specsModel = self.specsList[indexPath.section];
    LJGoodsSpecsItemModel *itemModel = specsModel.itemList[indexPath.item];
    cell.titleLabel.text = itemModel.title;
    
    
    if ([self.dataFilter.availableIndexPathsSet containsObject:indexPath]) { // 库存大于0,可以选择
        cell.titleLabel.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0];
        cell.titleLabel.textColor = [UIColor colorWithRed:80.0/255 green:80.0/255 blue:80.0/255 alpha:1.0];
    }else { // 不能选择
        cell.titleLabel.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:0.5];
        cell.titleLabel.textColor = [UIColor colorWithRed:180.0/255 green:180.0/255 blue:180.0/255 alpha:1.0];
    }
    
    if ([self.dataFilter.selectedIndexPaths containsObject:indexPath]) { // 已经选择
        cell.titleLabel.backgroundColor = [UIColor colorWithRed:255.0/255 green:240.0/255 blue:247.0/255 alpha:1.0];
        cell.titleLabel.textColor = [UIColor colorWithRed:254.0/255 green:86.0/255 blue:104.0/255 alpha:1.0];
        
        cell.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    } else { // 未选择
        cell.titleLabel.layer.borderColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0].CGColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataFilter didSelectedPropertyWithIndexPath:indexPath];
    [collectionView reloadData];
    
    LJGoodsOptionModel *model = self.dataFilter.currentResult;
    if (self.clickOptionItemHandle) {
        self.clickOptionItemHandle(self.dataFilter.selectedIndexPaths, model);
    }
    
    
}

#pragma mark - ORSKUDataFilterDataSource
//属性种类个数
- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return self.specsList.count;
}

/*
 * 每个种类所有的的属性值
 * 这里不关心具体的值，可以是属性ID, 属性名，字典、model
 */
- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.specsList[section].itemList.count];
    for (int i = 0 ; i < self.specsList[section].itemList.count; i ++) {
        [array addObject:self.specsList[section].itemList[i].itemid];
    }
    return array;
}

//满足条件 的 个数
- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return self.optionList.count;
}

/*
 * 对应的条件式
 * 这里条件式的属性值，需要和filter:propertiesInSection里面的数据 类型保持一致
 */
- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    NSString *condition = self.optionList[row].specs;
    NSArray *arr = [condition componentsSeparatedByString:@"_"];
    return arr;
//    // 匹配不上  需要 倒序
//    NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
//    return reversedArray;
}

//条件式 对应的 结果数据（库存、价格等）
- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    return self.optionList[row];
}



- (ORSKUDataFilter *)dataFilter {
    if (!_dataFilter) {
        ORSKUDataFilter *dataFilter = [[ORSKUDataFilter alloc] initWithDataSource:self];
        _dataFilter = dataFilter;
    }
    return _dataFilter;
}
@end
