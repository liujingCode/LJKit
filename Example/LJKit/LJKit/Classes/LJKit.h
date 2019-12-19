////  LJKit.h
//  LJKit
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#ifndef LJKit_h
#define LJKit_h


#pragma mark - 宏定义
// 如果用NSlog会打印不全
#ifdef DEBUG // 调试状态, 打开LOG功能
#define LJKitLog(format, ... ) printf("文件: <%p %s(行号:%d) > 方法: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else// 发布状态, 关闭LOG功能
#define LJKitLog(format, ... )
#endif


// 分类相关
#import "LJCategory.h"

// 工具类

// 调试

#endif /* LJKit_h */
