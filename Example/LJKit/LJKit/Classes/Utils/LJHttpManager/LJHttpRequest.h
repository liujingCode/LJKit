//
//  LJHttpRequest.h
//  LJApp
//
//  Created by developer on 2019/8/26.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJHttpUploadModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LJHttpRequestType) {
    LJHttpRequestTypeGet,
    LJHttpRequestTypePost,
    LJHttpRequestTypeDownload,
    LJHttpRequestTypeUpload,
};

typedef void(^LJHttpRequestProgressCallback)(float progress);

/**
 http请求体模型
 */
@interface LJHttpRequest : NSObject
{
    NSString *_name;
    NSString *age;
}

/** 请求类型 */
@property (nonatomic, assign) LJHttpRequestType requestType;
/** 地址 */
@property (nonatomic, copy) NSString *urlStr;
/** 参数 */
@property (nonatomic, copy) NSDictionary *params;
/** 是否携带token */
@property (nonatomic, assign) BOOL enableToken;
/** 上传或下载的进度回调 */
@property (nonatomic, copy) LJHttpRequestProgressCallback progressCallback;
/** 需要上传的文件列表 */
@property (nonatomic, copy) NSArray <LJHttpUploadModel *>*uploadFileList;


/**
 创建get请求

 @param urlStr 请求地址
 @param params 请求参数
 @return 请求对象
 */
+ (instancetype)requestGetWithUrlStr:(NSString *)urlStr andParams:(NSDictionary * _Nullable )params;

/**
 创建post请求

 @param urlStr 请求地址
 @param params 请求参数
 @return 请求对象
 */
+ (instancetype)requestPostWithUrlStr:(NSString *)urlStr andParams:(NSDictionary * _Nullable)params;


/**
 创建下载请求

 @param urlStr 请求地址
 @param progressCallback 下载进度的回调
 @return 请求对象
 */
+ (instancetype)downloadWithUrlStr:(NSString *)urlStr andProgressCallback:(LJHttpRequestProgressCallback)progressCallback;


/**
 创建上传请求

 @param urlStr 请求地址
 @param params 请求参数
 @param fileList 待上传的文件列表
 @param progressCallback 上传进度回调
 @return 请求实体
 */
+ (instancetype)uploadWithUrlStr:(NSString *)urlStr andParams:(NSDictionary * _Nullable)params andFileList:(NSArray <LJHttpUploadModel *>*)fileList andProgressCallback:(LJHttpRequestProgressCallback)progressCallback;
@end

NS_ASSUME_NONNULL_END
