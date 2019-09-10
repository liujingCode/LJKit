//
//  UIAppDelegate.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "UIAppDelegate.h"
#import "LJDemoHomeViewController.h"

@implementation UIAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LJDemoHomeViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
