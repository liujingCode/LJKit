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
NotDetermined  用户尚未做出选择
Denied         用户已拒绝
Restricted     用户没有权限(家长控制)
Authorized     用户已允许
Provisional    临时授权
*/

typedef NS_ENUM(NSUInteger, LJKitAuthorizationStatus) {
    LJKitAuthorizationStatusNotDetermined = 0,
    LJKitAuthorizationStatusDenied,
    LJKitAuthorizationStatusAuthorized,
    LJKitAuthorizationStatusRestricted,
    LJKitAuthorizationStatusProvisional,
};

/**
 相机
 相册的读取和写入
 一次性定位
 持续定位
 无线数据(wifi或蜂窝网络)
 通讯录
 麦克风
 蓝牙
 */
typedef NS_ENUM(NSUInteger, LJKitAuthorizationType) {
    LJKitAuthorizationTypeCamera,
    LJKitAuthorizationTypeMediaLibrary,
    LJKitAuthorizationTypeLocationAlways,
    LJKitAuthorizationTypeLocationWhen
};

// 权限发生改变的通知


/// 权限管理类
@interface LJAuthorizationManager : NSObject




/// 展示用户已拒绝授权的弹框
- (void)showDenied;

+ (LJKitAuthorizationStatus)getAuthorizationStateWithType:(LJKitAuthorizationType)type;
@end

NS_ASSUME_NONNULL_END
