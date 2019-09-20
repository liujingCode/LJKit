//
//  NSFileManager+LJKit.h
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 创建文件或文件夹的模式

 - NSFileCreateModeDefault: 
 - NSFileCreateModeFolderAdd: <#NSFileCreateModeFolderAdd description#>
 - NSFileCreateModeFileAdd: <#NSFileCreateModeFileAdd description#>
 - NSFileCreateModeFolderCover: <#NSFileCreateModeFolderCover description#>
 - NSFileCreateModeFileCover: <#NSFileCreateModeFileCover description#>
 */
typedef NS_ENUM(NSUInteger, NSFileCreateMode) {
    NSFileCreateModeDefault,
    NSFileCreateModeFolderAdd,
    NSFileCreateModeFileAdd,
    NSFileCreateModeFolderCover,
    NSFileCreateModeFileCover,
};
@interface NSFileManager (LJKit)
+(void)lj_createFolderWithName:(NSString *)folderName;
+(void)lj_createFileWithName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
