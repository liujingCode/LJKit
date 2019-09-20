//
//  LJDemoFileManagerController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoFileManagerController.h"
#import "LJFileManager.h"

@interface LJDemoFileManagerController ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation LJDemoFileManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    label.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
//    [self.view addSubview:label];
    self.label = label;
    
    self.tableView.tableHeaderView = label;
    
    
    self.dataList = @[@"创建文件",@"删除文件",@"删除文件夹"@"查看文件或文件夹是否存在"];
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
