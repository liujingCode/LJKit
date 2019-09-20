//
//  LJCrashAlertView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/17.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJCrashAlertView : UIView
@property (nonatomic, copy) NSString *crashInfo;
/** <#注释#> */
@property (nonatomic, copy) void (^actionCallback) (NSInteger index);
@end

NS_ASSUME_NONNULL_END
