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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.tableHeaderView = imageView;
    
    self.dataList = @[@"拍照",@"相册",@"自定义拍照",@"自定义相册"];
    
    // 自定义相机或相册选择的配置
    LJImagePickerManagerConfig *imagePickerCongig = [LJImagePickerManagerConfig sharedInstance];
    imagePickerCongig.themeColor = [UIColor blueColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImageView *imageView = (UIImageView *)tableView.tableHeaderView;
    
    LJImagePickerManagerSourceType sourceType = ((indexPath.item == 0) || (indexPath.item == 2))?LJImagePickerManagerSourceTypeCamera:LJImagePickerManagerSourceTypePhotoLibrary;
    BOOL isCustom = ((indexPath.item == 0) || (indexPath.item == 1))?NO:YES;
    
    
    if (isCustom) { // 自定义
        [LJImagePickerManager showWithType:sourceType andConfig:^(LJImagePickerManagerConfig * _Nonnull config) {
//            // 相册属性
            config.themeColor = [UIColor redColor];
//            config.allowPickingOriginalPhoto = YES;
//            config.allowTakePicture = YES;
//            config.maxImagesCount = 2;
//            
            // 相机属性
            config.allowsEditing = YES;
            config.cropLeftMargin = 30.0;
            
        } andCallback:^(NSArray<UIImage *> * _Nullable photos, BOOL isOriginal) {
            NSString *typeString = (sourceType == LJImagePickerManagerSourceTypeCamera)?@"拍照":@"相册";
            NSString *isOriginalString = isOriginal?@"是":@"不是";
            NSLog(@"资源类型 = %@, 图片数量 = %lu,是否是原图 = %@",typeString,(unsigned long)photos.count,isOriginalString);
            imageView.image = photos.firstObject;
        }];
    } else {
        [LJImagePickerManager showWithType:sourceType andCallback:^(NSArray<UIImage *> * _Nullable photos, BOOL isOriginal) {
            NSString *typeString = (sourceType == LJImagePickerManagerSourceTypeCamera)?@"拍照":@"相册";
            NSString *isOriginalString = isOriginal?@"是":@"不是";
            NSLog(@"资源类型 = %@, 图片数量 = %lu,是否是原图 = %@",typeString,(unsigned long)photos.count,isOriginalString);
            imageView.image = photos.firstObject;
            
        }];
    }
    
    
}


@end
