//
//  LJAlertAction.h
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LJAlertActionConfigHandle)(UIButton *button);
typedef void(^LJAlertActionClickHandle)(UIButton *button);
@interface LJAlertAction : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;


/// 字体
@property (nonatomic, strong) UIFont *font;
@end

NS_ASSUME_NONNULL_END
