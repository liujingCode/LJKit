//
//  LJHttpRequest.m
//  LJApp
//
//  Created by developer on 2019/8/26.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJHttpRequest.h"

@implementation LJHttpRequest
+ (instancetype)requestGetWithUrlStr:(NSString *)urlStr andParams:(NSDictionary *)params {
    return [self requestWithType:LJHttpRequestTypeGet andUrlStr:urlStr andParams:params andProgressCallback:nil andFileList:nil];
}
+ (instancetype)requestPostWithUrlStr:(NSString *)urlStr andParams:(NSDictionary *)params {
    return [self requestWithType:LJHttpRequestTypePost andUrlStr:urlStr andParams:params andProgressCallback:nil andFileList:nil];
}
+ (instancetype)downloadWithUrlStr:(NSString *)urlStr andProgressCallback:(LJHttpRequestProgressCallback)progressCallback {
    return [self requestWithType:LJHttpRequestTypeDownload andUrlStr:urlStr andParams:nil andProgressCallback:progressCallback andFileList:nil];
}
+ (instancetype)uploadWithUrlStr:(NSString *)urlStr andParams:(NSDictionary *)params andFileList:(NSArray <LJHttpUploadModel *>*)fileList andProgressCallback:(LJHttpRequestProgressCallback)progressCallback {
    return [self requestWithType:LJHttpRequestTypeUpload andUrlStr:urlStr andParams:params andProgressCallback:progressCallback andFileList:fileList];
}

+ (instancetype)requestWithType:(LJHttpRequestType)type andUrlStr:(NSString *)urlStr andParams:(NSDictionary *)params andProgressCallback:(LJHttpRequestProgressCallback)progressCallback andFileList:(NSArray <LJHttpUploadModel *>*)fileList {
    LJHttpRequest *request = [[LJHttpRequest alloc] init];
    request.requestType = type;
    request.urlStr = urlStr;
    request.params = params;
    request.progressCallback = progressCallback;
    request.uploadFileList = fileList;
    return request;
}

- (void)test1 {
    
    
}

@end
