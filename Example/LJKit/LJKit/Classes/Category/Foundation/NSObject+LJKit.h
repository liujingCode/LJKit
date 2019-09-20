//
//  NSObject+LJKit.h
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LJKit)

#pragma mark - Debug

/**
 获取当前对象所有的属性和方法

 @param isContain 是否包含父类
 @return 所有的属性和方法
 */
- (NSString *)lj_methodListWithContainSuperClass:(BOOL)isContain;

/**
 获取当前对象所有的Ivar变量

 @return 所有的Ivar变量
 */
- (NSString *)lj_ivarList;
@end

NS_ASSUME_NONNULL_END
