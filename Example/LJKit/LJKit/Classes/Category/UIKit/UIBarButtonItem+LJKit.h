//
//  UIBarButtonItem+LJKit.h
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (LJKit)
+ (instancetype)lj_itemWithTitle:(NSString *)title;
+ (instancetype)lj_itemWithImageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
