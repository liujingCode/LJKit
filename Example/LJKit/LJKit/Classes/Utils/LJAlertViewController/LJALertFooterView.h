//
//  LJAlertFooterView.h
//  LJKit_Example
//
//  Created by developer on 2019/9/27.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJAlertAction;
typedef void (^LJAlertFooterViewLayoutCompleteHandle)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LJAlertFooterView : UIScrollView
@property (nonatomic, strong) NSMutableArray <LJAlertAction *> *actions;
/// 取消的action 仅actionSheet有效
@property (nonatomic, strong) LJAlertAction *cancelAction;

///// 布局完成后的回调
//@property (nonatomic, copy) LJAlertFooterViewLayoutCompleteHandle layoutCompleteHandle;

@end


#pragma mark - LJAlertActionButton
@interface LJAlertActionButton : UIButton

@end

NS_ASSUME_NONNULL_END
