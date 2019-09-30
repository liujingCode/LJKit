//
//  LJHomeViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import "LJDemoHomeViewController.h"
#import "LJDemoHttpManagerController.h"
#import "LJDemoDebugController.h"
#import "LJDemoFileManagerController.h"
#import "LJDemoImagePickerController.h"
#import "LJDemoLocationController.h"
#import "LJDemoCustomUIController.h"
#import "LJDemoToastViewController.h"
#import "LJDemoAlertViewController.h"
#import "LJDemoAnimationController.h"
@interface LJDemoHomeViewController ()

@end

@implementation LJDemoHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    self.dataList = @[@"网络请求",@"Toast",@"UIAlertController",@"自定义UI相关",@"定位",@"相册选择或拍照",@"自定义键盘",@"navigationBar",@"tabBar",@"Debug",@"文件管理",@"字符串正则校验",@"Animation"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *targetVC = [UIViewController new];
    targetVC.title = self.dataList[indexPath.row];
    switch (indexPath.row) {
        case 0:
            targetVC = [LJDemoHttpManagerController new];
            break;
        case 1:
            targetVC = [LJDemoToastViewController new];
            break;
        case 2:
            targetVC = [LJDemoAlertViewController new];
            break;
        case 3:
            targetVC = [LJDemoCustomUIController new];
            break;
        case 4:
            targetVC = [LJDemoLocationController new];
            break;
        case 5:
            targetVC = [LJDemoImagePickerController new];
            break;
            
        case 9:
            targetVC = [LJDemoDebugController new];
            break;
        case 10:
            targetVC = [LJDemoFileManagerController new];
        case 12:
            targetVC = [LJDemoAnimationController new];
            
            
        default:
            break;
    }
    
    targetVC.title = self.dataList[indexPath.row];
    targetVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
