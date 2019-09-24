//
//  LJDemoLocationController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/24.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoLocationController.h"
#import "LJLocationManager.h"
@interface LJDemoLocationController ()
/** <#注释#> */
@property (nonatomic, copy) CLPlacemark *currentPlacemark;

@end

@implementation LJDemoLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    label.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    label.font = [UIFont systemFontOfSize:12.0];
    label.numberOfLines = 0;
    self.tableView.tableHeaderView = label;
    
    self.dataList = @[@"开始定位",@"开始定位并获取反地理编码",@"地理编码",@"第三方地图导航"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *label = (UILabel *)tableView.tableHeaderView;
    if (indexPath.row == 0) {
        [LJLocationManager locationWithCompleteCallback:^(BOOL success, CLLocation * _Nullable location, NSError * _Nullable error) {
            
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            NSString *text = [NSString stringWithFormat:@"success = %d;  longitude = %f; latitude = %f; error = %@",success,coordinate.longitude,coordinate.latitude,[error localizedDescription]];
            label.text = text;
        }];
        return;
    }
   
    if (indexPath.row == 1) {
        [LJLocationManager locationWithCompleteCallback:^(BOOL success, CLLocation * _Nullable location, NSError * _Nullable error) {
            
        } andGeocoderCallback:^(BOOL success, CLPlacemark * _Nullable placemark, NSError * _Nullable error) {
            NSString *text = [NSString stringWithFormat:@"success = %d; placemark = %@; error = %@",success,placemark,[error localizedDescription]];
            label.text = text;
        }];
        return;
    }
    
    
    if (indexPath.row == 2) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"地理编码" message:@"请输入位置的名称,如\"上海市中心大厦\"" preferredStyle:UIAlertControllerStyleAlert];
        __block UITextField *targetTextField;
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入位置名称";
            targetTextField = textField;
        }];
        
        UIAlertAction *searchAction = [UIAlertAction actionWithTitle:@"搜索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LJLocationManager geocoderWithAddressString:targetTextField.text andCompletionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                self.currentPlacemark = placemarks.firstObject;
                NSString *text = [NSString stringWithFormat:@"placemarks = %@; error = %@",placemarks.firstObject,[error localizedDescription]];
                label.text = text;
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:searchAction];
        [alertVC addAction:cancelAction];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    
    if (indexPath.row == 3) {
        if (!self.currentPlacemark) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"上文没有可以导航的位置,请先使用地理编码选择位置" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"已阅" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            return;
        }
        [LJLocationManager showMapNavigationWithCoordinate:self.currentPlacemark.location.coordinate andAddressName:self.currentPlacemark.locality];
        return;
    }
}
@end
