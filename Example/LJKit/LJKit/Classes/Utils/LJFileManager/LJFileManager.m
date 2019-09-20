//
//  LJFileManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJFileManager.h"

@implementation LJFileManager
// 获取根目录
+ (NSString *)getRootPath {
    return NSHomeDirectory();
}
// 获取Document路径
+ (NSString *)getDocumentPath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [filePaths objectAtIndex:0];
}
// 获取Library路径
+ (NSString *)getLibraryPath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [filePaths objectAtIndex:0];
}
// 获取Cache路径
+ (NSString *)getCachePath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [filePaths objectAtIndex:0];
}
// 获取Temp路径
+ (NSString *)getTempPath {
    return NSTemporaryDirectory();
    
}

// 判断文件或文件夹是否存在
+ (BOOL)fileIsExistOfPath:(NSString *)filePath {
    
    BOOL flag = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        
        flag = YES;
        
    } else {
        
        flag = NO;
        
    }
    return flag;
}

// 创建文件夹
- (BOOL)createFolderWithName:(NSString *)name {
    if (name.length == 0) {
        return NO;
    }
    
    NSString *folderPath = [[LJFileManager getCachePath] stringByAppendingPathComponent:name];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir = YES;
    // 是否是一个有效的文件夹
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if (!existed) {
        return NO;
    }
    NSError *error;
    [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

// 在指定文件夹下创建文件
- (void)createFileWithFolderName:(NSString *)folderName andFileName:(NSString *)fielName {
    NSString * docsdir = [LJFileManager getCachePath];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:folderName];//将需要创建的串拼接到后面
    NSString * dataFilePath = [docsdir stringByAppendingPathComponent:fielName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL dataIsDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    BOOL dataExisted = [fileManager fileExistsAtPath:dataFilePath isDirectory:&dataIsDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (!(dataIsDir == YES && dataExisted == YES) ) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
@end
