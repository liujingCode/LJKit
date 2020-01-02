//
//  LJDebugLogManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDebugLogManager.h"
#import "LJDebugLogView.h"
#import "LJClassViewController.h"
#import "LJSandboxViewController.h"
#import <GCDWebUploader.h>

@interface LJDebugLogManager ()
/** 定时器 */
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, weak) LJDebugLogView *logView;
/// 局域网操作沙盒
@property (nonatomic, strong) GCDWebUploader *uploader;

@end

@implementation LJDebugLogManager

static LJDebugLogManager *instance;
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJDebugLogManager new];
        // app从后台进入前台都会调用这个方法
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        // 添加检测app进入后台的观察者
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return instance;
}


#pragma mark - set方法
- (void)setEnableSandBoxLocalNetwork:(BOOL)enableSandBoxLocalNetwork {
    _enableSandBoxLocalNetwork = enableSandBoxLocalNetwork;
    if (enableSandBoxLocalNetwork) {
        [self showSandBoxWithLocalNetwork];
    } else {
        [self.uploader stop];
        self.uploader = nil;
    }
}

- (void)setEnableSaveLogToLocal:(BOOL)enableSaveLogToLocal {
    _enableSaveLogToLocal = enableSaveLogToLocal;
    if (enableSaveLogToLocal) {
        saveLogToLocal();
    } else {
        // 恢复重定向
        int dupValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"dup"] intValue];
        dup2(dupValue, STDERR_FILENO);
    }
}

- (void)setEnableLiveLog:(BOOL)enableLiveLog {
    _enableLiveLog = enableLiveLog;
    if (enableLiveLog) {
        if (!self.enableSaveLogToLocal) {
            saveLogToLocal();
        }
        [self logView];
        [self displayLink];
    } else {
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.logView removeFromSuperview];
        self.logView = nil;
    }
}


- (void)updateLog {
    NSString *logsPath = getLogsPath();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *logNames = [fileManager contentsOfDirectoryAtPath:logsPath error:nil];
    NSString *logPath = [NSString stringWithFormat:@"%@/%@",logsPath,logNames.lastObject];
    NSString *logString = [NSString stringWithContentsOfFile:logPath encoding:NSUTF8StringEncoding error:nil];
    self.logView.logStr = logString;
}



- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLog)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink = displayLink;
    }
    return _displayLink;
}

/// 展示沙盒
+ (void)showSandBox {
    LJSandboxViewController *VC = [LJSandboxViewController new];
    [findViewControllerInStack() presentViewController:VC animated:YES completion:nil];
}

/// 在局域网展示沙盒
- (void)showSandBoxWithLocalNetwork {
    LJDebugLogManager *manager = [LJDebugLogManager sharedManager];
    [manager.uploader start];
    
    
    NSString *address = [NSString stringWithFormat:@"%@",manager.uploader.serverURL];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"请在局域网访问沙盒,地址为:%@",address] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"复制地址" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard * Pasteboard=[UIPasteboard generalPasteboard];
        Pasteboard.string = address;
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:copyAction];
    [findViewControllerInStack() presentViewController:alertVC animated:YES completion:nil];
}

/// 展示类属性和方法
+ (void)showClassDetail {
    LJClassViewController *VC = [LJClassViewController new];
    [findViewControllerInStack() presentViewController:VC animated:YES completion:nil];
}

/**
 查找栈中的当前控制器
 */
UIViewController *findViewControllerInStack () {
    UIViewController *currVC = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)rootVC;
            UIViewController *v = [nav.viewControllers lastObject];
            currVC = v;
            rootVC = v.presentedViewController;
            continue;
        } else if ([rootVC isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            currVC = tabVC;
            rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (rootVC != nil);
    
    return currVC;
}





#pragma mark - 通知
/// 已经进入后台的通知
- (void)applicationEnterBackground{
    [[LJDebugLogManager sharedManager].uploader stop];
    [LJDebugLogManager sharedManager].uploader = nil ;
}

///// 即将进入前台的通知
//- (void)applicationBecomeActive{
//    [[LJDebugLogManager sharedManager].uploader start];
//    
//}




- (GCDWebUploader *)uploader {
    if (!_uploader) {
        _uploader = [[GCDWebUploader alloc] initWithUploadDirectory:NSHomeDirectory()];;
    }
    return _uploader;
}
- (LJDebugLogView *)logView {
    if (!_logView) {
        LJDebugLogView *logView = [[LJDebugLogView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        [[UIApplication sharedApplication].delegate.window addSubview:logView];
        _logView = logView;
    }
    return _logView;
}





#pragma mark - 获取log日志的路径
/// 获取log日志的路径
NSString * getLogsPath () {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES).firstObject;
    return [NSString stringWithFormat:@"%@/Logs",cachePath];
}

/// 保存log到本地
void saveLogToLocal () {
    NSString *logsPath = getLogsPath();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logsPath];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logsPath  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logsPath stringByAppendingFormat:@"/%@.txt",dateStr];
    
    
    // 重定向
    int value = dup(STDERR_FILENO);
    [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:@"dup"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    //未捕获的Objective-C异常日志
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}


/// 自定义crash的回调
void UncaughtExceptionHandler(NSException* exception){
    NSString* name = [exception name ];
    NSString* reason = [exception reason ];
    NSArray* symbols = [exception callStackSymbols];
    //异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ];
    //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [strSymbols appendString: item ];
        [strSymbols appendString: @"\r\n" ];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES).firstObject;
    NSString *logsPath = [NSString stringWithFormat:@"%@/Logs",cachePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logsPath]) {
        [fileManager createDirectoryAtPath:logsPath  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logsPath stringByAppendingPathComponent:@"UncaughtException.txt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
}
@end
