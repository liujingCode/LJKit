//
//  LJTabBarItem.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 185704108@qq.com. All rights reserved.
//

#import "LJTabBarItem.h"

@implementation LJTabBarItem
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    if (self = [super initWithTitle:title image:image selectedImage:selectedImage]) {
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
        NSDictionary *titleAttributes_normal = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
        [self setTitleTextAttributes:titleAttributes_normal forState:UIControlStateNormal];
        
        NSDictionary *titleAttributes_selected = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
        [self setTitleTextAttributes:titleAttributes_selected forState:UIControlStateSelected];
    }
    return self;
}
@end
