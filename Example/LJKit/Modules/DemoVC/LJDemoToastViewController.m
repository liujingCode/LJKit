//
//  LJDemoToastViewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/25.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoToastViewController.h"
#import "LJToast.h"

BOOL enableDisplayLink = NO;

@interface LJDemoToastViewController ()
@property (nonatomic, strong) LJToast *currentToast;
@property(nonatomic,strong) CADisplayLink *displayLink;
@end

@implementation LJDemoToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏hud" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];

//    [self setValue:[LJToast new] forKey:@"currentToast"];
    
    self.dataList = @[@"纯文字",@"纯图片",@"文本加图片",@"文本loading",@"图片loading",@"文本+图片loading",@"纯文字进度条"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self displayLink];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopDisplayLink];
}

- (void)clickRightItem {
    [self.currentToast dismissToast];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSInteger row = indexPath.row;
    LJToast *toast;
    if (row == 0) {
        toast = [LJToast showToastWithText:@"大风起兮云飞扬"];
    } else if (row == 1) {
        toast = [LJToast showToastWithImage:[UIImage imageNamed:@"share_qq_session"]];
    } else if (row == 2) {
        toast = [LJToast showToastWithText:@"安得猛士兮走四方" andImage:[UIImage imageNamed:@"share_qq_session"]];
    } else if (row == 3) {
        toast = [LJToast showLoadingWithText:@"loading..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [toast dismissToast];
        });
    } else if (row == 4) {
        toast = [LJToast showLoadingWithImage:[UIImage imageNamed:@"share_qq_session"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [toast dismissToast];
        });
    } else if (row == 5) {
        toast = [LJToast showLoadingWithText:@"loading..." andImage:[UIImage imageNamed:@"share_qq_session"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [toast dismissToast];
        });
    } else if (row == 6) {
        toast = [LJToast showProgressWithText:@"正在拼命上传中..."];
        enableDisplayLink = YES;
        [self updataProgress];
    }
    
    
    self.currentToast = toast;
}


- (void)updataProgress {
    if (!enableDisplayLink) {
        return;
    }
    
    self.currentToast.progress += 0.001;
    if (self.currentToast.progress >= 1.0) {
        enableDisplayLink = NO;
        [self.currentToast dismissToast];
        [LJToast showToastWithText:@"上传或下载完成"];
    }
}

#pragma mark - 释放定时器
- (void)stopDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}




- (CADisplayLink *)displayLink  {
    if (!_displayLink) {
        // 创建CADisplayLink
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updataProgress)];
        
        // 添加至RunLoop中
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _displayLink = displayLink;
    }
    return _displayLink;
}

@end
