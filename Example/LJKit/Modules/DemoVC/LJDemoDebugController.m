//
//  LJDemoDebugController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoDebugController.h"
#import "LJSandboxViewController.h"
#import "LJClassViewController.h"
#import "LJDebugLogManager.h"

@interface LJDemoDebugController ()

@end

@implementation LJDemoDebugController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"沙盒浏览",@"开启或关闭实时log",@"查看UI层级视图",@"查看属性和方法"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LJSandboxViewController *VC = [LJSandboxViewController new];
        [self presentViewController:VC animated:YES completion:nil];
        return;
    }
    if (indexPath.row == 1) {
        [LJDebugLogManager show];
        return;
    }
    if (indexPath.row == 2) {
        LJSandboxViewController *VC = [LJSandboxViewController new];
        [self presentViewController:VC animated:YES completion:nil];
        return;
    }
    if (indexPath.row == 3) {
        LJClassViewController *VC = [LJClassViewController new];
        [self presentViewController:VC animated:YES completion:nil];
        // 触发crash
//        @[][2];
        return;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

@end
