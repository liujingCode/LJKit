//
//  LJHttpUploadModel.h
//  LJApp
//
//  Created by developer on 2019/8/26.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJHttpUploadModel : NSObject
/** 文件名 */
@property (nonatomic, copy) NSString * _Nonnull fileName;
/** 文件 */
@property (nonatomic, strong) NSData * _Nonnull data;
/** 文件类型 */
@property (nonatomic, copy) NSString * _Nonnull fileType;
/** 指定的key */
@property (nonatomic, copy) NSString * _Nonnull key;
@end

NS_ASSUME_NONNULL_END
