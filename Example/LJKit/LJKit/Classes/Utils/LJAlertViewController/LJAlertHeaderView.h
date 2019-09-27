//
//  LJAlertHeaderView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJAlertHeaderView : UIScrollView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, weak,readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UILabel *messageLabel;
@end

NS_ASSUME_NONNULL_END
