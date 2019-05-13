////  LJLocationManager.m
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import "LJLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface LJLocationManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (copy, nonatomic) void (^callback) (LJLocationModel *model);
@end
@implementation LJLocationManager

+ (LJLocationManager *)sharedManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)lj_startLoactionWithCallback:(void (^) (LJLocationModel *model))callback {
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //获取CLLocation对象
    CLLocation *loc = [locations firstObject];
    CLLocationCoordinate2D coord = loc.coordinate;
    
    //反地理编码
    [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error || placemarks.count == 0) {
//            self->_currentCity = @"无法定位到您的位置，请尝试手动选择";
        }else{
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            NSString *address = firstPlacemark.name;
            NSString *country = firstPlacemark.country;
            NSString *province = firstPlacemark.administrativeArea;
            // NSString *subAdministrativeArea = firstPlacemark.subAdministrativeArea;
            NSString *city = firstPlacemark.locality;
            NSString *district = firstPlacemark.subLocality;
            //NSString *thoroughfare = firstPlacemark.thoroughfare;
            //NSString *subThoroughfare = firstPlacemark.subThoroughfare;
            
            if (self.callback) {
//                self.block(country, province, city, district, address, coord.latitude, coord.longitude);
            }
        }
    }];
//    //停止更新位置
//    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {

        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied: {

//            if (self.status) {
//                self.status(NO);
//            }
        }
            break;

        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
//            if (self.status) {
//                self.status(YES);
//            }
            break;

        default:
            break;
    }
}

#pragma mark - 懒加载
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        CLLocationManager *manager = [[CLLocationManager alloc]init];
        manager.delegate = self;
        manager.distanceFilter=kCLDistanceFilterNone;
        manager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        _locationManager = manager;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
@end
