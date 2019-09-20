//
//  LJDemoImagePickerController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/19.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDemoImagePickerController.h"
#import "LJImagePickerManager.h"

@interface LJDemoImagePickerController ()

@end

@implementation LJDemoImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = @[@"拍照",@"相册",@"自定义拍照",@"自定义相册"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LJImagePickerManagerSourceType sourceType = ((indexPath.item == 0) || (indexPath.item == 2))?LJImagePickerManagerSourceTypeCamera:LJImagePickerManagerSourceTypePhotoLibrary;
    BOOL isCustom = ((indexPath.item == 0) || (indexPath.item == 1))?NO:YES;
    
    
    if (isCustom) { // 自定义
        [LJImagePickerManager showWithType:sourceType andConfig:^(LJImagePickerManagerConfig * _Nonnull config) {
            // 相册属性
            config.themeColor = [UIColor blueColor];
            config.allowPickingOriginalPhoto = YES;
            config.allowTakePicture = YES;
            config.maxImagesCount = 2;
            
            // 相机属性
            config.allowsEditing = YES;
            config.cropLeftMargin = 30.0;
            
        } andCallback:^(NSArray<UIImage *> * _Nullable photos, BOOL isOriginal) {
            NSString *typeString = (sourceType == LJImagePickerManagerSourceTypeCamera)?@"拍照":@"相册";
            NSString *isOriginalString = isOriginal?@"是":@"不是";
            NSLog(@"资源类型 = %@, 图片数量 = %lu,是否是原图 = %@",typeString,(unsigned long)photos.count,isOriginalString);
        }];
    } else {
        [LJImagePickerManager showWithType:sourceType andCallback:^(NSArray<UIImage *> * _Nullable photos, BOOL isOriginal) {
            NSString *typeString = (sourceType == LJImagePickerManagerSourceTypeCamera)?@"拍照":@"相册";
            NSString *isOriginalString = isOriginal?@"是":@"不是";
            NSLog(@"资源类型 = %@, 图片数量 = %lu,是否是原图 = %@",typeString,(unsigned long)photos.count,isOriginalString);
            
        }];
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
