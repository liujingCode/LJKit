//
//  LJFileManager.h
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJFileManager : NSObject
// 获取根目录
+ (NSString *)getRootPath;
// 获取Document路径
+ (NSString *)getDocumentPath;
// 获取Library路径
+ (NSString *)getLibraryPath;
// 获取Cache路径
+ (NSString *)getCachePath;
// 获取Temp路径
+ (NSString *)getTempPath;
// 判断文件或文件夹是否存在
+ (BOOL)fileIsExistOfPath:(NSString *)filePath;

- (void)createFileWithFolderName:(NSString *)folderName andFileName:(NSString *)fielName;
@end

NS_ASSUME_NONNULL_END
