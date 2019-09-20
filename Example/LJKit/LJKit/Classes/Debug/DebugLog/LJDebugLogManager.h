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
@property (nonatomic, copy) NSString *filePath;
+ (instancetype)sharedManager;
+ (void)show;
+ (void)dismiss;
@end

NS_ASSUME_NONNULL_END
