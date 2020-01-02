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
    self.dataList = @[@"沙盒浏览",@"沙盒局域网浏览",@"log写入沙盒",@"log写入沙盒并实时展示",@"查看属性和方法",@"写入一条log"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { // 沙盒浏览
        [LJDebugLogManager showSandBox];
        return;
    }
    if (indexPath.row == 1) { // 沙盒局域网浏览
        [LJDebugLogManager sharedManager].enableSandBoxLocalNetwork = YES;
        return;
    }
    if (indexPath.row == 2) {
        
        return;
    }
    if (indexPath.row == 4) { // 查看属性和方法
        [LJDebugLogManager showClassDetail];
        return;
    }
    if (indexPath.row == 5) { // 写入一条log
        NSString *testLog = [NSString stringWithFormat:@"测试log = %@",[NSDate date]];
        NSLog(@"%@",testLog);
        return;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"LJDemoDebugControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    switch (indexPath.item) {
        case 0:
            break;
        case 1:{ // 沙盒在局域网查看
            UISwitch *accessoryView = [[UISwitch alloc] init];
            accessoryView.on = [LJDebugLogManager sharedManager].enableSandBoxLocalNetwork;
            [accessoryView addTarget:self action:@selector(clickEnableSandBox:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = accessoryView;
        }
            break;
        case 2: { // log写入沙盒
            UISwitch *accessoryView = [[UISwitch alloc] init];
            [accessoryView addTarget:self action:@selector(clickEnableSaveLogToLocal:) forControlEvents:UIControlEventValueChanged];
            accessoryView.on = [LJDebugLogManager sharedManager].enableSaveLogToLocal;
            cell.accessoryView = accessoryView;
        }
            break;
        case 3:{ // log写入沙盒并展示
            UISwitch *accessoryView = [[UISwitch alloc] init];
            [accessoryView addTarget:self action:@selector(clickEnableLiveLog:) forControlEvents:UIControlEventValueChanged];
            accessoryView.on = [LJDebugLogManager sharedManager].enableLiveLog;
            cell.accessoryView = accessoryView;
        }
            break;
        case 4:
            break;
            
        default:
            break;
    }
    
    return cell;
}


// 改变局域网查看沙盒的状态
- (void)clickEnableSandBox:(UISwitch *)sender {
    [LJDebugLogManager sharedManager].enableSandBoxLocalNetwork = ![LJDebugLogManager sharedManager].enableSandBoxLocalNetwork;
}

// 改变实时log的状态
- (void)clickEnableLiveLog:(UISwitch *)sender {
    [LJDebugLogManager sharedManager].enableLiveLog = ![LJDebugLogManager sharedManager].enableLiveLog;
}

// 改变log写入沙盒的状态
- (void)clickEnableSaveLogToLocal:(UISwitch *)sender {
    [LJDebugLogManager sharedManager].enableSaveLogToLocal = ![LJDebugLogManager sharedManager].enableSaveLogToLocal;
}

@end
