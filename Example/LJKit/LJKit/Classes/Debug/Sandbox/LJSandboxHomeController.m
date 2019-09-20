//
//  LJSandboxHomeController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJSandboxHomeController.h"
#import "LJSandboxViewCell.h"
#import "LJLocalFilePreviewController.h"

@interface LJSandboxHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LJSandboxModel *currentDirModel;
@property (nonatomic, copy) NSArray <LJSandboxModel *>*dataArray;
@property (nonatomic, copy) NSString *rootPath;

@end

@implementation LJSandboxHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"沙盒浏览";
    self.view.backgroundColor = [UIColor whiteColor];
    self.rootPath = NSHomeDirectory();
    self.dataArray= @[];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"上级目录" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackDirectory)];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseBtn)];
    
    UIBarButtonItem *updateItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(clickUpdateBtn)];
    
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
    self.navigationItem.rightBarButtonItem = updateItem;
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self clickUpdateBtn];
}


#pragma mark - 点击关闭
- (void)clickCloseBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 加载上级目录
- (void)clickBackDirectory {
    [self loadFileWithPath:[self.currentDirModel.path stringByDeletingLastPathComponent]];
}

#pragma mark - 点击刷新
- (void)clickUpdateBtn {
    [self loadFileWithPath:self.currentDirModel.path];
}


#pragma mark - 加载目录
- (void)loadFileWithPath:(NSString *)path {
    NSString *targetPath = path;
    LJSandboxModel *model = [LJSandboxModel new];
    if ((!targetPath) || ([targetPath isEqualToString:self.rootPath])) {
        targetPath = _rootPath;
        model.name = @"沙盒浏览";
        model.type = LJSandboxModelTypeRootDirectory;
    }else{
        model.name = [path lastPathComponent];
        model.type = LJSandboxModelTypeSubDirectory;
    }
    model.path = targetPath;
    self.currentDirModel = model;
    
    self.title = model.name;
    
    // 该目录下面的内容信息
    NSFileManager *manager = [NSFileManager defaultManager];
    NSMutableArray *tempArr = [NSMutableArray array];
    NSError *error = nil;
    NSArray *paths = [manager contentsOfDirectoryAtPath:targetPath error:&error];
    for (NSString *path in paths) {
        BOOL isDir = false;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:path];
        [manager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        LJSandboxModel *model = [[LJSandboxModel alloc] init];
        model.path = fullPath;
        if (isDir) {
            model.type = LJSandboxModelTypeSubDirectory;
        }else{
            model.type = LJSandboxModelTypeFile;
        }
        model.name = path;
        
        [tempArr addObject:model];
    }
    
    self.dataArray = [NSArray arrayWithArray:tempArr];
    [self.tableView reloadData];
}

#pragma mark - tableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"LJSandboxViewCell";
    LJSandboxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LJSandboxViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    LJSandboxModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LJSandboxModel *model = self.dataArray[indexPath.row];
    NSString *filePath = model.path;
    if (model.type == LJSandboxModelTypeFile) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *previewAction = [UIAlertAction actionWithTitle:@"本地预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf previewFileWithPath:filePath];
        }];
        UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf shareFileWithPath:filePath];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVc addAction:previewAction];
        [alertVc addAction:shareAction];
        [alertVc addAction:cancelAction];
        
        [self presentViewController:alertVc animated:YES completion:nil];
    }else if((model.type == LJSandboxModelTypeSubDirectory) || (model.type == LJSandboxModelTypeRootDirectory)){
        [self loadFileWithPath:model.path];
    }
}


#pragma mark - 文件分享
- (void)shareFileWithPath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *objectsToShare = @[url];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - 文件预览
- (void)previewFileWithPath:(NSString *)path {
    LJLocalFilePreviewController *localPreviewVC = [LJLocalFilePreviewController new];
    localPreviewVC.filePath = path;
    [self presentViewController:localPreviewVC animated:YES completion:nil];
    
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

@end
