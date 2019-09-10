//
//  LJHomeViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import "LJHomeViewController.h"
#import "LJDemoHttpManagerController.h"
@interface LJHomeViewController ()

@end

@implementation LJHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    self.dataList = @[@"网络请求",@"Toast",@"弹框",@"自定义UI",@"定位",@"相册选择或拍照",@"自定义键盘",@"navigationBar",@"tabBar"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *targetVC = [UIViewController new];
    targetVC.title = self.dataList[indexPath.row];
    switch (indexPath.row) {
        case 0:
            targetVC = [LJDemoHttpManagerController new];
            targetVC.title = self.dataList[indexPath.row];
            break;
            
        default:
            break;
    }
    
    
    targetVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
