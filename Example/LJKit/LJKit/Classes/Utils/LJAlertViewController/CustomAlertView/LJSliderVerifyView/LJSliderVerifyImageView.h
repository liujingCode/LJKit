//
//  LJSliderVerifyImageView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJSliderVerifyImageView : UIView
/// 需要验证的图片
@property (nonatomic, strong) UIImage *verifyImage;

/// 需要验证的值  0 < x < self.width - 40, 0 < y < self.Height - 40
@property (nonatomic, assign) CGPoint verifyPoint;
/// 当前的值 坐标X的值
@property (nonatomic, assign) CGFloat currentValue;

- (void)showVerifyFailure;
- (void)showVerifySuccess;
@end

NS_ASSUME_NONNULL_END
