//
//  LJAlertContainerView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJAlertHeaderView.h"
#import "LJAlertFooterView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LJAlertContainerView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray <LJAlertAction *> *actions;
@property (nonatomic, strong) NSMutableArray <UITextField *> *textFields;
/// 布局完成后的回调
@property (nonatomic, copy) LJAlertFooterViewLayoutCompleteHandle layoutCompleteHandle;


@end

NS_ASSUME_NONNULL_END
