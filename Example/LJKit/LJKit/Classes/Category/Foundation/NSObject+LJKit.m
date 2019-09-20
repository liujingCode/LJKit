//
//  NSObject+LJKit.m
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "NSObject+LJKit.h"

@implementation NSObject (LJKit)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (NSString *)lj_methodListWithContainSuperClass:(BOOL)isContain {
    NSString *selectorString = isContain?@"_methodDescription":@"_shortMethodDescription";
    return [self performSelector:NSSelectorFromString(selectorString)];
}
- (NSString *)lj_ivarList {
    return [self performSelector:NSSelectorFromString(@"_ivarDescription")];
}
#pragma clang diagnostic pop

@end
