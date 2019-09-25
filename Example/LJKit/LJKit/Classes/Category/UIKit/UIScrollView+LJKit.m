//
//  UIScrollView+LJKit.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "UIScrollView+LJKit.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface UIScrollView ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
/// 下拉刷新
@property (nonatomic, strong) LJRefreshHeader *lj_refreshHeader;

/// 上拉加载更多
@property (nonatomic, strong) LJRefreshFooter *lj_refreshFooter;
@end

@implementation UIScrollView (LJKit)

@end

#pragma mark - UIScrollView+LJRefresh
@implementation UIScrollView (LJRefresh)
- (void)lj_refreshCreateHeaderWithHandle:(LJKitRefreshHandle)handle {
    LJRefreshHeader *header = [LJRefreshHeader headerWithRefreshingBlock:handle];
    self.lj_refreshHeader = header;
    self.mj_header = header;
}
- (void)lj_refreshCreateFooterWithHandle:(LJKitRefreshHandle)handle {
    LJRefreshFooter *footer = [LJRefreshFooter footerWithRefreshingBlock:handle];
    self.lj_refreshFooter = footer;
    self.mj_footer = footer;
}
- (void)lj_refreshStartHeader {
    [self lj_refreshEndFooterAndNoMore:NO];
    [self.lj_refreshHeader beginRefreshing];
}
- (void)lj_refreshStartFooter {
    [self.lj_refreshFooter beginRefreshing];
}
- (void)lj_refreshEndHeader {
    [self.lj_refreshHeader endRefreshing];
}
- (void)lj_refreshEndFooterAndNoMore:(BOOL)noMore {
    if (noMore) { // 没有更多数据
        [self.lj_refreshFooter endRefreshingWithNoMoreData];
    } else {
        [self.lj_refreshFooter endRefreshing];
    }
}

#pragma mark - 设置属性
- (void)setLj_refreshHeader:(LJRefreshHeader *)lj_refreshHeader {
    objc_setAssociatedObject(self, @selector(setLj_refreshHeader:), lj_refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LJRefreshHeader *)lj_refreshHeader {
    return objc_getAssociatedObject(self, @selector(setLj_refreshHeader:));
}

- (void)setLj_refreshFooter:(LJRefreshFooter *)lj_refreshFooter {
    objc_setAssociatedObject(self, @selector(setLj_refreshFooter:), lj_refreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LJRefreshFooter *)lj_refreshFooter {
    return objc_getAssociatedObject(self, @selector(setLj_refreshFooter:));
}


@end






#pragma mark - LJRefreshHeader
@implementation LJRefreshHeader
/// 重写初始化方法
- (void)prepare {
    [super prepare];
    [self setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
}
@end

#pragma mark - LJRefreshFooter
@implementation LJRefreshFooter

/// 重写初始化方法
- (void)prepare {
    [super prepare];
    [self setTitle:@"别拉啦!人家也是有底线的" forState:MJRefreshStateNoMoreData];
}
@end

