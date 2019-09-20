//
//  LJClassViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJClassHomeController.h"
#include <objc/runtime.h>
#import "LJClassDetailController.h"

@interface LJClassHomeController ()<UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray <NSString *>*allClassesArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*showClassesArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation LJClassHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"查看类的属性和方法";
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)clickBackItem {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showClassesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        
        cell.detailTextLabel.numberOfLines = 1;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    }
    NSString *className = self.showClassesArray[indexPath.row];
    NSString *superclassName = NSStringFromClass(class_getSuperclass(NSClassFromString(className)));
    
    cell.textLabel.text = className;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"superClass:%@",superclassName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchController.active = NO;
    Class targetClass = NSClassFromString(self.showClassesArray[indexPath.row]);
    LJClassDetailController *VC = [LJClassDetailController new];
    VC.targetClass = targetClass;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UISearchResultsUpdating (Required)
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (searchText.length < 2) {
        return;
    }
    self.showClassesArray = nil;
    for (NSString *className in self.allClassesArray) {
        if ([className.lowercaseString containsString:searchText.lowercaseString]) {
            [self.showClassesArray addObject:className];
        }
    }
    
    // 排序
    [self.showClassesArray sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        double matchingWeight1 = [self matchingWeightForResult:obj1 withSearchString:searchText];
        double matchingWeight2 = [self matchingWeightForResult:obj2 withSearchString:searchText];
        NSComparisonResult result = matchingWeight1 == matchingWeight2 ? NSOrderedSame : (matchingWeight1 > matchingWeight2 ? NSOrderedAscending : NSOrderedDescending);
        return result;
    }];
    
    [self.tableView reloadData];
    
    // 刷新数据
    [self.tableView reloadData];
}

#pragma mark - 展示权重排序
- (double)matchingWeightForResult:(NSString *)className withSearchString:(NSString *)searchString {
    /**
     排序方式：
     1. 每个 className 都有一个基准的匹配权重，权重取值范围 [0-1]，这个权重简单地以字符串长度来计算，匹配到的 className 里长度越短的 className 认为匹配度越高
     2. 基于步骤 1 得到的匹配权重进行分段，以搜索词开头的 className 权重最高，以下划线开头的 className 权重最低（如果搜索词本来就以下划线开头则不计入此种情况），其他情况权重中等。
     3. 特别的，如果 className 与搜索词完全匹配，则权重最高，为 1
     4. 最终权重越高者排序越靠前
     */
    
    className = className.lowercaseString;
    searchString = searchString.lowercaseString;
    
    if ([className isEqualToString:searchString]) {
        return 1;
    }
    
    double matchingWeight = (double)searchString.length / (double)className.length;
    if ([className hasPrefix:searchString]) {
        return matchingWeight * 1.0 / 3.0 + 2.0 / 3.0;
    }
    if ([className hasPrefix:@"_"] && ![searchString hasPrefix:@"_"]) {
        return matchingWeight * 1.0 / 3.0;
    }
    matchingWeight = matchingWeight * 1.0 / 3.0 + 1.0 / 3.0;
    
    return matchingWeight;
}

- (NSArray<NSString *> *)allClassesArray {
    if (!_allClassesArray) {
        NSMutableArray<NSString *> *tempArray = [[NSMutableArray alloc] init];
        Class *classes = nil;
        int numberOfClasses = objc_getClassList(nil, 0);
        if (numberOfClasses > 0) {
            classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numberOfClasses);
            numberOfClasses = objc_getClassList(classes, numberOfClasses);
            for (int i = 0; i < numberOfClasses; i++) {
                Class c = classes[i];
                [tempArray addObject:NSStringFromClass(c)];
            }
            free(classes);
        }
        _allClassesArray = tempArray.copy;
    }
    return _allClassesArray;
}

- (NSMutableArray<NSString *> *)showClassesArray {
    if (!_showClassesArray) {
        _showClassesArray = [NSMutableArray array];
    }
    return _showClassesArray;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil]; // 如果用同一个视图展示搜索结果传nil就行.
        _searchController.searchResultsUpdater = self; // 搜索逻辑处理
        //_searchController.delegate = self; // 监听 搜索视图控制器的 出现与消失
//        _searchController.searchBar.delegate = self; // 监听搜索框
        _searchController.searchBar.placeholder = @"请输入Class名";
        //_searchController.hidesNavigationBarDuringPresentation = NO; // 搜索时隐藏导航栏
        _searchController.dimsBackgroundDuringPresentation = NO;
    }
    return _searchController;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView = self.searchController.searchBar;
        tableView.rowHeight = 60.0;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
@end
