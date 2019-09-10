//
//  UIBarButtonItem+LJKit.m
//  LJKit_Example
//
//  Created by developer on 2019/7/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "UIBarButtonItem+LJKit.h"

@implementation UIBarButtonItem (LJKit)
+ (instancetype)lj_itemWithTitle:(NSString *)title {
    return [self lj_itemWithTitle:title andSelectedTitle:nil andImageName:nil andSelectedImageName:nil];
}
+ (instancetype)lj_itemWithImageName:(NSString *)imageName {
     return [self lj_itemWithTitle:nil andSelectedTitle:nil andImageName:imageName andSelectedImageName:nil];
}
+ (instancetype)lj_itemWithTitle:(NSString *)title andSelectedTitle:(NSString *)selectedTitle andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (selectedTitle) {
        [btn setTitle:selectedTitle forState:UIControlStateSelected];
    }
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 0, btn.frame.size.width, 44.0);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
