//
//  LJDemoImageController.m
//  LJKit_Example
//
//  Created by developer on 2019/12/19.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoImageController.h"
#import "UIImage+LJKit.h"
@interface LJDemoImageController ()
/// 展示图片专用
@property (nonatomic, weak) UIImageView *showImageView;
@end

@implementation LJDemoImageController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 
    self.tableView.tableHeaderView = [self createHeadView];
    self.dataList = @[@"根据颜色生成图片",@"圆角图片",@"边框图片",@"圆角边框图片",@"生成二维码图片",@"获取app图标"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.showImageView.image = [UIImage lj_imageWithSize:CGSizeMake(100, 100) andColor:[UIColor orangeColor]];
            break;
        default:
            break;
    }
    
    self.showImageView.center = self.tableView.tableHeaderView.center;
    [self.showImageView sizeToFit];
}



- (UIView *)createHeadView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 200);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 160, 160);
    imageView.center = view.center;
    [view addSubview:imageView];
    self.showImageView = imageView;
    return view;
}


@end
