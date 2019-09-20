//
//  LJExceptionManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//




#import "LJExceptionManager.h"
#import "LJCrashAlertView.h"
// 其他sdk注册的crash收集
NSUncaughtExceptionHandler *oldHandler = nil;
@interface LJExceptionManager ()
/** 展示弹框 */
@property (nonatomic, assign) BOOL showingAlert;
@end

@implementation LJExceptionManager
+ (instancetype)sharedManager {
    static LJExceptionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJExceptionManager new];
    });
    return instance;
}

+ (void)startCaught {
    if (NSGetUncaughtExceptionHandler() != LJKit_uncaughtExceptionHandler) {
        oldHandler = NSGetUncaughtExceptionHandler();
    }
    NSSetUncaughtExceptionHandler(&LJKit_uncaughtExceptionHandler);
}

#pragma mark - 处理异常
+ (void)setupException:(NSException *)exception {
    // 时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 异常时间
    NSString *exceptionDate = [dateFormatter stringFromDate:date];
    
    // 异常名
    NSString *name = exception.name;
    // 原因
    NSString *reason = exception.reason;
    // 堆栈信息
    NSArray *stackInfo = [exception callStackSymbols];
    NSString *crashInfo = [NSString stringWithFormat:@"====LJKit_异常报告====\n异常时间:%@\n异常名称:%@\n异常原因:%@\n堆栈信息:%@",exceptionDate,name,reason,stackInfo];
    NSLog(@"%@",crashInfo);
    
    
    // 文件夹名称
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *folderName = [dateFormatter stringFromDate:date];
    // 文件名称
    dateFormatter.dateFormat = @"hh_mm_ss";
    
    NSString *fileName = [NSString stringWithFormat:@"error_%@.txt",[dateFormatter stringFromDate:date]];
    
    
    
    
    LJExceptionManager *manager = [LJExceptionManager sharedManager];
    manager.showingAlert = YES;

    
    LJCrashAlertView *alertView = [[LJCrashAlertView alloc] init];
    alertView.crashInfo = crashInfo;
    alertView.actionCallback = ^(NSInteger index) {
        
        if (index == 0) { // 点了第一个
            manager.showingAlert = NO;
            return;
        }
        if (index == 1) { // 点了分享
            
            return;
        }
        if (index == 2) { // 点了继续操作
//            [alertView removeFromSuperview];
            return;
        }
        if (index == 3) { // 点击了取消
            return ;
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    

    

    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);

    while (manager.showingAlert) {
        //点击继续
        for (NSString *mode in (__bridge NSArray *)allModes) {
            //快速切换Mode
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }

    //点击退出
    CFRelease(allModes);
}


- (void)writefile:(NSString *)string
{
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *homePath = [paths objectAtIndex:0];
    
    NSString *filePath = [homePath stringByAppendingPathComponent:@"testfile.text"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        NSString *str = @"姓  名/手  机  号/邮  件";
        [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    
    [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *str = [NSString stringWithFormat:@"\n%@\n%@",datestr,string];
    
    NSData* stringData  = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileHandle writeData:stringData]; //追加写入数据
    
    [fileHandle closeFile];
}


- (NSString *)errorLogPath {
    if (!_errorLogPath) {
        _errorLogPath =  [[NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject]  stringByAppendingPathComponent:@"LJKit_error_log"];
    }
    return _errorLogPath;
}

#pragma mark - 异常回调
/**
 异常回调
 
 @param exception 异常
 */
void LJKit_uncaughtExceptionHandler(NSException *exception){
    [LJExceptionManager setupException:exception];
    
    // 处理完成后调用其他sdk的handler
    if (oldHandler) {
        oldHandler(exception);
    }
}
@end
