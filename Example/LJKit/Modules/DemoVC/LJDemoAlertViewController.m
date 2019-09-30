//
//  LJDemoAlertViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoAlertViewController.h"
#import "LJAlertViewController.h"
#import "LJAlertCheckPwdView.h"

/// 自定义dialog控制器
@interface LJDemoCustomAlertController : LJAlertViewController

@end

@interface LJDemoAlertViewController ()

@end

@implementation LJDemoAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = @[@"系统dialog",@"系统actionSheet",@"自定义dialogView",@"自定义actionSheetView",@"自定义dialog控制器",@"自定义actionSheet控制器",@"自定义-方块密码输入",@"自定义-滑块验证",@"自定义-日期选择"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSLog(@"点击了 row = %ld", row);
    if (row == 0) {
        [self normalDialog];
    }
    if (row == 1) {
        [self normalActionSheet];
    }
    if (row == 2) {
        [self customDialogView];
    }
    if (row == 3) {
        [self customActionSheetView];
    }
    if (row == 4) {
        [self customDialogController];
    }
    if (row == 5) {
        [self customActionSheetController];
    }
    if (row == 6) {
        [self checkPwdAlertView];
    }
    if (row == 7) {
        [self sliderCheckAlertView];
    }
    if (row == 8) {
        [self datePickerAlertView];
    }
}

#pragma mark - demo
- (void)normalDialog {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"翻译翻译" message:@"什么叫惊喜?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alertVC animated:YES completion:nil];
    });
}

- (void)normalActionSheet {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"翻译翻译" message:@"什么叫惊喜?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"我才是取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    [alertVC addAction:cancelAction1];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alertVC animated:YES completion:nil];
    });
   
}

- (void)customDialogView {
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor orangeColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    tempView.layer.cornerRadius = 10;
    [LJAlertViewController showWithContainerView:tempView alertStyle:UIAlertControllerStyleAlert];
}

- (void)customActionSheetView {
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor orangeColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    [LJAlertViewController showWithContainerView:tempView alertStyle:UIAlertControllerStyleActionSheet];
}

- (void)customDialogController {
    LJDemoCustomAlertController *customAlertVC = [LJDemoCustomAlertController new];
     customAlertVC.alertStyle = UIAlertControllerStyleAlert;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:customAlertVC animated:NO completion:nil];
    });
}

- (void)customActionSheetController {
    LJDemoCustomAlertController *customAlertVC = [LJDemoCustomAlertController new];
    customAlertVC.alertStyle = UIAlertControllerStyleActionSheet;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:customAlertVC animated:NO completion:nil];
    });
}

// 方块密码
- (void)checkPwdAlertView {
    LJAlertCheckPwdView *pwdView = [[LJAlertCheckPwdView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 0.8, 200)];
    
    [LJAlertViewController showWithContainerView:pwdView alertStyle:UIAlertControllerStyleAlert];
}

// 滑块验证
- (void)sliderCheckAlertView {
    
}

// 时间设置
- (void)datePickerAlertView {
    
}

@end




@implementation LJDemoCustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor greenColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    [self showWithContainerView:tempView alertStyle:self.alertStyle];
    
}

@end



