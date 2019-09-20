//
//  LJExceptionManager.h
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJExceptionManager : NSObject

/** 异常路径 */
@property (nonatomic, copy) NSString *errorLogPath;

+(instancetype)sharedManager;

/**
 开始捕获异常
 */
+ (void)startCaught;
@end

NS_ASSUME_NONNULL_END
