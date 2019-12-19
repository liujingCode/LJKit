//
//  LJDemoScanController.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoScanController.h"
#import "LJScanViewController.h"

@interface LJCustomScanViewController : LJScanViewController
/// 闪光灯
@property (nonatomic, weak) UIButton *torchBtn;
@end

@implementation LJCustomScanViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    self.torchBtn.frame = CGRectMake(CGRectGetMinX(self.scanRect), CGRectGetMaxY(self.scanRect) + 10, 80, 44);
}

- (void)clickTorchBtn:(UIButton *)sender {
    self.torch = !self.torch;
}

- (CGRect)scanRect {
    CGFloat width = 200;
    CGFloat height = width;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) * 0.5;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
    return CGRectMake(x, y, width, height);
}

- (UIButton *)torchBtn {
    if (!_torchBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickTorchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"闪光灯" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        [self.view addSubview:btn];
        _torchBtn = btn;
    }
    return _torchBtn;
}
@end


@interface LJDemoScanController ()

@end

@implementation LJDemoScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"仿微信扫描",@"仿支付宝扫描",@"生成二维码"];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        LJCustomScanViewController *scanVC = [LJCustomScanViewController new];
        [self.navigationController pushViewController:scanVC animated:YES];
    } else if (row == 1) {
        LJCustomScanViewController *scanVC = [LJCustomScanViewController new];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}


@end
