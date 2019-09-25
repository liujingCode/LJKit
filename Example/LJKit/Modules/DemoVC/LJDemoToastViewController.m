//
//  LJDemoToastViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoToastViewController.h"
#import "LJToast.h"
@interface LJDemoToastViewController ()

@end

@implementation LJDemoToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"纯文字",@"纯图片",@"文本加图片",@"文本loading",@"图片loading",@"文本+图片loading",@"进度"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSInteger row = indexPath.row;
    if (row == 0) {
        
    } else if (row == 1) {
        
    } else if (row == 2) {
        
    } else if (row == 3) {
        
    } else if (row == 4) {
        
    } else if (row == 5) {
        
    } else if (row == 6) {
        [LJToast showProgressWithText:@"正在拼命上传中" andImage:[UIImage imageNamed:@""] andEnableInteraction:YES];
    }
}

@end
