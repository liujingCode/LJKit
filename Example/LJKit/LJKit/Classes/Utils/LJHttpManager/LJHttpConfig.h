//
//  LJHttpConfig.h
//  LJKit_Example
//
//  Created by developer on 2019/9/24.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LJHttpConfigResponseSerializerType) {
    LJHttpConfigResponseSerializerTypeJson,
    LJHttpConfigResponseSerializerTypeOther,
};

typedef NS_ENUM(NSUInteger, LJHttpConfigRequestSerializerType) {
    LJHttpConfigRequestSerializerTypeJson,
    LJHttpConfigRequestSerializerTypeOther,
};

@interface LJHttpConfig : NSObject
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
/** 响应格式 */
@property (nonatomic, assign) LJHttpConfigResponseSerializerType responseSerializerType;
/** 请求格式 */
@property (nonatomic, assign) LJHttpConfigRequestSerializerType requestSerializerType;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
