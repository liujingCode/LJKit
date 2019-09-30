//
//  LJBoxTextFieldView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJBoxTextFieldView.h"

#import "LJBoxTextFieldViewCell.h"
@interface LJBoxTextFieldView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/// 当前光标的角标
@property (nonatomic, assign) NSInteger currentIndicatorIndex;

@property (nonatomic, weak) UITextField *textField;
@end

@implementation LJBoxTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.textField becomeFirstResponder];
    }
    return self;
}

- (void)setBoxCount:(int)boxCount {
    _boxCount = boxCount;
    [self.collectionView reloadData];
}

#pragma mark - textField
- (void)textValueDidEdited:(UITextField *)sender {
    NSString *value = sender.text;
    NSInteger length = value.length;
    if (length >= self.boxCount) { // 输入完成
        [self.collectionView reloadData];
        [self endEditing:YES];
        if (self.completeHandle) {
            self.completeHandle(value);
        }
        return;
    }
    
    
    if (length > 0) {
        self.currentIndicatorIndex = length - 1;
        [self.collectionView reloadData];
    }
    
    if (length == 0) {
        [self.collectionView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width / self.boxCount;
    self.flowLayout.itemSize = CGSizeMake(width, width);
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(self);
        make.height.mas_equalTo(width);
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView Delegate and DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.boxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJBoxTextFieldViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJBoxTextFieldViewCell" forIndexPath:indexPath];
    if (self.textField.text.length > 0) {
        cell.showPlaceholderImage = (indexPath.item < self.textField.text.length)?YES:NO;
    } else {
        cell.showPlaceholderImage = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField becomeFirstResponder];
}


#pragma mark - 懒加载
- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectZero;
        textField.hidden = YES;
        [textField addTarget:self action:@selector(textValueDidEdited:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        collectionView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        collectionView.layer.borderWidth = 1.0;
        collectionView.layer.cornerRadius = 2;
        [collectionView registerClass:[LJBoxTextFieldViewCell class] forCellWithReuseIdentifier:@"LJBoxTextFieldViewCell"];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}
@end
