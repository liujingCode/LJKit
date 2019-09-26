////  UIView+LJKit.m
//  LJKit_Example
//  Created by liujing on 2019/5/13.
//  Copyright © 2019 185704108@qq.com. All rights reserved.

#import "UIView+LJKit.h"
#pragma mark - UIView+LJKit
@implementation UIView (LJKit)

@end

#pragma mark - UIView+LJFrame
@implementation UIView (LJFrame)
- (void)setLj_width:(CGFloat)lj_width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lj_width, self.frame.size.height);
}
- (CGFloat)lj_width {
    return self.frame.size.width;
}

- (void)setLj_height:(CGFloat)lj_height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, lj_height);
}
- (CGFloat)lj_height {
    return self.frame.size.height;
}

- (void)setLj_x:(CGFloat)lj_x {
    self.frame = CGRectMake(lj_x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)lj_x {
    return self.frame.origin.x;
}

- (void)setLj_y:(CGFloat)lj_y {
    self.frame = CGRectMake(self.frame.origin.x, lj_y, self.frame.size.width, self.frame.size.height);
}
- (CGFloat)lj_y {
    return self.frame.origin.y;
}

- (void)setLj_centerX:(CGFloat)lj_centerX {
    self.center = CGPointMake(lj_centerX, self.center.y);
}
- (CGFloat)lj_centerX {
    return self.center.x;
}

- (void)setLj_centerY:(CGFloat)lj_centerY {
    self.center = CGPointMake(self.center.x, lj_centerY);
}
- (CGFloat)lj_centerY {
    return self.center.y;
}

- (void)setLj_size:(CGSize)lj_size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lj_size.width, lj_size.height);
}
- (CGSize)lj_size {
    return self.frame.size;
}

- (void)setLj_origin:(CGPoint)lj_origin {
    self.frame = CGRectMake(lj_origin.x, lj_origin.y, self.frame.size.width, self.frame.size.height);
}
- (CGPoint)lj_origin {
    return self.frame.origin;
}




#pragma mark - Layer相关
- (void)setLj_cornerRadius:(CGFloat)lj_cornerRadius {
    self.layer.cornerRadius = lj_cornerRadius;
}
- (CGFloat)lj_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setLj_borderColor:(UIColor *)lj_borderColor {
    self.layer.borderColor = lj_borderColor.CGColor;
}
- (UIColor *)lj_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setLj_borderWidth:(CGFloat)lj_borderWidth {
    self.layer.borderWidth = lj_borderWidth;
}
- (CGFloat)lj_borderWidth {
    return self.layer.borderWidth;
}

- (void)setLj_shadowOpacity:(CGFloat)lj_shadowOpacity {
    self.layer.shadowOpacity = lj_shadowOpacity;
}
- (CGFloat)lj_shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setLj_shadowOffset:(CGSize)lj_shadowOffset {
    self.layer.shadowOffset = lj_shadowOffset;
}
- (CGSize)lj_shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setLj_shadowRadius:(CGFloat)lj_shadowRadius {
    self.layer.shadowRadius = lj_shadowRadius;
}
- (CGFloat)lj_shadowRadius {
    return self.layer.shadowRadius;
}


#pragma mark - 获取当前的的controller
- (UIViewController *)lj_get_currentController; {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
