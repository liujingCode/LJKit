//
//  LJHttpManager.m
//  LJApp
//
//  Created by developer on 2019/8/26.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJHttpManager.h"

@implementation LJHttpManager
+ (instancetype)sharedInstance {
    static LJHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LJHttpManager alloc] initWithBaseURL:nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypes = [NSMutableSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"application/pdf", @"audio/mpeg",nil];
        [contentTypes setByAddingObjectsFromSet:manager.responseSerializer.acceptableContentTypes];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    return manager;
}



+ (NSURLSessionDataTask *)requestWithRequest:(LJHttpRequest *)request andCallback:(LJHttpCallback)callback {
    if (!request) {
        return nil;
    }
    LJHttpManager *manager = [LJHttpManager sharedInstance];
    NSString *urlStr = [self setupUrlStrWith:request.urlStr];
    NSDictionary *params = [self setupAllParamsWithParams:request.params];
    
    // get
    if (request.requestType == LJHttpRequestTypeGet) {
        return [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (request.progressCallback) {
                request.progressCallback(downloadProgress.fractionCompleted);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:responseObject andError:nil andTask:task andCallback:callback];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:nil andError:error andTask:task andCallback:callback];
        }];
    }
    
    // post
    if (request.requestType == LJHttpRequestTypePost) { // post
        return [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            if (request.progressCallback) {
                request.progressCallback(uploadProgress.fractionCompleted);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:responseObject andError:nil andTask:task andCallback:callback];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:nil andError:error andTask:task andCallback:callback];
        }];
    }
    
    // 上传
    if (request.requestType == LJHttpRequestTypeUpload) {
        return [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (LJHttpUploadModel *uploadModel in request.uploadFileList) {
                [formData appendPartWithFileData:uploadModel.data name:uploadModel.key fileName:uploadModel.fileName mimeType:uploadModel.fileType];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (request.progressCallback) {
                request.progressCallback(uploadProgress.fractionCompleted);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:responseObject andError:nil andTask:task andCallback:callback];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self setupCallbackWithUrlStr:urlStr andParams:params andResponse:nil andError:error andTask:task andCallback:callback];
        }];
    }
    return nil;
}

+ (NSURLSessionDownloadTask *)downloadWithRequest:(LJHttpRequest *)request andDestination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                andCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    LJHttpManager *manager = [LJHttpManager sharedInstance];
    NSString *urlStr = [self setupUrlStrWith:request.urlStr];
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        /*
         如果header没有 Content-Length, 则不执行该回调
         "Content-Length" =     (
         
         );
         */
        if (request.progressCallback) {
            request.progressCallback(downloadProgress.fractionCompleted);
        }
    } destination:destination
    completionHandler:completionHandler];
    
    [downloadTask resume];
    return downloadTask;
    
//    [manager dataTaskWithRequest:downloadRequest uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//        if (request.progressCallback) {
//            request.progressCallback(downloadProgress.fractionCompleted);
//        }
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//    }];
//    return nil;
}


#pragma mark - 处理url
// 统一处理Url
+ (NSString *)setupUrlStrWith:(NSString *)urlStr {
    LJHttpManager *manager = [LJHttpManager sharedInstance];
    NSString *formatUrlStr = @"";
    if ([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"]) {
        formatUrlStr = urlStr;
    } else {
        formatUrlStr = [NSString stringWithFormat:@"%@%@",manager.hostStr,urlStr];
    }
    return formatUrlStr;
}

#pragma mark - 处理params
// 统一处理参数
+ (NSDictionary *)setupAllParamsWithParams:(NSDictionary *)params {
    LJHttpManager *manager = [LJHttpManager sharedInstance];
    // 参数
    NSMutableDictionary *tempParams = [NSMutableDictionary dictionary];
    if (manager.defaultParamsEnable) {
        for (NSString *key in manager.defaultParams) {
            [tempParams setObject:manager.defaultParams[key] forKey:key];
        }
    }
    for (NSString *key in params) {
        [tempParams setObject:params[key] forKey:key];
    }
    if (manager.tokenEnable && (manager.token.length > 0)) {
        [tempParams setObject:manager.token forKey:@"token"];
    }
    return tempParams.mutableCopy;
}

#pragma mark - 处理回调
// 统一处理网络请求回调
+ (void)setupCallbackWithUrlStr:(NSString *)urlStr andParams:(NSDictionary *)params andResponse:(id _Nullable )response andError:(NSError * _Nullable)error andTask:(NSURLSessionDataTask *)task andCallback:(LJHttpCallback)callback{
    
    NSString *paramsString = @"";
    id responseString = response;
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        paramsString = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];
    }
    
    if ([response isKindOfClass:[NSDictionary class]] || [response isKindOfClass:[NSArray class]]) {
        NSData *responseData = [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil];
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }
//    LJKitLog(@"http:\n url = %@\n params = %@\n response = %@",urlStr,paramsString,responseString);
    // 处理回调
    if (!callback) {
        return;
    }
    callback(response,error,task);
}


#pragma mark - 字符串转json
+ (NSDictionary *)dictionaryWithJsonStr:(NSString *)jsonStr {
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    return dic;
}
@end
