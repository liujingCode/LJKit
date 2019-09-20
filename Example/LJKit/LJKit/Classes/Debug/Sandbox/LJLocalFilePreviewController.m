//
//  LJLocalFilePreviewController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJLocalFilePreviewController.h"
#import <QuickLook/QuickLook.h>
#import <sqlite3.h>

@interface LJLocalFilePreviewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@end

@implementation LJLocalFilePreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.filePath.length == 0) {
        NSLog(@"文件不存在");
        return;
    }
    NSString *path = self.filePath;
    
    if ([path hasSuffix:@".strings"] || [path hasSuffix:@".plist"]) {
        [self previewText];
    } else if([path hasSuffix:@".DB"] || [path hasSuffix:@".db"] || [path hasSuffix:@".sqlite"] || [path hasSuffix:@".SQLITE"]){ // 数据库文件
        
    } else { // 其他文件
        
        QLPreviewController *previewController = [[QLPreviewController alloc]init];
        previewController.delegate = self;
        previewController.dataSource = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:previewController animated:YES completion:nil];
        });
        
    }
}

- (void)clickCloseBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 预览文本文件
- (void)previewText {
    NSString *text = [[NSDictionary dictionaryWithContentsOfFile:self.filePath] description];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat y = statusBarHeight + 44.0;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y)];
    textView.font = [UIFont systemFontOfSize:12.0f];
    textView.textColor = [UIColor blackColor];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    textView.scrollEnabled = YES;
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth = 2.0f;
    textView.text = text;
    [self.view addSubview:textView];
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"关闭预览" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn sizeToFit];
    [self.view addSubview:closeBtn];
    
    closeBtn.frame = CGRectMake(10, statusBarHeight, 80, 44.0);
}

#pragma mark - 预览数据库文件
- (void)previewDbWithPath:(NSString *)path {
    sqlite3 *db = nil;
    sqlite3_open([path UTF8String], &db);
    if (db == nil) {
        return;
    }
    // 查询sqlite_master表
    NSMutableArray *tableNameArray = [NSMutableArray array];
    
    NSString *sql = @"select type, tbl_name from sqlite_master";
    sqlite3_stmt *stmt = NULL;
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *type_c = sqlite3_column_text(stmt, 0);
            const unsigned char *tbl_name_c = sqlite3_column_text(stmt, 1);
            NSString *type = [NSString stringWithUTF8String:(const char *)type_c];
            NSString *tbl_name = [NSString stringWithUTF8String:(const char *)tbl_name_c];
            if (type && [type isEqualToString:@"table"]) {
                [tableNameArray addObject:tbl_name];
            }
        }
    }
    
}


#pragma mark - QLPreviewControllerDataSource, QLPreviewControllerDelegate
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return [NSURL fileURLWithPath:self.filePath];
}
- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
