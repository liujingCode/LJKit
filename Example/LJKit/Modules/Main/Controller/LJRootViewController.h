//
//  LJRootViewController.h
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJNavigationBarContnetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJRootViewController : UINavigationController
/** 自定义navigationBar */
@property (nonatomic, weak) LJNavigationBarContnetView *navigationBarContnetView;
@end

NS_ASSUME_NONNULL_END
