////  LJPermissionsManager.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 权限验证的回调

 @param isOpen YES 允许; NO 不允许
 */
typedef void(^LJPermissionsCallback)(BOOL isOpen);

/**
 用户权限管理类
 */
@interface LJPermissionsManager : NSObject

/**
 验证是否允许使用定位功能
 @param callback 验证结果的回调
 */
+ (void)lj_locationPermissionsWithCallback:(LJPermissionsCallback)callback;

/**
 验证是否允许使用相机
 @param callback 验证结果的回调
 */
+ (void)lj_cameraPermissionsWithCallback:(LJPermissionsCallback)callback;
@end

NS_ASSUME_NONNULL_END
