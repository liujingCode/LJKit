////  UIImage+LJKit.m
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import "UIImage+LJKit.h"

@implementation UIImage (LJKit)

+ (instancetype)lj_imageWithColor:(UIColor *)color {
    return [self lj_imageWithSize:CGSizeMake(1, 1) andColor:color];
}

+ (instancetype)lj_imageWithSize:(CGSize)size andColor:(UIColor *)color {
    float scale = [UIScreen mainScreen].scale;
    scale = 1.0;
    CGSize targetSize = CGSizeMake(size.width * scale, size.height * scale);
    UIGraphicsBeginImageContext(targetSize);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, targetSize.width, targetSize.height));
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)lj_imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f,0.f,self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path addClip];
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
