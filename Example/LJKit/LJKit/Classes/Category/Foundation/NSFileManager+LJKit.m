//
//  NSFileManager+LJKit.m
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "NSFileManager+LJKit.h"

@implementation NSFileManager (LJKit)
+(void)lj_createFolderWithName:(NSString *)folderName {
    NSFileManager *fileManager = [NSFileManager new];
    
    BOOL isFolder = YES;
    [fileManager fileExistsAtPath:folderName isDirectory:&isFolder];
}

+(void)lj_createFileWithName:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager new];
}
@end
