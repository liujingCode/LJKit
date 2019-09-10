//
//  LJTabBarController.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import "LJTabBarController.h"
#import "LJHomeViewController.h"
#import "LJDiscoverViewController.h"
#import "LJMineViewController.h"

#import "LJTabBarItem.h"

@interface LJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LJTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    
    
    LJHomeViewController *homeVC = [LJHomeViewController new];
    LJDiscoverViewController *discoverVC = [LJDiscoverViewController new];
    LJMineViewController *mineVC = [LJMineViewController new];
    
    
    NSArray *childViewControllers = @[homeVC,discoverVC,mineVC];
    NSArray *titles = @[@"首页",@"发现",@"我的"];
    NSArray *imageNames = @[@"",@"",@""];
    NSArray *selectedImageNames = @[@"",@"",@""];
    
    for (int i = 0; i < childViewControllers.count; i ++) {
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageNames[i]];
        LJTabBarItem *tabBarItem = [[LJTabBarItem alloc] initWithTitle:titles[i] image:image selectedImage:selectedImage];
        ((UIViewController *)childViewControllers[i]).tabBarItem = tabBarItem;
    }
    self.viewControllers = childViewControllers;
    
    // 初始化
    self.selectedIndex = 0;
    [self.delegate tabBarController:self didSelectViewController:childViewControllers.firstObject];
}


#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.title = viewController.title;
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
}
@end
