//
//  LJDemoCustomUIScrollViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoCustomUIScrollViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface LJDemoCustomUIScrollViewController ()<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation LJDemoCustomUIScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空数据" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    
    self.dataList = @[@"默认数据0",@"默认数据1",@"默认数据2"];
    
    [self setupRefresh];
    [self setupEmptyView];
    
    
}

- (void)setDataList:(NSArray<NSString *> *)dataList {
    [super setDataList:dataList];
    self.tableView.lj_refreshFooter.hidden = (dataList.count == 0)?YES:NO;
}

- (void)clickRightItem {
    self.dataList = @[];
}



#pragma mark - 设置空白页
- (void)setupEmptyView {
    // 设置空数据
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark - 设置下拉刷新和下拉加载更多
- (void)setupRefresh {
    // 下拉刷新
    [self.tableView lj_refreshCreateHeaderWithHandle:^{
        [self requestData];
        
    }];
    
    // 上拉加载更多
    [self.tableView lj_refreshCreateFooterWithHandle:^{
        [self requestMoreData];
    }];
}


- (void)requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView lj_refreshEndHeader];
        self.dataList = @[@"默认数据0",@"默认数据1",@"默认数据2"];
    });
}

- (void)requestMoreData {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataList];
    [tempArray addObject:[NSString stringWithFormat:@"添加数据%lu",(unsigned long)self.dataList.count]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL noMore = (tempArray.count >= 6)?YES:NO;
        [self.tableView lj_refreshEndFooterAndNoMore:noMore];
        self.dataList = tempArray.copy;
    });
}


#pragma mark - DZNEmptyDataSetSource
/// 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
    NSString *title = isRefreshing?@"正在刷新哦":@"网络好像有点问题哦";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

/// 空白页显示详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
    NSString *text = isRefreshing?@"正在刷新,没空聊粉的事":@"你吃了两碗粉,只给了一碗的钱!你这不是欺负老实人吗";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                               NSForegroundColorAttributeName:[UIColor lightGrayColor],
                               NSParagraphStyleAttributeName:paragraph
                               };

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/// 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"share_qq_session"];
}

/// 空白色图片动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *) scrollView {
    return nil;
}

/// 空白页按钮的标题
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
    // 设置按钮标题
    NSString *buttonTitle = isRefreshing?@"":@"点击刷新";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}

/// 空白页按钮的图片
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}

/// 空白页按钮的背景图片
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}


/// 空白页背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

//// 空白页自定义视图
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIView new];
//}


/// 垂直方向的偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}


/// 各个元素间的间距 默认11
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 11.0;
}


#pragma mark - DZNEmptyDataSetDelegate
/// 是否显示空白页面
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}
/// 是否已淡入淡出的方式显示空白页面
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

/// 强制显示空数据集：当项目数量大于0时，请求代理是否仍应显示空数据集。（默认值为NO）
- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView; {
    return NO;
}

/// 获取交互权限:是否接收用户点击事件（默认为YES)
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

/// 获取滚动权限（默认值为NO)
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

/// 获取图像动画权限：是否开启图片动画（默认值为NO)
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}


/// 空白数据集 视图被点击时触发该方法
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {

}

/// 空白数据集 按钮被点击时 触发该方法
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    BOOL isRefreshing = self.tableView.lj_refreshHeader.refreshing;
    if (isRefreshing) { // 正在刷新
        return;
    }
    [self.tableView lj_refreshStartHeader];
}

/// 空白页将要出现
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    
}

/// 空白页已经出现
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    
}

/// 空白页将要消失
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {
    
}

/// 空白页已经消失
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView {
    
}

@end



#pragma mark - 空数据视图的关键方法
/**
 
 /// 空白页显示标题
 - (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
     BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
     NSString *title = isRefreshing?@"正在刷新哦":@"网络好像有点问题哦";
     NSDictionary *attributes = @{
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                  };
     return [[NSAttributedString alloc] initWithString:title attributes:attributes];
 }

 /// 空白页显示详细描述
 - (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
     BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
     NSString *text = isRefreshing?@"正在刷新,没空聊粉的事":@"你吃了两碗粉,只给了一碗的钱!你这不是欺负老实人吗";
     NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
     paragraph.lineBreakMode = NSLineBreakByWordWrapping;
     paragraph.alignment = NSTextAlignmentCenter;

     NSDictionary *attributes = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                NSParagraphStyleAttributeName:paragraph
                                };

     return [[NSAttributedString alloc] initWithString:text attributes:attributes];
 }

 /// 空白页显示图片
 - (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
     return [UIImage imageNamed:@"share_qq_session"];
 }

 /// 空白页按钮的标题
 - (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
     BOOL isRefreshing = self.tableView.lj_refreshHeader.isRefreshing;
     // 设置按钮标题
     NSString *buttonTitle = isRefreshing?@"":@"点击刷新";
     NSDictionary *attributes = @{
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]
                                  };
     return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
 }
 
 #pragma mark - DZNEmptyDataSetDelegate
 /// 是否显示空白页面
 - (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
     return YES;
 }
 
 /// 空白数据集 按钮被点击时 触发该方法
 - (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
     BOOL isRefreshing = self.tableView.lj_refreshHeader.refreshing;
     if (isRefreshing) { // 正在刷新
         return;
     }
     [self.tableView lj_refreshStartHeader];
 }
 
 */
