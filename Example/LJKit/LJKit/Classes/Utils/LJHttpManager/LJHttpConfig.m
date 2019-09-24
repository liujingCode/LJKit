//
//  LJHttpConfig.m
//  LJKit_Example
//
//  Created by developer on 2019/9/24.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJHttpConfig.h"

@implementation LJHttpConfig
+ (instancetype)sharedInstance {
    static LJHttpConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJHttpConfig new];
        instance.timeoutInterval = 20.0;
    });
    return instance;
}
@end
