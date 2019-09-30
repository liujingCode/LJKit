//
//  LJDemoAnimationController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/29.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoAnimationController.h"
#import "LJAnimationView.h"
#import "CustomView.h"

@interface LJDemoAnimationController ()

@end

@implementation LJDemoAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIView *targetView;
    
    // svgView
    LJAnimationView *svgView = [[LJAnimationView alloc]init];
    
    
    // animationView
    CustomView *animationView = [[CustomView alloc]init];
    
    targetView = animationView;
    
    
    CGFloat width = self.view.bounds.size.width - (10 * 2);
    targetView.frame = CGRectMake(0, 0,width,width);
    targetView.backgroundColor = [UIColor whiteColor];
    targetView.center = self.view.center;
    [self.view addSubview:targetView];
    
    
    
    [animationView addUntitled1Animation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
