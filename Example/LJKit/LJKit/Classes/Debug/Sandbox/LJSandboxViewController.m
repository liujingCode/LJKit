//
//  LJSandboxViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJSandboxViewController.h"
#import "LJSandboxHomeController.h"

@interface LJSandboxViewController ()

@end

@implementation LJSandboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    if (self = [super initWithRootViewController:[LJSandboxHomeController new]]) {
    }
    return self;
}

@end
