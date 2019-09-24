//
//  LJImagePickerManager.h
//  LJKit_Example
//
//  Created by developer on 2019/9/10.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJImagePickerManagerConfig;
NS_ASSUME_NONNULL_BEGIN

/**
 资源类型
 
 - LZImagePickerManagerSourceTypePhotoLibrary: 相册
 - LZImagePickerManagerSourceTypeCamera: 相机
 */
typedef NS_ENUM(NSUInteger, LJImagePickerManagerSourceType) {
    LJImagePickerManagerSourceTypePhotoLibrary = 0,
    LJImagePickerManagerSourceTypeCamera
};

typedef void(^LJImagePickerCompleteCallback)(NSArray <UIImage *>* _Nullable photos, BOOL isOriginal);
typedef void(^LJImagePickerCongigCallback)(LJImagePickerManagerConfig *config);


/**
 照片选择器的配置文件
 */
@interface LJImagePickerManagerConfig : NSObject
#pragma mark - 相机属性
/** 默认NO，不允许裁剪，如果设置为YES，允许裁剪(maxImagesCount = 1 才有效) */
@property (nonatomic, assign) BOOL allowsEditing;
/** 设置裁剪区域左右边距: 默认16px,只对相册选取的有效 */
@property (nonatomic, assign) CGFloat cropLeftMargin;

#pragma mark - 相册属性
/** 最大可选图片数量，默认1张 */
@property (nonatomic, assign) NSInteger maxImagesCount;
/** 最小照片必选张数，默认0张 */
@property (nonatomic, assign) NSInteger minImagesCount;
/** 默认为NO，如果设置为YES，用户将可以拍摄照片 */
@property (nonatomic, assign) BOOL allowTakePicture;
/** 默认为NO，如果设置为YES, 用户将可以拍摄视频 */
@property(nonatomic, assign) BOOL allowTakeVideo;
/** 视频最大拍摄时间，默认是10分钟，单位是秒 */
@property (assign, nonatomic) NSTimeInterval videoMaximumDuration;
/** 默认为NO，如果设置为YES，原图按钮将显示，用户可以选择发送原图 */
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;
/** 默认为NO，如果设置为YES，用户可以选择gif图片 */
@property (nonatomic, assign) BOOL allowPickingGif;
/** 默认为YES，如果设置为NO，预览按钮将隐藏，用户将不能去预览照片 */
@property (nonatomic, assign) BOOL allowPreview;
/** 默认为YES，不显示照片的选中序号，如果设置为NO，不显示 */
@property (nonatomic, assign) BOOL showSelectedIndex;
/** 默认是NO，当照片选择张数达到maxImagesCount时，其它照片会显示颜色为cannotSelectLayerColor的浮层
 如果设置为YES，显示 */
@property (nonatomic, assign) BOOL showPhotoCannotSelectLayer;
// Default is white color with 0.8 alpha;
@property (nonatomic, strong) UIColor *cannotSelectLayerColor;
/** 主题色 默认为(255,130,71) */
@property (nonatomic, strong) UIColor *themeColor;


+ (instancetype)sharedInstance;
@end


/**
 相册选择器
 */
@interface LJImagePickerManager : NSObject

/**
 展示相册或相机(默认配置)
 
 @param fromVC 当前调用的控制器
 @param type 展示类型
 @param callback 选择后的回调
 */
+(void)showWithType:(LJImagePickerManagerSourceType)type andCallback:(LJImagePickerCompleteCallback)callback;

/**
 展示相册或相机(自定义配置)
 
 @param fromVC 当前调用的控制器
 @param type 展示类型
 @param config 自定义相册属性的回调
 @param callback 选择后的回调
 */
+(void)showWithType:(LJImagePickerManagerSourceType)type andConfig:(LJImagePickerCongigCallback)config andCallback:(LJImagePickerCompleteCallback)callback;

@end

NS_ASSUME_NONNULL_END
