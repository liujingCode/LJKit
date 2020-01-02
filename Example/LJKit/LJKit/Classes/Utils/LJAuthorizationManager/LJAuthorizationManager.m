//
//  LJAuthorizationManager.m
//  LJKit_Example
//
//  Created by developer on 2019/12/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAuthorizationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <CoreTelephony/CTCellularData.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <CoreBluetooth/CoreBluetooth.h> 
@interface LJAuthorizationManager ()<CLLocationManagerDelegate>
/// 定位管理者
@property (nonatomic, strong) CLLocationManager *locationManager;
/// 请求定位权限的回调
@property (nonatomic, copy) LJAuthorizationRequestComplete locationRequestComplete;
/// 第一次请求定位权限
@property (nonatomic, assign) BOOL firstRequestLocationAuth;


/// 通讯录
@property (nonatomic, strong) CNContactStore *contackStore;
@end

@implementation LJAuthorizationManager


+(instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LJAuthorizationManager alloc] init];
    });
    return instance;
}



#pragma mark - 获取权限
+ (LJKitAuthorizationStatus)getAuthorizationStateWithType:(LJKitAuthorizationType)type {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    switch (type) {
        case LJKitAuthorizationTypeCamera: // 相机
            status = [self getCameraAuthorization];
            break;
        case LJKitAuthorizationTypeMediaLibrary: // 相册
            status = [self getMediaLibraryAuthorization];
            break;
        case LJKitAuthorizationTypeLocation: // 定位
            status = [self getLocationAuthorization];
            break;
        case LJKitAuthorizationTypeTelephony: // 网络
            status = [self getTelephonyAuthorization];
            break;
        case LJKitAuthorizationTypeContact: // 通讯录
            status = [self getContactAuthorization];
            break;
        case LJKitAuthorizationTypeMicroPhone: // 麦克风
            status = [self getMicroPhoneAuthorization];
            break;
        default:
            break;
    }
    return status;
}

/// 获取相机权限状态
+ (LJKitAuthorizationStatus)getCameraAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    // 相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            status = LJKitAuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}

/// 获取相册权限状态
+ (LJKitAuthorizationStatus)getMediaLibraryAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    switch (authStatus) {
        case PHAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
        case PHAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case PHAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case PHAuthorizationStatusAuthorized:
            status = LJKitAuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}

/// 获取定位权限状态
+ (LJKitAuthorizationStatus)getLocationAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    switch (authStatus) {
        case kCLAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
        case kCLAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case kCLAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            status = LJKitAuthorizationStatusLocationAlways;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            status = LJKitAuthorizationStatusLocationWhen;
            break;
        default:
            break;
    }
    return status;
}


/// 网络权限状态
+ (LJKitAuthorizationStatus)getTelephonyAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    CTCellularDataRestrictedState authStatus = cellularData.restrictedState;
    switch (authStatus) {
        case kCTCellularDataRestrictedStateUnknown:
            status = LJKitAuthorizationStatusUnknown;
            break;
        case kCTCellularDataRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case kCTCellularDataNotRestricted:
            status = LJKitAuthorizationStatusNotRestricted;
            break;
        default:
            break;
    }
    return status;
}

/// 获取通讯录权限状态
+ (LJKitAuthorizationStatus)getContactAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (authStatus) {
        case CNAuthorizationStatusAuthorized:
            status = LJKitAuthorizationStatusAuthorized;
            break;
        case CNAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case CNAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case CNAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
       }
    return status;
}

/// 获取麦克风权限状态
+ (LJKitAuthorizationStatus)getMicroPhoneAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    // 麦克风权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            status = LJKitAuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}

/// 获取蓝牙权限状态
+ (LJKitAuthorizationStatus)getBluetoothAuthorization {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    // 蓝牙权限
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    switch (authStatus) {
        case CBPeripheralManagerAuthorizationStatusNotDetermined:
            status = LJKitAuthorizationStatusNotDetermined;
            break;
        case CBPeripheralManagerAuthorizationStatusRestricted:
            status = LJKitAuthorizationStatusRestricted;
            break;
        case CBPeripheralManagerAuthorizationStatusDenied:
            status = LJKitAuthorizationStatusDenied;
            break;
        case CBPeripheralManagerAuthorizationStatusAuthorized:
            status = LJKitAuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}




#pragma mark - 请求权限
+ (void)requestAuthorizationStateWithType:(LJKitAuthorizationType)type complete:(LJAuthorizationRequestComplete)complete {
    switch (type) {
        case LJKitAuthorizationTypeCamera:
            [self requestCameraAuthorizationWithComplete:complete];
            break;
        case LJKitAuthorizationTypeMediaLibrary:
            [self requestMediaLibraryAuthorizationWithComplete:complete];
            break;
        case LJKitAuthorizationTypeLocation:
            [self requestLocationAuthorizationWithComplete:complete];
            break;
        case LJKitAuthorizationTypeTelephony:
            [self requestTelephonyAuthorizationWithComplete:complete];
            break;
        case LJKitAuthorizationTypeContact:
            [self requestContactAuthorizationWithComplete:complete];
            break;
        case LJKitAuthorizationTypeMicroPhone:
            [self requestMicroPhoneAuthorizationWithComplete:complete];
            break;
        default:
            break;
    }
}

/// 请求相册权限
+ (void)requestMediaLibraryAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        LJKitAuthorizationStatus customStatus;
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
                customStatus = LJKitAuthorizationStatusNotDetermined;
                break;
            case PHAuthorizationStatusRestricted:
                customStatus = LJKitAuthorizationStatusRestricted;
                break;
            case PHAuthorizationStatusDenied:
                customStatus = LJKitAuthorizationStatusDenied;
                break;
            case PHAuthorizationStatusAuthorized:
                customStatus = LJKitAuthorizationStatusAuthorized;
                break;
            default:
                break;
        }
        complete(customStatus);
    }];
}

/// 请求相机权限
+ (void)requestCameraAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
   
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        LJKitAuthorizationStatus customStatus = granted?LJKitAuthorizationStatusAuthorized:LJKitAuthorizationStatusDenied;
        complete(customStatus);
    }];
}

/// 请求定位权限
+ (void)requestLocationAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
    LJAuthorizationManager *manager = [LJAuthorizationManager sharedManager];
    manager.locationRequestComplete = complete;
    manager.firstRequestLocationAuth = YES;
    if (!manager.locationManager) {
        manager.locationManager = [[CLLocationManager alloc] init];
        manager.locationManager.delegate = manager;
    }
    [manager.locationManager requestAlwaysAuthorization];
}


/// 请求网络权限
+ (void)requestTelephonyAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
}


/// 请求通讯录权限
+ (void)requestContactAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
    LJAuthorizationManager *manager = [LJAuthorizationManager sharedManager];
    if (!manager.contackStore) {
        manager.contackStore = [[CNContactStore alloc] init];
    }
    [manager.contackStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        manager.contackStore = nil;
        LJKitAuthorizationStatus customStatus = granted?LJKitAuthorizationStatusAuthorized:LJKitAuthorizationStatusDenied;
        complete(customStatus);
    }];
}


/// 请求麦克风权限
+ (void)requestMicroPhoneAuthorizationWithComplete:(LJAuthorizationRequestComplete)complete {
   
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        LJKitAuthorizationStatus customStatus = granted?LJKitAuthorizationStatusAuthorized:LJKitAuthorizationStatusDenied;
        complete(customStatus);
    }];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (([LJAuthorizationManager getLocationAuthorization] == LJKitAuthorizationStatusNotDetermined) && (self.firstRequestLocationAuth == YES)) {
        return;
    }
    LJAuthorizationManager *sharedManager = [LJAuthorizationManager sharedManager];
    LJKitAuthorizationStatus authStatus;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            authStatus = LJKitAuthorizationStatusLocationWhen;
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            authStatus = LJKitAuthorizationStatusLocationAlways;
            break;
        case kCLAuthorizationStatusDenied:
            authStatus = LJKitAuthorizationStatusDenied;
            break;
        case kCLAuthorizationStatusRestricted:
            authStatus = LJKitAuthorizationStatusRestricted;
            break;
        case kCLAuthorizationStatusNotDetermined:{
            authStatus = LJKitAuthorizationStatusNotDetermined;
            if (self.firstRequestLocationAuth == YES) {
                self.firstRequestLocationAuth = NO;
            }
        }
            
            break;
        default:
               break;
       }
    if (sharedManager.locationRequestComplete) {
        sharedManager.locationRequestComplete(authStatus);
    }
    [sharedManager.locationManager stopUpdatingLocation];
    sharedManager.locationManager.delegate = nil;
    sharedManager.locationManager = nil;
    sharedManager.locationRequestComplete = nil;
    sharedManager.firstRequestLocationAuth = NO;
}

@end
