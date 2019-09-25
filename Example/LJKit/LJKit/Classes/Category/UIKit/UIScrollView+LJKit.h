//
//  UIScrollView+LJKit.h
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@class LJRefreshHeader;
@class LJRefreshFooter;

NS_ASSUME_NONNULL_BEGIN
typedef void(^LJKitRefreshHandle)(void);
@interface UIScrollView (LJKit)


@end

#pragma mark - UIScrollView+LJRefresh
@interface UIScrollView (LJRefresh)
/// 下拉刷新
@property (nonatomic, strong,readonly) LJRefreshHeader *lj_refreshHeader;

/// 上拉加载更多
@property (nonatomic, strong,readonly) LJRefreshFooter *lj_refreshFooter;

/// 创建下拉刷新
/// @param handle 下拉刷新后的回调
- (void)lj_refreshCreateHeaderWithHandle:(LJKitRefreshHandle)handle;

/// 创建上拉加载更多
/// @param handle 上拉加载更多的回调
- (void)lj_refreshCreateFooterWithHandle:(LJKitRefreshHandle)handle;
/// 开始下拉刷新
- (void)lj_refreshStartHeader;

/// 开始上拉加载更多
- (void)lj_refreshStartFooter;

/// 结束下拉刷新
- (void)lj_refreshEndHeader;

/// 结束上拉加载更多
/// @param noMore 是否显示"没有更多数据"
- (void)lj_refreshEndFooterAndNoMore:(BOOL)noMore;

@end

#pragma mark - LJRefreshHeader
@interface LJRefreshHeader : MJRefreshGifHeader

@end

#pragma mark - LJRefreshFooter
@interface LJRefreshFooter : MJRefreshAutoGifFooter

@end

NS_ASSUME_NONNULL_END
