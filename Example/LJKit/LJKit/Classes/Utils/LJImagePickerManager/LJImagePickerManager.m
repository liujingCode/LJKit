//
//  LJImagePickerManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJImagePickerManager.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <CoreServices/CoreServices.h>
@interface LJImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate ,TZImagePickerControllerDelegate>
/** 选择相册图片 */
@property (nonatomic, strong) TZImagePickerController *imagePicker;
/** 相机 */
@property (nonatomic, strong) UIImagePickerController *cameraPicker;
/** 默认配置 */
@property (nonatomic, strong) LJImagePickerManagerConfig *defaultConfig;
@property (nonatomic, copy) LJImagePickerCompleteCallback callback;
@end
@implementation LJImagePickerManager
#pragma mark - class method
static LJImagePickerManager *instance;
static dispatch_once_t onceToken;
+(instancetype)sharedManager {
    dispatch_once(&onceToken, ^{
        instance = [[LJImagePickerManager alloc] init];
    });
    return instance;
}

+(void)showWithType:(LJImagePickerManagerSourceType)type andCallback:(LJImagePickerCompleteCallback)callback; {
    // 默认配置
    LJImagePickerCongigCallback config = ^(LJImagePickerManagerConfig *config) {
        
    };
    [self showWithType:type andConfig:config andCallback:callback];
}

+(void)showWithType:(LJImagePickerManagerSourceType)type andConfig:(LJImagePickerCongigCallback)config andCallback:(LJImagePickerCompleteCallback)callback {
    LJImagePickerManager *manager = [LJImagePickerManager sharedManager];
    manager.callback = callback;
    // 自定义配置
    if (config) {
        config(manager.defaultConfig);
    }
    [manager showWithType:type];
}

#pragma mark - object method
// present 相机或相册
- (void)showWithType:(LJImagePickerManagerSourceType)type {
    if (type == LJImagePickerManagerSourceTypeCamera) {
        [self checkCameraAuthor];
    }
    if (type == LJImagePickerManagerSourceTypePhotoLibrary) {
        // 自定义配置
        [self setupConfig];
       [[self lj_rootViewController]  presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

#pragma mark - 相机权限
- (void)checkCameraAuthor {
    __weak typeof(self) weakSelf = self;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        
        NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
        if (!infoDict || !infoDict.count) {
            infoDict = [NSBundle mainBundle].infoDictionary;
        }
        if (!infoDict || !infoDict.count) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
            infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
        }
        // 无权限 做一个友好的提示
        NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
        
        NSString *message = [NSString stringWithFormat:@"请在设置中打开%@的相机使用权限",appName];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:confirmAction];
        [alertVC addAction:cancelAction];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showImagePickerController];
                });
            }
        }];
    } else {
        [self showImagePickerController];
    }
}


- (void)showImagePickerController {
//    __weak typeof(self) weakSelf = self;
    if ([UIImagePickerController isSourceTypeAvailable: self.cameraPicker.sourceType]) {
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];

        if (self.defaultConfig.allowTakeVideo) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
            self.cameraPicker.videoMaximumDuration = self.defaultConfig.videoMaximumDuration;
        }
        self.cameraPicker.mediaTypes= mediaTypes;
        [[self lj_rootViewController] presentViewController:self.cameraPicker animated:YES completion:nil];
    } else {
        LJKitLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)dismissWithTargetVC:(UIViewController *)targetVC Photos:(NSArray <UIImage *>*)photos andOriginal:(BOOL)isOriginal {
    // 释放内存
    instance = nil;
    onceToken = 0;
    [targetVC dismissViewControllerAnimated:YES completion:nil];
    if (self.callback) {
        self.callback(photos, isOriginal);
    }
    
}

#pragma mark - 设置config
- (void)setupConfig {
    if (self.defaultConfig.allowsEditing == YES){
        self.defaultConfig.maxImagesCount = 1;
    }
    self.imagePicker.allowCrop = self.defaultConfig.allowsEditing;
    self.imagePicker.showSelectBtn = !self.defaultConfig.allowsEditing;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - self.defaultConfig.cropLeftMargin * 2;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - width) * 0.5;
    self.imagePicker.cropRect = CGRectMake(self.defaultConfig.cropLeftMargin, y, width, width);
    
    self.imagePicker.minImagesCount = self.defaultConfig.minImagesCount;
    self.imagePicker.maxImagesCount = self.defaultConfig.maxImagesCount;
    self.imagePicker.allowTakePicture = self.defaultConfig.allowTakePicture;
    self.imagePicker.allowPickingOriginalPhoto = self.defaultConfig.allowPickingOriginalPhoto;
    self.imagePicker.allowPreview = self.defaultConfig.allowPreview;
    self.imagePicker.showSelectedIndex = self.defaultConfig.showSelectedIndex;
    self.imagePicker.showPhotoCannotSelectLayer = self.defaultConfig.showPhotoCannotSelectLayer;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image){
        return;
    }
    __weak typeof(self) weakSelf = self;
    if (self.defaultConfig.allowsEditing == YES) { // 裁剪图片
        [picker dismissViewControllerAnimated:NO completion:nil];
        
        // 自定义配置
        [self setupConfig];
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(PHAsset *asset, NSError *error) {
            TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
            TZImagePickerController *cropVC = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                if (weakSelf.callback) {
                    weakSelf.callback(@[cropImage], YES);
                }
                //                [self dismissWithTargetVC:cropVC Photos:@[cropImage] andOriginal:YES];
            }];
            cropVC.isSelectOriginalPhoto = self.defaultConfig.allowPickingOriginalPhoto;
            cropVC.iconThemeColor = self.defaultConfig.themeColor;
            cropVC.oKButtonTitleColorNormal = self.defaultConfig.themeColor;
            cropVC.cropRect = weakSelf.imagePicker.cropRect;
            [[self lj_rootViewController] presentViewController:cropVC animated:YES completion:nil];
        }];
    } else { // 系统拍照
        [self dismissWithTargetVC:picker Photos:@[image] andOriginal:YES];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissWithTargetVC:picker Photos:nil andOriginal:NO];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self dismissWithTargetVC:picker Photos:photos andOriginal:isSelectOriginalPhoto];
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [self dismissWithTargetVC:picker Photos:nil andOriginal:NO];
}

#pragma mark - 获取根控制器
- (UIViewController *)lj_rootViewController {
    UIViewController *VC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return VC;
}

#pragma mark - dealloc
- (void)dealloc {
    LJKitLog(@"dealloc %@",self);
}


#pragma mark - 懒加载
//- (UIImagePickerController *)cameraPicker {
//    if (!_cameraPicker) {
//        _cameraPicker = [[UIImagePickerController alloc] init];
//        _cameraPicker.delegate = self;
//        _cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        _cameraPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//    }
//    return _cameraPicker;
//}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)cameraPicker {
    if (_cameraPicker == nil) {
        _cameraPicker = [[UIImagePickerController alloc] init];
        _cameraPicker.delegate = self;
        _cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // set appearance / 改变相册选择页的导航栏外观
        _cameraPicker.navigationBar.barTintColor = self.imagePicker.navigationController.navigationBar.barTintColor;
        _cameraPicker.navigationBar.tintColor = self.imagePicker.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _cameraPicker;
}
#pragma clang diagnostic pop


- (TZImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self];
        _imagePicker.allowPickingVideo = NO;  // 不可选择视频
        _imagePicker.allowTakeVideo = NO;  // 选照片时不可拍视频
        _imagePicker.allowPickingGif = NO;  // 不可选择gif
        _imagePicker.autoDismiss = NO; // 不自动dismiss
        
        _imagePicker.iconThemeColor = self.defaultConfig.themeColor;
        _imagePicker.oKButtonTitleColorNormal = self.defaultConfig.themeColor;
        _imagePicker.oKButtonTitleColorDisabled = [UIColor colorWithWhite:0.6 alpha:1.0];
        _imagePicker.naviBgColor = self.defaultConfig.themeColor;
    }
    return _imagePicker;
}

- (LJImagePickerManagerConfig *)defaultConfig {
    if (!_defaultConfig) {
        LJImagePickerManagerConfig *config = [[LJImagePickerManagerConfig alloc] init];
        config.allowsEditing = NO; // 不允许裁剪
        config.cropLeftMargin = 16.f; // 裁剪区域左右边距 16px
        config.minImagesCount = 0; // 最小必选张数
        config.maxImagesCount = 1; // 最大必选张数
        config.allowTakePicture = NO; // 选照片时不可拍照
        config.allowTakeVideo = NO;
        config.allowPickingOriginalPhoto = NO; // 隐藏底部原图按钮
        config.allowPreview = YES;  // 允许预览
        config.showSelectedIndex = YES; // 不展示索引
        config.showPhotoCannotSelectLayer = NO; // 显示不可选择遮罩图层
        config.themeColor = [UIColor colorWithRed:255.0/255 green:130.0/255 blue:71.0/255 alpha:1.0];
        _defaultConfig = config;
    }
    return _defaultConfig;
}

@end

#pragma mark - LJImagePickerManagerConfig
@implementation LJImagePickerManagerConfig

@end
