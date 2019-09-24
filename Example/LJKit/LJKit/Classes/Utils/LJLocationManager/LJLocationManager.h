//
//  LJLocationManager.h
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LJLocationCompleteCallback)(BOOL success, CLLocation  * _Nullable location, NSError * _Nullable error);
typedef void (^LJLocationGeocoderCallback)(BOOL success, CLPlacemark * _Nullable placemark, NSError * _Nullable error);
@interface LJLocationManager : NSObject

/// 开始定位
/// @param completeCallback 定位完成后的回调
+ (void)locationWithCompleteCallback:(LJLocationCompleteCallback)completeCallback;

/// 开始定位
/// @param completeCallback 定位完成后的回调
/// @param geocoderCallback 反地理编码完成后的回调
+ (void)locationWithCompleteCallback:(LJLocationCompleteCallback)completeCallback andGeocoderCallback:(LJLocationGeocoderCallback _Nullable)geocoderCallback;


/// 地理编码
/// @param addressString 位置名称
/// @param completionHandler 地理编码完成后的回调
+ (void)geocoderWithAddressString:(NSString *)addressString andCompletionHandler:(CLGeocodeCompletionHandler)completionHandler;
@end

/// 导航
@interface LJLocationManager (LJMapNavigation)

/// 使用第三方地图导航
/// @param coordinate 经纬度
+ (void)showMapNavigationWithCoordinate:(CLLocationCoordinate2D)coordinate andAddressName:(NSString *)addressName;
@end

NS_ASSUME_NONNULL_END
