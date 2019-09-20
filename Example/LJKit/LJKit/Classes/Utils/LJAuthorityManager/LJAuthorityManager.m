//
//  LJAuthorityManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/20.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAuthorityManager.h"

@implementation LJAuthorityManager
+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
@end
