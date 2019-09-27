//
//  LJDemoAlertViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoAlertViewController.h"
#import "LJAlertViewController.h"

/// 自定义dialog控制器
@interface LJDemoCustomDialogController : LJAlertViewController

@end

/// 自定义actionSheet控制器
@interface LJDemoCustomActionSheetController : LJAlertViewController

@end

@interface LJDemoAlertViewController ()

@end

@implementation LJDemoAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"普通dialog",@"普通actionSheet",@"自定义dialogView",@"自定义actionSheetView",@"自定义dialog控制器",@"自定义actionSheet控制器"];
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
        [self normalDialog];
    }
    if (row == 3) {
        [self normalActionSheet];
    }
    if (row == 4) {
        [self normalDialog];
    }
    if (row == 5) {
        [self normalActionSheet];
    }
}

#pragma mark - demo
- (void)normalDialog {
    LJAlertViewController *alertVC = [LJAlertViewController alertControllerWithTitle:@"标题" message:@"详细" preferredStyle:LJAlertViewControllerStyleDialog];
    LJAlertAction *action1 = [LJAlertAction new];
    LJAlertAction *action2 = [LJAlertAction new];
    LJAlertAction *action3 = [LJAlertAction new];
    LJAlertAction *action4 = [LJAlertAction new];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    [self presentViewController:alertVC animated:NO completion:nil];
}

- (void)normalActionSheet {
    LJAlertViewController *alertVC = [LJAlertViewController alertControllerWithTitle:@"标题" message:@"详细" preferredStyle:LJAlertViewControllerStyleActionSheet];
    LJAlertAction *action1 = [LJAlertAction new];
    LJAlertAction *action2 = [LJAlertAction new];
    LJAlertAction *action3 = [LJAlertAction new];
    LJAlertAction *action4 = [LJAlertAction new];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    
    dispatch_async(dispatch_get_main_queue(), ^{

        [self presentViewController:alertVC animated:NO completion:nil];

    });
}

- (void)customDialogView {
    
}

- (void)customActionSheetView {
    
}

- (void)customDialogController {
    LJDemoCustomDialogController *dialogVC = [LJDemoCustomDialogController new];
    [self presentViewController:dialogVC animated:NO completion:nil];
}

- (void)customActionSheetController {
    LJDemoCustomActionSheetController *dialogVC = [LJDemoCustomActionSheetController new];
    [self presentViewController:dialogVC animated:NO completion:nil];
}

@end




@implementation LJDemoCustomDialogController



@end

@implementation LJDemoCustomActionSheetController



@end


