//
//  LJGoodsSpecsCollectionView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJGoodsSpecsCollectionView.h"
#import "LJGoodsSpecsCollectionViewCell.h"

@interface LJGoodsSpecsCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation LJGoodsSpecsCollectionView

+ (instancetype)defaultSpecsCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    LJGoodsSpecsCollectionView *collectionView = [[LJGoodsSpecsCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = collectionView;
    collectionView.dataSource = collectionView;
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerClass:[LJGoodsSpecsCollectionViewCell class] forCellWithReuseIdentifier:@"LJGoodsSpecsCollectionViewCell"];
    }
    return self;
}

#pragma mark - UIcollectionView dataSource and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.specsList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJGoodsSpecsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJGoodsSpecsCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
@end
