////  LJPermissionsManager.m
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import "LJPermissionsManager.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
@implementation LJPermissionsManager
+ (void)lj_locationPermissionsWithCallback:(LJPermissionsCallback)callback {
    BOOL isOpen = NO;
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        isOpen = YES;
    }
    if (callback) {
        callback(isOpen);
    }
}

+ (void)lj_cameraPermissionsWithCallback:(LJPermissionsCallback)callback {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (callback) {
                callback(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        callback(NO);
    } else {
        callback(YES);
    }
}
@end
