//
//  LJDemoAuthorizatioController.m
//  LJKit_Example
//
//  Created by developer on 2019/12/19.
//  Copyright © 2019 liujing. All rights reserved.
//
@interface LJDemoAuthorizatioControllerCell : UITableViewCell

@end

@implementation LJDemoAuthorizatioControllerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
@end

#import "LJDemoAuthorizatioController.h"
#import "LJAuthorizationManager.h"
@interface LJDemoAuthorizatioController ()

@end

/// <#Description#>
@implementation LJDemoAuthorizatioController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"权限状态";
    self.dataList = @[@"相机权限",@"相册权限",@"定位权限",@"网络权限",@"通讯录权限",@"麦克风权限"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请求权限" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJDemoAuthorizatioControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJDemoAuthorizatioControllerCell"];
    if (!cell) {
        cell = [[LJDemoAuthorizatioControllerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LJDemoAuthorizatioControllerCell"];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    
    NSString *statuString = @"设备不支持";
    LJKitAuthorizationStatus statu;
    switch (indexPath.row) {
        case 0: {  // 相机权限
            statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeCamera];
            statuString = [self formatStringWithStatu:statu];
        }
            break;
        case 1: {  // 相册权限
            statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeMediaLibrary];
            statuString = [self formatStringWithStatu:statu];
        }
            break;
        case 2: {  // 定位权限
            statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeLocation];
            statuString = [self formatStringWithStatu:statu];
        }
            break;
        case 3: {  // 网络权限
            statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeTelephony];
            statuString = [self formatStringWithStatu:statu];
        }
        case 4: {  // 通讯录权限
            statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeContact];
            statuString = [self formatStringWithStatu:statu];
        }
            break;
        case 5: {  // 麦克风权限
                statu = [LJAuthorizationManager getAuthorizationStateWithType:LJKitAuthorizationTypeMicroPhone];
                statuString = [self formatStringWithStatu:statu];
            }
                break;
            
        default:
            break;
    }
    
    cell.detailTextLabel.text = statuString;
    return cell;
}

- (void)clickRightItem {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i <self.dataList.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:self.dataList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            switch (i) {
                case 0:{ // 请求相机权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeCamera complete:^(LJKitAuthorizationStatus status) {
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                        // 刷新数据
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    }];
                    break;
                }
                    
                case 1: { // 请求相册权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeMediaLibrary complete:^(LJKitAuthorizationStatus status) {
                        
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                         
                        // 刷新数据
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    }];
                    break;
                }
                case 2:{ // 请求定位权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeLocation complete:^(LJKitAuthorizationStatus status) {
                        
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                        
                        // 刷新数据
                        [self.tableView reloadData];
                        
                        
                    }];
                    break;
                }
                case 3:{ // 请求网络权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeTelephony complete:^(LJKitAuthorizationStatus status) {
                        
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                        
                        // 刷新数据
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                        
                    }];
                    break;
                }
                case 4:{ // 请求通讯录权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeContact complete:^(LJKitAuthorizationStatus status) {
                        
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                        
                        // 刷新数据
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                        
                    }];
                    break;
                }
                case 5:{ // 请求麦克风权限
                    [LJAuthorizationManager requestAuthorizationStateWithType:LJKitAuthorizationTypeMicroPhone complete:^(LJKitAuthorizationStatus status) {
                        
                        NSString *result = [self formatStringWithStatu:status];
                        NSLog(@"请求结果:result = %@",result);
                        
                        // 刷新数据
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                        
                    }];
                    break;
                }
                
                    
                default:
                    break;
            }
            
            
        }];
        [alertVC addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}




#pragma mark - 权限状态文字描述
- (NSString *)formatStringWithStatu:(LJKitAuthorizationStatus)statu {
    NSString *statuString = @"设备不支持";
    switch (statu) {
        case LJKitAuthorizationStatusUnknown:
            statuString = @"设备不支持";
            break;
        case LJKitAuthorizationStatusNotDetermined:
            statuString = @"用户尚未选择";
            break;
        case LJKitAuthorizationStatusDenied:
            statuString = @"用户已拒绝";
            break;
        case LJKitAuthorizationStatusAuthorized:
            statuString = @"用户已允许";
            break;
        case LJKitAuthorizationStatusRestricted:
            statuString = @"用户没有权限(家长控制)";
            break;
        case LJKitAuthorizationStatusNotRestricted:
            statuString = @"不受限制";
            break;
        case LJKitAuthorizationStatusProvisional:
            statuString = @"用户一次性允许(下次使用还会询问)";
            break;
        case LJKitAuthorizationStatusLocationWhen:
            statuString = @"允许使用时定位";
            break;
        case LJKitAuthorizationStatusLocationAlways:
            statuString = @"允许持续定位";
            break;
            
        default:
            break;
    }
    return statuString;
}



@end
