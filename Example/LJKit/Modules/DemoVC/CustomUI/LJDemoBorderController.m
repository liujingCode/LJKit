//
//  LJDemoBorderController.m
//  LJKit_Example
//
//  Created by developer on 2019/11/6.
//  Copyright © 2019 liujing. All rights reserved.
//

@interface LJDemoBorderControllerCell  : UITableViewCell

@end

@implementation LJDemoBorderControllerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    
    }
    return self;
}


@end

#import "LJDemoBorderController.h"

@interface LJDemoBorderController ()

@end

@implementation LJDemoBorderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tempView];
    
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
    
}

@end
