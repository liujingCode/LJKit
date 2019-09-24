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
@property (nonatomic, copy) LJImagePickerCompleteCallback completeCallback;
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
    LJImagePickerCongigCallback configCallback = ^(LJImagePickerManagerConfig *config) {
        
    };
    [self showWithType:type andConfig:configCallback andCallback:callback];
}

+(void)showWithType:(LJImagePickerManagerSourceType)type andConfig:(LJImagePickerCongigCallback)config andCallback:(LJImagePickerCompleteCallback)callback {
    LJImagePickerManager *manager = [LJImagePickerManager sharedManager];
    manager.completeCallback = callback;
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
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) { // 未同意
        [self showAuthSetting];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 等待选择
        // 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showCameraController];
                });
            } else {
                
            }
            
        }];
    } else { // 已同意
        [self showCameraController];
    }
}

#pragma mark - 跳转到权限设置页面
- (void)showAuthSetting {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    // 无权限
    NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
    
    NSString *message = [NSString stringWithFormat:@"请在设置中打开%@的相机使用权限",appName];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(DISPATCH_TIME_NOW + 0.2, dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    
    [[self lj_rootViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)showCameraController {
    self.cameraPicker.allowsEditing = self.defaultConfig.allowsEditing;
    if ([UIImagePickerController isSourceTypeAvailable: self.cameraPicker.sourceType]) {
        [[self lj_rootViewController] presentViewController:self.cameraPicker animated:YES completion:nil];
    } else { // 无法加载资源 可能当前为模拟器
        
    }
}

#pragma mark - dismiss
- (void)dismissWithTargetVC:(UIViewController *)targetVC Photos:(NSArray <UIImage *>*)photos andOriginal:(BOOL)isOriginal {
    // 释放内存
    instance = nil;
    onceToken = 0;
    [targetVC dismissViewControllerAnimated:YES completion:nil];
    if (self.completeCallback) {
        self.completeCallback(photos, isOriginal);
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
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!originalImage){
        return;
    }
    if (self.defaultConfig.allowsEditing && [info.allKeys containsObject:UIImagePickerControllerEditedImage]) {
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = editImage?editImage:originalImage;
    }
    [self dismissWithTargetVC:picker Photos:@[originalImage] andOriginal:YES];
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
    UIViewController *VC = [UIApplication sharedApplication].delegate.window.rootViewController;
    return VC;
}

//#pragma mark - dealloc
//- (void)dealloc {
//}


#pragma mark - 懒加载
- (UIImagePickerController *)cameraPicker {
    if (_cameraPicker == nil) {
        _cameraPicker = [[UIImagePickerController alloc] init];
        _cameraPicker.delegate = self;
        _cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    return _cameraPicker;
}



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
        // 获取单例属性
        LJImagePickerManagerConfig *sharedConfig = [LJImagePickerManagerConfig sharedInstance];
        
        LJImagePickerManagerConfig *config = [LJImagePickerManagerConfig new];
        config.allowsEditing = sharedConfig.allowsEditing;
        config.cropLeftMargin = sharedConfig.cropLeftMargin;
        config.minImagesCount = sharedConfig.minImagesCount;
        config.maxImagesCount = sharedConfig.maxImagesCount;
        config.allowTakePicture = sharedConfig.allowTakePicture;
        config.allowTakeVideo = sharedConfig.allowTakeVideo;
        config.allowPickingOriginalPhoto = sharedConfig.allowPickingOriginalPhoto;
        config.allowPreview = sharedConfig.allowPreview;
        config.showSelectedIndex = sharedConfig.showSelectedIndex;
        config.showPhotoCannotSelectLayer = sharedConfig.showPhotoCannotSelectLayer;
        config.themeColor = sharedConfig.themeColor;
        _defaultConfig = config;
    }
    return _defaultConfig;
}

@end

#pragma mark - LJImagePickerManagerConfig
@implementation LJImagePickerManagerConfig
+ (instancetype)sharedInstance {
    static LJImagePickerManagerConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJImagePickerManagerConfig new];
        instance.allowsEditing = NO; // 不允许裁剪
        instance.cropLeftMargin = 16.f; // 裁剪区域左右边距 16px
        instance.minImagesCount = 0; // 最小必选张数
        instance.maxImagesCount = 1; // 最大必选张数
        instance.allowTakePicture = NO; // 选照片时不可拍照
        instance.allowTakeVideo = NO;
        instance.allowPickingOriginalPhoto = NO; // 隐藏底部原图按钮
        instance.allowPreview = YES;  // 允许预览
        instance.showSelectedIndex = YES; // 不展示索引
        instance.showPhotoCannotSelectLayer = NO; // 显示不可选择遮罩图层
        instance.themeColor = [UIColor colorWithRed:255.0/255 green:130.0/255 blue:71.0/255 alpha:1.0];
    });
    return instance;
}
@end
