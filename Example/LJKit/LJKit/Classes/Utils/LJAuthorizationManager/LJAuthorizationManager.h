//
//  LJAuthorizationManager.h
//  LJKit_Example
//
//  Created by developer on 2019/12/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 Unknown        未知错误(例如摄像头坏了,用的模拟器)
 NotDetermined  用户尚未做出选择
 Denied         用户已拒绝
 Authorized     用户已允许
 Restricted     用户没有权限(家长控制)
 NotRestricted  不受限制
 Provisional    临时授权(仅允许这一次,下次系统还会询问)
 LocationAlways 已允许持续定位
 LocationWhen   已允许一次性定位
*/

typedef NS_ENUM(NSUInteger, LJKitAuthorizationStatus) {
    LJKitAuthorizationStatusUnknown = 0,
    LJKitAuthorizationStatusNotDetermined,
    LJKitAuthorizationStatusDenied,
    LJKitAuthorizationStatusAuthorized,
    LJKitAuthorizationStatusRestricted,
    LJKitAuthorizationStatusNotRestricted,
    LJKitAuthorizationStatusProvisional,
    LJKitAuthorizationStatusLocationAlways,
    LJKitAuthorizationStatusLocationWhen,
};

/**
 Camera         相机
 MediaLibrary   相册
 Location       定位
 Telephony      网络
 Contact        通讯录
 MicroPhone     麦克风
 Bluetooth      蓝牙
 */
typedef NS_ENUM(NSUInteger, LJKitAuthorizationType) {
    LJKitAuthorizationTypeCamera,
    LJKitAuthorizationTypeMediaLibrary,
    LJKitAuthorizationTypeLocation,
    LJKitAuthorizationTypeTelephony,
    LJKitAuthorizationTypeContact,
    LJKitAuthorizationTypeMicroPhone,
    LJKitAuthorizationTypeBluetooth,
};

typedef void(^LJAuthorizationRequestComplete)(LJKitAuthorizationStatus status);

// 权限发生改变的通知


/// 权限管理类
@interface LJAuthorizationManager : NSObject

/// 展示用户已拒绝授权的弹框
- (void)showDenied;


/// 获取权限
/// @param type 权限类型
+ (LJKitAuthorizationStatus)getAuthorizationStateWithType:(LJKitAuthorizationType)type;

/// 请求权限
/// @param type 权限类型
+ (void)requestAuthorizationStateWithType:(LJKitAuthorizationType)type complete:(LJAuthorizationRequestComplete)complete;
@end

NS_ASSUME_NONNULL_END
