//
//  LJSandboxModel.h
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 文件类型

 - LJSandboxModelTypeRootDirectory: 根目录
 - LJSandboxModelTypeSubDirectory: 子目录
 - LJSandboxModelTypeFile: 文件
 */
typedef NS_ENUM(NSInteger, LJSandboxModelType) {
    LJSandboxModelTypeRootDirectory = 0,
    LJSandboxModelTypeSubDirectory,
    LJSandboxModelTypeFile,
};
@interface LJSandboxModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) LJSandboxModelType type;
@end

NS_ASSUME_NONNULL_END
