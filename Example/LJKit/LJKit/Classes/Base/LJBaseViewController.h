//
//  LJBaseViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJBaseViewController : UIViewController

/**
 设置tableView
 */
- (void)setupTableView;

/**
 设置collectionView
 */
- (void)setupCollectionView;


/**
 下拉刷新
 */
- (void)refreshHeader;


/**
 上拉加载
 */
- (void)refreshFooter;


@end

NS_ASSUME_NONNULL_END
