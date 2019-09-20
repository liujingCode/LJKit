//
//  UIAppDelegate.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "UIAppDelegate.h"
#import "LJDemoHomeViewController.h"
#import "LJDebugLogManager.h"
#import "LJExceptionManager.h"

@implementation UIAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LJDemoHomeViewController new]];
    [self.window makeKeyAndVisible];
    
    NSLog(@"NSLog = didFinishLaunchingWithOptions");
    
//    NSString *filePath = [LJDebugLogManager sharedManager].filePath;
//
//    // 先删除已经存在的文件
//    NSFileManager *defaultManager = [NSFileManager defaultManager];
//    [defaultManager removeItemAtPath:filePath error:nil];
//    // 将log输入到文件
//    freopen([filePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
//    freopen([filePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);

    
//    [LJExceptionManager startCaught];
    return YES;
}



@end
