//
//  LJViewController.m
//  LJKit
//
//  Created by 185704108@qq.com on 04/27/2019.
//  Copyright (c) 2019 185704108@qq.com. All rights reserved.
//

#import "LJViewController.h"

#import "LJKit.h"

@interface LJViewController ()
/** <#注释#> */
@property (strong, nonatomic) LJLocationManager *locationManager;

@end

@implementation LJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [LJLocationManager sharedManager];
    
    [self.locationManager lj_startLoactionWithCallback:^(LJLocationModel * _Nonnull model) {
        
    }];
//    [LJPermissionsManager lj_locationPermissionsWithCallback:^(BOOL isOpen) {
//        NSLog(@"isOpen == %d",isOpen);
//
//    }];
    
    
//    [LJPermissionsManager lj_cameraPermissionsWithCallback:^(BOOL isOpen) {
//        NSLog(@"isOpen == %d",isOpen);
//    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
