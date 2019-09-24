//
//  LJLocationManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJLocationManager.h"
#import <MapKit/MapKit.h>
@interface LJLocationManager ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
/// 定位完成后的回调
@property (nonatomic, copy) LJLocationCompleteCallback completeCallback;
/// 地理编码的回调
@property (nonatomic, copy) LJLocationGeocoderCallback geocoderCallback;
@end

@implementation LJLocationManager

+ (instancetype)sharedInstance {
    static LJLocationManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJLocationManager new];
    });
    return instance;
}
// 定位
+ (void)locationWithCompleteCallback:(LJLocationCompleteCallback)completeCallback {
    [self locationWithCompleteCallback:completeCallback andGeocoderCallback:nil];
}
// 定位并且反地理编码
+ (void)locationWithCompleteCallback:(LJLocationCompleteCallback)completeCallback andGeocoderCallback:(LJLocationGeocoderCallback)geocoderCallback {
        LJLocationManager *manager = [LJLocationManager sharedInstance];
    manager.completeCallback = completeCallback;
    manager.geocoderCallback = geocoderCallback;
    
    // 判断定位权限
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse
        || status == kCLAuthorizationStatusAuthorizedAlways) {// 已经允许授权
        [manager.locationManager startUpdatingLocation];
        return;
    } else if (status == kCLAuthorizationStatusDenied) { // 拒绝授权
        // 拒绝授权
        [manager showAuthSetting];
        return;
    } else if (status == kCLAuthorizationStatusNotDetermined) { // 还未做出选择
        [manager.locationManager startUpdatingLocation];
    }
}

+ (void)geocoderWithAddressString:(NSString *)addressString andCompletionHandler:(CLGeocodeCompletionHandler)completionHandler {
   
    [[CLGeocoder new] geocodeAddressString:addressString completionHandler:completionHandler];
}

#pragma mark - 跳转到权限设置页面
- (void)showAuthSetting {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    // 无权限
    NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
    
    NSString *message = [NSString stringWithFormat:@"请在设置中打开%@的位置使用权限",appName];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(DISPATCH_TIME_NOW + 0.2, dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    
    [[LJLocationManager lj_rootViewController] presentViewController:alertVC animated:NO completion:nil];
}


#pragma mark - 停止定位
+ (void)stopLocation {
    [[LJLocationManager sharedInstance].locationManager stopUpdatingLocation];
    [LJLocationManager sharedInstance].locationManager = nil;
}

#pragma mark - CLLocationManagerDelegate
/// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.firstObject;
    // 停止定位
    [LJLocationManager stopLocation];
    
    if ([LJLocationManager sharedInstance].completeCallback) {
        [LJLocationManager sharedInstance].completeCallback(YES,location,nil);
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
        CLPlacemark *placemark = array.firstObject;
        if ([LJLocationManager sharedInstance].geocoderCallback) {
            [LJLocationManager sharedInstance].geocoderCallback(error?NO:YES,placemark,error);
        }
    }];
}



/// 定位失败回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    switch([error code]) {
        case kCLErrorDenied: { // 用户禁止了定位权限
           
        } break;
        default: break;
    }
    // 停止定位
    [LJLocationManager stopLocation];
    if ([LJLocationManager sharedInstance].completeCallback) {
        [LJLocationManager sharedInstance].completeCallback(NO,nil,error);
    }
    if ([LJLocationManager sharedInstance].geocoderCallback) {
        [LJLocationManager sharedInstance].geocoderCallback(NO,nil,error);
    }
}

/// 权限发生改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied: {

            
        }
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            [self.locationManager startUpdatingLocation];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 获取根控制器
+ (UIViewController *)lj_rootViewController {
    UIViewController *VC = [UIApplication sharedApplication].delegate.window.rootViewController;
    return VC;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

@end

#pragma mark - 第三方导航
/// 导航
@implementation LJLocationManager (LJMapNavigation)

+ (void)showMapNavigationWithCoordinate:(CLLocationCoordinate2D)coordinate andAddressName:(NSString *)addressName {
    // app信息
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
    
    //支持的地图
    NSMutableArray *maps = [NSMutableArray array];

    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];

    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        /*
         详细参数: https://lbsyun.baidu.com/index.php?title=uri/api/ios
         */
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=name:%@|latlng:%f,%f&mode=driving&coord_type=gcj02",addressName,coordinate.latitude,coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        /*
        详细参数: https://lbs.amap.com/api/amap-mobile/guide/ios/ios-uri-information
        */
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://viewMap?sourceApplication=%@&poiname=%@&lat=%f&lon=%f&dev=1",appName,addressName,coordinate.latitude,coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    // 选择
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSInteger index = maps.count;
    for (int i = 0; i < index; i++) {
        NSString * title = maps[i][@"title"];
        //苹果原生地图方法
        if (i == 0) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMapWithCoordinate:coordinate andAddressName:addressName];
            }];
            [alert addAction:action];
            continue;
        }
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = maps[i][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alert addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    [[self lj_rootViewController] presentViewController:alert animated:YES completion:nil];
}

// 苹果地图
+ (void)navAppleMapWithCoordinate:(CLLocationCoordinate2D)coordinate andAddressName:(NSString *)addressName {
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:coordinate addressDictionary:nil] ];
    toLocation.name = addressName;
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

@end
