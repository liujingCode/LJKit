//
//  LJSandboxViewCell.h
//  LJKit_Example
//
//  Created by developer on 2019/9/11.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSandboxModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJSandboxViewCell : UITableViewCell
/** 文件或文件夹名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 大小 */
@property (nonatomic, weak) UILabel *sizeLabel;
@property (nonatomic, strong) LJSandboxModel *model;
@end

NS_ASSUME_NONNULL_END
