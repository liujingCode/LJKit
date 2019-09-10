//
//  LJRootViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import "LJRootViewController.h"
#import "LJTabBarController.h"

@interface LJRootViewController ()<UINavigationControllerDelegate>

@end

@implementation LJRootViewController
- (instancetype)init {
    if (self = [super initWithRootViewController:[self rootController] ]) {
        self.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


// 根控制器
- (UIViewController *)rootController {
    LJTabBarController *tabVC = [[LJTabBarController alloc] init];
    return tabVC;
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}



#pragma mark - 懒加载
- (LJNavigationBarContnetView *)navigationBarContnetView {
    if (!_navigationBarContnetView) {
        
        CGFloat y = -[UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
        LJNavigationBarContnetView *customView = [[LJNavigationBarContnetView alloc] initWithFrame:CGRectMake(0, y, self.navigationBar.bounds.size.width, height)];
        customView.backgroundColor = [UIColor whiteColor];
        [self.navigationBar addSubview:customView];
        _navigationBarContnetView = customView;
        
    }
    return _navigationBarContnetView;
}
@end
