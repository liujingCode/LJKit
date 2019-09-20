//
//  LJClassViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/12.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJClassViewController.h"
#import "LJClassHomeController.h"

@interface LJClassViewController ()

@end

@implementation LJClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)init {
    if (self = [super initWithRootViewController:[LJClassHomeController new]]) {
        
    }
    return self;
}

@end
