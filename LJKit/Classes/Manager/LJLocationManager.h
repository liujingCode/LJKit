////  LJLocationManager.h
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 位置信息模型
 */
@interface LJLocationModel : NSObject

@end

/**
 定位管理类
 */
@interface LJLocationManager : NSObject
+ (LJLocationManager *)sharedManager;
- (void)lj_startLoactionWithCallback:(void (^) (LJLocationModel *model))callback;
@end

NS_ASSUME_NONNULL_END
