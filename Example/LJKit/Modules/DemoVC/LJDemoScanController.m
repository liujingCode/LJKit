//
//  LJDemoScanController.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoScanController.h"
#import "LJScanViewController.h"

@interface LJCustomScanViewController : LJScanViewController

@end

@implementation LJCustomScanViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
//    self.view.backgroundColor = [UIColor whiteColor];
}
@end


@interface LJDemoScanController ()

@end

@implementation LJDemoScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"仿微信扫描",@"仿支付宝扫描",@"生成二维码"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        LJCustomScanViewController *scanVC = [LJCustomScanViewController new];
        [self.navigationController pushViewController:scanVC animated:YES];
    } else if (row == 1) {
        LJCustomScanViewController *scanVC = [LJCustomScanViewController new];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
