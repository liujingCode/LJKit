//
//  LJDemoHttpManagerController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoHttpManagerController.h"

@interface LJDemoHttpManagerController ()

@end

@implementation LJDemoHttpManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"普通get或post",@"上传文件",@"下载文件"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
