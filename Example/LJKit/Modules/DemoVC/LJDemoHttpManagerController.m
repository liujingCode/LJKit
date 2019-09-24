//
//  LJDemoHttpManagerController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoHttpManagerController.h"
#import "LJHttpManager.h"
@interface LJDemoHttpManagerController ()

@end

@implementation LJDemoHttpManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"无参数get",@"有参数get",@"无参数post",@"有参数post",@"上传",@"下载",@"无顺序的多个请求",@"有顺序的多个请求"];
    
    // 网络初始化
    LJHttpManager *manager = [LJHttpManager sharedInstance];
    manager.hostStr = @"https://www.baidu.com";
    manager.token = @"我是token";
    manager.tokenEnable = YES;
    manager.defaultParamsEnable = YES;
    manager.defaultParams = @{@"api_version":@"1.0"};
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self requestGetNormal];
        return;
    }
    
    if (indexPath.row == 1) {
        [self requestGetParams];
        return;
    }
    
    if (indexPath.row == 2) {
        [self requestPostNormal];
        return;
    }
    
    if (indexPath.row == 3) {
        [self requestPostParams];
        return;
    }
    
    if (indexPath.row == 4) {
        [self requestUpload];
        return;
    }
    
    if (indexPath.row == 5) {
        [self requestDownLoad];
        return;
    }
    if (indexPath.row == 6) {
        [self notOrderTask];
        return;
    }
    if (indexPath.row == 7) {
        [self orderTask];
        return;
    }
}


// 无参数get
- (void)requestGetNormal {
    NSString *urlStr = @"http://t.weather.sojson.com/api/weather/city/101030100";
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:nil] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"response = %@, error = %@",response,error);
    }];
}

// 有参数get
- (void)requestGetParams {
    NSString *urlStr = @"https://jsonplaceholder.typicode.com/comments";
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"2"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"response = %@, error = %@",response,error);
    }];
}

// 无参数post
- (void)requestPostNormal {
    NSString *urlStr = @"";
    [LJHttpManager requestWithRequest:[LJHttpRequest requestPostWithUrlStr:urlStr andParams:nil] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"response = %@, error = %@",response,error);
    }];
}

// 有参数post
- (void)requestPostParams {
    NSString *urlStr = @"http://61.234.48.8:180/api/social/signInfo";
    NSDictionary *params = @{
                             };
    [LJHttpManager requestWithRequest:[LJHttpRequest requestPostWithUrlStr:urlStr andParams:params] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"response = %@, error = %@",response,error);
    }];
}


// 上传
- (void)requestUpload {
    NSString *urlStr = @"";
    NSDictionary *params = @{
                            
                             };
    
    NSArray *imageNameList = @[@"test_head",@"test_head",@"test_head"];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:imageNameList.count];
    for (int i = 0; i < imageNameList.count; i ++) {
        UIImage *image = [UIImage imageNamed:imageNameList[i]];
        LJHttpUploadModel *model = [LJHttpUploadModel new];
        model.fileName = [NSString stringWithFormat:@"feedback_fileName.jpg"];
        model.data = UIImageJPEGRepresentation(image, 0.9);
        model.key = @"feedback_fileName";
        model.fileType = @"image/jpg";
        [tempArray addObject:model];
    }
    
    [LJHttpManager requestWithRequest:[LJHttpRequest uploadWithUrlStr:urlStr andParams:params andFileList:tempArray.mutableCopy andProgressCallback:^(float progress) {
        NSLog(@"upload progress = %f",progress);
    }] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"response = %@, error = %@",response,error);
    }];
}

// 下载
- (void)requestDownLoad {
    NSLog(@"开始下载");
    NSString *urlStr = @"http://localhost:8888/download/testBook.pdf";
    [LJHttpManager downloadWithRequest:[LJHttpRequest downloadWithUrlStr:urlStr andProgressCallback:^(float progress) {
        
        NSLog(@"download progress = %f",progress);
    }] andDestination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"targetPath:%@",targetPath);
        NSLog(@"filePath:%@",filePath);
        return [NSURL fileURLWithPath:filePath];
    } andCompletionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
        NSLog(@"下载结束,response = %@, error = %@",response,error);
    }];
}


// 有顺序的多任务
- (void)orderTask {
    // 创建一个串行队列
    dispatch_queue_t networkQueue = dispatch_queue_create("networkQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
    NSString *urlStr = @"https://jsonplaceholder.typicode.com/comments";
    dispatch_group_async(group, networkQueue, ^{
        NSLog(@"开始执行任务1");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"1"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
            NSLog(@"完成第1个请求");
            dispatch_semaphore_signal(sema);
        }];
        NSLog(@"正在等待任务1完成");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"任务1已完成");
    });
    dispatch_group_async(group, networkQueue, ^{
        NSLog(@"开始执行任务2");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"2"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
            NSLog(@"完成第2个请求");
            dispatch_semaphore_signal(sema);
        }];
        NSLog(@"正在等待任务2完成");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"任务2已完成");
    });
    dispatch_group_async(group, networkQueue, ^{
        NSLog(@"开始执行任务3");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"3"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
            NSLog(@"完成第3个请求");
            dispatch_semaphore_signal(sema);
        }];
        NSLog(@"正在等待任务3完成");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"任务3已完成");
    });
    dispatch_group_async(group, networkQueue, ^{
        NSLog(@"开始执行任务4");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"4"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
            NSLog(@"完成第4个请求");
            dispatch_semaphore_signal(sema);
        }];
        NSLog(@"正在等待任务4完成");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"任务4已完成");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成所有请求");
    });
}

// 无顺序的多任务
- (void)notOrderTask{
    NSString *urlStr = @"https://jsonplaceholder.typicode.com/comments";
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"1"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        dispatch_group_leave(group);
        NSLog(@"完成第1个请求");
    }];
    dispatch_group_enter(group);
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"2"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        dispatch_group_leave(group);
        NSLog(@"完成第2个请求");
    }];
    dispatch_group_enter(group);
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"3"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        dispatch_group_leave(group);
        NSLog(@"完成第3个请求");
    }];
    dispatch_group_enter(group);
    [LJHttpManager requestWithRequest:[LJHttpRequest requestGetWithUrlStr:urlStr andParams:@{@"postId":@"4"}] andCallback:^(id  _Nullable response, NSError * _Nullable error, NSURLSessionDataTask * _Nonnull task) {
        dispatch_group_leave(group);
        NSLog(@"完成第4个请求");
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成所有请求");
    });
}

@end
