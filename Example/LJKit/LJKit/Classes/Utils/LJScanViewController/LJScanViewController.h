//
//  LJScanViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
/**
 聚焦模式
 */
typedef NS_ENUM(NSUInteger, LJScanFocusMode) {
    LJScanFocusModeA,

};

@interface LJScanViewController : UIViewController
/// 是否正在扫描
@property (nonatomic, assign,readonly) BOOL scanning;
/// 扫描范围
@property (nonatomic, assign,readonly) CGRect scanRect;
/// 闪光灯
@property (nonatomic, assign) BOOL torch;
/// 聚焦模式
@property (nonatomic, assign) LJScanFocusMode focusMode;

#pragma mark - 需子类重写的配置
/// 扫描范围
- (CGRect)scanRect;

@end

NS_ASSUME_NONNULL_END
