//
//  LJDebugLogManager.h
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJDebugLogManager : NSObject
/// logs文件夹路径
@property (nonatomic, copy) NSString *localLogsPath;

/// 开启局域网沙盒
@property (nonatomic, assign) BOOL enableSandBoxLocalNetwork;

/// 开启实时log
@property (nonatomic, assign) BOOL enableLiveLog;

/// 开启log写入沙盒
@property (nonatomic, assign) BOOL enableSaveLogToLocal;


+ (instancetype)sharedManager;
/// 展示沙盒
+ (void)showSandBox;
/// 展示类属性和方法
+ (void)showClassDetail;
@end

NS_ASSUME_NONNULL_END
