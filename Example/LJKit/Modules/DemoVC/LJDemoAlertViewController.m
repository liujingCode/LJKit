//
//  LJDemoAlertViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoAlertViewController.h"
#import "LJAlertViewController.h"

#import "LJAlertCheckPwdView.h"
#import "LJDatePickerView.h"
#import "LJSliderVerifyView.h"
#import "LJGoodsSpecsView.h"

#import "LJGoodsModel.h"
#import <YYModel/YYModel.h>


/// 自定义dialog控制器
@interface LJDemoCustomAlertController : LJAlertViewController

@end

/// 滑块验证控制器
@interface LJSliderVerifyController : LJAlertViewController
@property (nonatomic, weak) LJSliderVerifyView *sliderVerifyView;
/// 验证结果的回调
@property (nonatomic, copy) void (^resultHandle) (BOOL success);
@end

@interface LJDemoAlertViewController ()

@end

@implementation LJDemoAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataList = @[@"系统dialog",@"系统actionSheet",@"自定义dialogView",@"自定义actionSheetView",@"自定义dialog控制器",@"自定义actionSheet控制器",@"自定义-方块密码输入",@"自定义-滑块验证",@"自定义-选择指定范围内的时间(10年前)",@"自定义-商品规格选择"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSLog(@"点击了 row = %ld", row);
    if (row == 0) {
        [self normalDialog];
    }
    if (row == 1) {
        [self normalActionSheet];
    }
    if (row == 2) {
        [self customDialogView];
    }
    if (row == 3) {
        [self customActionSheetView];
    }
    if (row == 4) {
        [self customDialogController];
    }
    if (row == 5) {
        [self customActionSheetController];
    }
    if (row == 6) {
        [self checkPwdAlertView];
    }
    if (row == 7) {
        [self sliderCheckAlertView];
    }
    if (row == 8) {
        [self datePickerAlertView];
    }
    if (row == 9) {
           [self goodsSpecsAlertView];
       }
}

#pragma mark - demo
- (void)normalDialog {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"翻译翻译" message:@"什么叫惊喜?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alertVC animated:YES completion:nil];
    });
}

- (void)normalActionSheet {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"挣钱" message:@"大风起兮云飞扬,安得猛士兮守四方,钱,任何时候都要挣,不挣不行,你想想,你和朋友一起出去玩,唱着火锅吃着歌,突然就没钱啦,有钱的日子,才是好日子!" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"我才是取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    [alertVC addAction:cancelAction1];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alertVC animated:YES completion:nil];
    });
   
}

- (void)customDialogView {
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor orangeColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    tempView.layer.cornerRadius = 10;
    [LJAlertViewController showWithContainerView:tempView alertStyle:UIAlertControllerStyleAlert];
}

- (void)customActionSheetView {
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor orangeColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    [LJAlertViewController showWithContainerView:tempView alertStyle:UIAlertControllerStyleActionSheet];
}

- (void)customDialogController {
    LJDemoCustomAlertController *customAlertVC = [LJDemoCustomAlertController new];
     customAlertVC.alertStyle = UIAlertControllerStyleAlert;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:customAlertVC animated:NO completion:nil];
    });
}

- (void)customActionSheetController {
    LJDemoCustomAlertController *customAlertVC = [LJDemoCustomAlertController new];
    customAlertVC.alertStyle = UIAlertControllerStyleActionSheet;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:customAlertVC animated:NO completion:nil];
    });
}

// 方块密码
- (void)checkPwdAlertView {
    LJAlertCheckPwdView *pwdView = [[LJAlertCheckPwdView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 0.8, 200)];
    
    LJAlertViewController *alertVC = [LJAlertViewController showWithContainerView:pwdView alertStyle:UIAlertControllerStyleAlert];
    
    // 需要弱引用,否则无法释放
    __weak typeof(alertVC) weakAlertVC = alertVC;
    pwdView.actionHandle = ^(LJAlertCheckPwdViewAction action, NSString * _Nullable password) {
        [weakAlertVC dismissAlert];
        if (action == LJAlertCheckPwdViewActionComplete) {
            NSLog(@"输入完成 密码 = %@",password);
        }
        if (action == LJAlertCheckPwdViewActionCancel) {
            NSLog(@"点击了取消");
        }
        if (action == LJAlertCheckPwdViewActionForgetPwd) {
            NSLog(@"点击了忘记密码");
        }
    };
}

// 滑块验证
- (void)sliderCheckAlertView {
    LJSliderVerifyController *customAlertVC = [LJSliderVerifyController new];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self presentViewController:customAlertVC animated:NO completion:nil];
    });
    customAlertVC.resultHandle = ^(BOOL success) {
        if (success) {
            NSLog(@"滑块验证成功");
        }
    };
}

// 时间设置
- (void)datePickerAlertView {
    LJDatePickerView *datePickerView = [[LJDatePickerView alloc] init];
    datePickerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    
    LJAlertViewController *alertVC = [LJAlertViewController showWithContainerView:datePickerView alertStyle:UIAlertControllerStyleActionSheet];
       
       // 需要弱引用,否则无法释放
       __weak typeof(alertVC) weakAlertVC = alertVC;
    datePickerView.actionHandle = ^(BOOL isCancel, NSDate * _Nullable selectDate) {
        [weakAlertVC dismissAlert];
        if (isCancel) {
            NSLog(@"点击取消");
            return;
        }
        NSLog(@"选择了时间 = %@",selectDate);
    };
}

// 商品规格选择
- (void)goodsSpecsAlertView {
    NSArray *goodsList = [self getGoodsList];
    
    LJGoodsSpecsView *specsView = [LJGoodsSpecsView defaultViewWithGoods:goodsList.firstObject];
    
    LJAlertViewController *alertVC = [LJAlertViewController showWithContainerView:specsView alertStyle:UIAlertControllerStyleActionSheet];
    
    specsView.backgroundColor = [UIColor orangeColor];
    
    __weak typeof(alertVC) weakAlertVC = alertVC;
    specsView.dismissHandle = ^(LJGoodsOptionSelectedModel * _Nonnull model, BOOL isCancel) {
        [weakAlertVC dismissAlert];
        if (isCancel) {
            NSLog(@"点击了取消");
            return ;
        }
        NSLog(@"选择了 = %@",model.optionModel.title);
    };
}

#pragma mark - 测试数据
- (NSArray *)getGoodsList {
    NSArray *goodsList = @[
        @{
            @"id":@"1000",
            @"title":@"24k土豪披风时尚百搭+生命+抗性+强化99+附魔暴击99%",
            @"thumb":@"",
            @"price":@"9.9",
            @"total":@"309",
            @"specsList":@[
                    @{
                        @"id":@"100001",
                        @"goodsid":@"1000",
                        @"title":@"颜色",
                        @"itemList":@[
                                @{
                                    @"itemid":@"10000101",
                                    @"title":@"红色",
                                },
                                @{
                                    @"itemid":@"10000102",
                                    @"title":@"绿色",
                                },
                                @{
                                    @"itemid":@"10000103",
                                    @"title":@"蓝色",
                                }
                        ]
                    },
                    @{
                        @"id":@"100002",
                        @"goodsid":@"1000",
                        @"title":@"尺寸",
                        @"itemList":@[
                                @{
                                    @"itemid":@"10000201",
                                    @"title":@"S码",
                                },
                                @{
                                    @"itemid":@"10000202",
                                    @"title":@"M码",
                                },
                                @{
                                    @"itemid":@"10000203",
                                    @"title":@"L码",
                                }
                        ]
                    }
            ],
            @"optionList":@[
                    @{
                        @"id":@"",
                        @"goodsid":@"1000",
                        @"thumb":@"",
                        @"price":@"9.9",
                        @"stock":@"100",
                        @"title":@"红色+S码",
                        @"specs":@"10000101_10000201"
                    },
                    @{
                        @"id":@"",
                        @"goodsid":@"1000",
                        @"thumb":@"",
                        @"price":@"9.9",
                        @"stock":@"100",
                        @"title":@"红色+M码",
                        @"specs":@"10000101_10000202"
                    },
                    @{
                        @"id":@"",
                        @"goodsid":@"1000",
                        @"thumb":@"",
                        @"price":@"9.9",
                        @"stock":@"100",
                        @"title":@"红色+L码",
                        @"specs":@"10000101_10000203"
                    },
                    @{
                        @"id":@"",
                        @"goodsid":@"1000",
                        @"thumb":@"",
                        @"price":@"8.9",
                        @"stock":@"9",
                        @"title":@"绿色+S码",
                        @"specs":@"10000102_10000201"
                    }
            ]
        }
    ];
    goodsList = [NSArray yy_modelArrayWithClass:[LJGoodsModel class] json:goodsList];
    return goodsList;
}

@end




@implementation LJDemoCustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor greenColor];
    tempView.frame = CGRectMake(0, 0, 300, 300);
    [self showWithContainerView:tempView alertStyle:self.alertStyle];
    
}

@end



@implementation LJSliderVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    LJSliderVerifyView *sliderVerifyView = [[LJSliderVerifyView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.8, 350.0)];
    sliderVerifyView.backgroundColor = [UIColor whiteColor];
    self.sliderVerifyView = sliderVerifyView;
    [self showWithContainerView:sliderVerifyView alertStyle:UIAlertControllerStyleAlert];
    
    // 点击刷新
    sliderVerifyView.updateHandle = ^{
        [weakSelf requestSliderInfo];
    };
    // 点击关闭
    sliderVerifyView.closeHandle = ^{
        [weakSelf dismissAlert];
    };
    // 拖动了滑块
    sliderVerifyView.resultHandle = ^(BOOL success) {
        if (!success) {
            return ;
        }
        if (weakSelf.resultHandle) {
            weakSelf.resultHandle(YES);
        }
        [weakSelf dismissAlert];
    };
    
    
    // 初始化验证图片
    self.sliderVerifyView.verifyImage = [UIImage imageNamed:@"slider_temp_1"];
    
}



/// 刷新验证图片
- (void)requestSliderInfo {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         weakSelf.sliderVerifyView.verifyImage = [UIImage imageNamed:@"slider_temp_0"];
    });
}

@end



