//
//  LJDemoCustomUIController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoCustomUIController.h"
#import "LJDemoCustomUIScrollViewController.h"

@interface LJDemoCustomUIController ()

@end

@implementation LJDemoCustomUIController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"UIscrollView+Refresh",@"UIButton按钮处理",@"UIImage图片处理",@"扫一扫",@"生成二维码",@"手势密码",@"滑块验证"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *targetVC = [UIViewController new];
    targetVC.title = self.dataList[indexPath.row];
    switch (indexPath.row) {
        case 0:
            targetVC = [LJDemoCustomUIScrollViewController new];
            break;
            
        default:
            break;
    }
    
    targetVC.title = self.dataList[indexPath.row];
    targetVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:targetVC animated:YES];
}
@end
