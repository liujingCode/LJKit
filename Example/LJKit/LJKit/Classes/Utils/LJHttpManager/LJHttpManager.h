//
//  LJHttpManager.h
//  LJApp
//
//  Created by developer on 2019/8/26.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "LJHttpRequest.h"
#import "LJHttpResponse.h"

NS_ASSUME_NONNULL_BEGIN


/**
 网络请求的回调

 @param response 响应值
 @param error error
 @param task 任务
 */
typedef void(^LJHttpCallback)(id  _Nullable response, NSError * _Nullable error,NSURLSessionDataTask * _Nonnull task);

/**
 网络请求类
 */
@interface LJHttpManager : AFHTTPSessionManager
/** host */
@property (nonatomic, copy) NSString *hostStr;
/** 请求超时时间 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/** 默认参数 */
@property (nonatomic, copy) NSDictionary *defaultParams;
/** token */
@property (nonatomic, copy) NSString *token;
/** 是否激活默认参数 */
@property (nonatomic, assign) BOOL defaultParamsEnable;
/** 是否激活token */
@property (nonatomic, assign) BOOL tokenEnable;


/**
 初始化
 
 @return 单例对象
 */
+ (instancetype)sharedInstance;

/**
 get、post、上传

 @param request 请求对象
 @param callback 结果回调
 @return task
 */
+ (NSURLSessionDataTask * )requestWithRequest:(LJHttpRequest *)request andCallback:(LJHttpCallback)callback;


/**
 下载

 @param request 请求对象
 @param callback 结果回调
 @return task
 */
+ (NSURLSessionDownloadTask *)downloadWithRequest:(LJHttpRequest *)request andDestination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                             andCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
