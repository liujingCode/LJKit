//
//  LJSliderVerifySliderView.h
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJSliderVerifySliderView : UIView
/// 滑动的回调
@property (nonatomic, copy) void (^touchMovedCallback) (CGFloat sliderValue, BOOL isEnd);
- (void)showVerifyFailure;
- (void)showVerifySuccess;
@end

NS_ASSUME_NONNULL_END
