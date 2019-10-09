//
//  LJSliderVerifyView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJSliderVerifyView : UIView
/// 需要验证的图片
@property (nonatomic, strong) UIImage *verifyImage;
//// 验证结果的回调
@property (nonatomic, copy) void (^resultHandle) (BOOL success);
/// 点击关闭的回调
@property (nonatomic, copy) void (^closeHandle) (void);
/// 点击刷新的回调
@property (nonatomic, copy) void (^updateHandle) (void);
@end

NS_ASSUME_NONNULL_END
