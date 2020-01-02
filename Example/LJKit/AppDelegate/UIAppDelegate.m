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

//#ifdef DEBUG
//#import <DoraemonKit/DoraemonManager.h>
//#import <YYDebugDatabase/DebugDatabaseManager.h>
//#endif


@implementation UIAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LJDemoHomeViewController new]];
    [self.window makeKeyAndVisible];
    
    NSLog(@"NSLog = didFinishLaunchingWithOptions");
    return YES;
}



@end
