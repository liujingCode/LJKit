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


@interface LJAuthorizationManager ()<CLLocationManagerDelegate>

@end

@implementation LJAuthorizationManager


- (void)test {
    
}



+ (LJKitAuthorizationStatus)getAuthorizationStateWithType:(LJKitAuthorizationType)type {
    LJKitAuthorizationStatus status = LJKitAuthorizationStatusNotDetermined;
    switch (type) {
        case LJKitAuthorizationTypeCamera:
            status = [self getCameraAuthorization];
            break;
        case LJKitAuthorizationTypeMediaLibrary:
            status = [self getCameraAuthorization];
            break;
        case LJKitAuthorizationTypeLocationAlways:
            status = [self getLocationAlwaysAuthorization];
            break;
        case LJKitAuthorizationTypeLocationWhen:
            status = [self getLocationWhenAuthorization];
            break;
            
        default:
            break;
    }
    return status;
}


#pragma mark - 获取权限状态
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

// 获取相册权限状态
+ (LJKitAuthorizationStatus)getMediaLibraryAuthorization {
    return 0;
}

// 获取一次性定位权限状态
+ (LJKitAuthorizationStatus)getLocationWhenAuthorization {
    return 0;
}

// 获取持续定位权限状态
+ (LJKitAuthorizationStatus)getLocationAlwaysAuthorization {
    return 0;
}




#pragma mark - 请求权限


@end
