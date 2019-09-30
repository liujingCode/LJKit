//
//  LJAnimationView.m
//  LJKit_Example
//
//  Created by developer on 2019/9/29.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJAnimationView.h"

@implementation LJAnimationView


- (void)drawRect:(CGRect)rect {
    [self lj_animation];
}


- (void)lj_animation {
  //// Color Declarations
   UIColor* fillColor5 = [UIColor colorWithRed: 0.357 green: 0.361 blue: 0.361 alpha: 1];

   //// Bezier Drawing
   UIBezierPath* bezierPath = [UIBezierPath bezierPath];
   [bezierPath moveToPoint: CGPointMake(19.66, 14.5)];
   [bezierPath addCurveToPoint: CGPointMake(17.2, 13.16) controlPoint1: CGPointMake(18.84, 14.05) controlPoint2: CGPointMake(18.02, 13.61)];
   [bezierPath addLineToPoint: CGPointMake(13.11, 10.94)];
   [bezierPath addCurveToPoint: CGPointMake(12.65, 9.6) controlPoint1: CGPointMake(12.56, 10.63) controlPoint2: CGPointMake(12.33, 10.17)];
   [bezierPath addCurveToPoint: CGPointMake(14.03, 9.28) controlPoint1: CGPointMake(12.96, 9.03) controlPoint2: CGPointMake(13.48, 8.99)];
   [bezierPath addCurveToPoint: CGPointMake(23.6, 14.52) controlPoint1: CGPointMake(17.22, 11.02) controlPoint2: CGPointMake(20.42, 12.75)];
   [bezierPath addCurveToPoint: CGPointMake(26.41, 13.93) controlPoint1: CGPointMake(24.42, 14.97) controlPoint2: CGPointMake(25.89, 14.7)];
   [bezierPath addCurveToPoint: CGPointMake(31.29, 6.83) controlPoint1: CGPointMake(28.04, 11.57) controlPoint2: CGPointMake(29.66, 9.2)];
   [bezierPath addCurveToPoint: CGPointMake(31.46, 6.58) controlPoint1: CGPointMake(31.35, 6.74) controlPoint2: CGPointMake(31.4, 6.66)];
   [bezierPath addCurveToPoint: CGPointMake(32.93, 6.14) controlPoint1: CGPointMake(31.92, 5.94) controlPoint2: CGPointMake(32.45, 5.76)];
   [bezierPath addCurveToPoint: CGPointMake(33.03, 7.62) controlPoint1: CGPointMake(33.48, 6.58) controlPoint2: CGPointMake(33.39, 7.1)];
   [bezierPath addCurveToPoint: CGPointMake(31.06, 10.52) controlPoint1: CGPointMake(32.37, 8.59) controlPoint2: CGPointMake(31.71, 9.56)];
   [bezierPath addCurveToPoint: CGPointMake(28.21, 14.69) controlPoint1: CGPointMake(30.14, 11.86) controlPoint2: CGPointMake(29.23, 13.2)];
   [bezierPath addLineToPoint: CGPointMake(39.7, 14.69)];
   [bezierPath addCurveToPoint: CGPointMake(40.94, 15.93) controlPoint1: CGPointMake(40.77, 14.69) controlPoint2: CGPointMake(40.94, 14.86)];
   [bezierPath addCurveToPoint: CGPointMake(40.97, 37.97) controlPoint1: CGPointMake(40.95, 23.28) controlPoint2: CGPointMake(40.96, 30.62)];
   [bezierPath addCurveToPoint: CGPointMake(39.71, 39.21) controlPoint1: CGPointMake(40.97, 39.02) controlPoint2: CGPointMake(40.78, 39.2)];
   [bezierPath addCurveToPoint: CGPointMake(38.87, 39.2) controlPoint1: CGPointMake(39.43, 39.21) controlPoint2: CGPointMake(39.15, 39.24)];
   [bezierPath addCurveToPoint: CGPointMake(36.76, 40.44) controlPoint1: CGPointMake(37.86, 39.09) controlPoint2: CGPointMake(37.12, 39.19)];
   [bezierPath addCurveToPoint: CGPointMake(34.16, 42.03) controlPoint1: CGPointMake(36.44, 41.57) controlPoint2: CGPointMake(35.24, 42.14)];
   [bezierPath addCurveToPoint: CGPointMake(31.76, 39.99) controlPoint1: CGPointMake(32.9, 41.9) controlPoint2: CGPointMake(32.08, 41.16)];
   [bezierPath addCurveToPoint: CGPointMake(30.59, 39.19) controlPoint1: CGPointMake(31.56, 39.28) controlPoint2: CGPointMake(31.23, 39.19)];
   [bezierPath addCurveToPoint: CGPointMake(17.38, 39.2) controlPoint1: CGPointMake(26.19, 39.22) controlPoint2: CGPointMake(21.79, 39.21)];
   [bezierPath addCurveToPoint: CGPointMake(16.43, 39.86) controlPoint1: CGPointMake(16.87, 39.2) controlPoint2: CGPointMake(16.57, 39.24)];
   [bezierPath addCurveToPoint: CGPointMake(13.81, 42.04) controlPoint1: CGPointMake(16.11, 41.18) controlPoint2: CGPointMake(15.02, 42.02)];
   [bezierPath addCurveToPoint: CGPointMake(11.12, 39.88) controlPoint1: CGPointMake(12.57, 42.06) controlPoint2: CGPointMake(11.48, 41.25)];
   [bezierPath addCurveToPoint: CGPointMake(10.18, 39.2) controlPoint1: CGPointMake(10.96, 39.3) controlPoint2: CGPointMake(10.71, 39.17)];
   [bezierPath addCurveToPoint: CGPointMake(8.11, 39.2) controlPoint1: CGPointMake(9.49, 39.24) controlPoint2: CGPointMake(8.8, 39.21)];
   [bezierPath addCurveToPoint: CGPointMake(7.03, 38.14) controlPoint1: CGPointMake(7.36, 39.19) controlPoint2: CGPointMake(7.03, 38.88)];
   [bezierPath addCurveToPoint: CGPointMake(7.06, 15.72) controlPoint1: CGPointMake(7.04, 30.67) controlPoint2: CGPointMake(7.05, 23.2)];
   [bezierPath addCurveToPoint: CGPointMake(8.24, 14.69) controlPoint1: CGPointMake(7.06, 14.95) controlPoint2: CGPointMake(7.38, 14.69)];
   [bezierPath addCurveToPoint: CGPointMake(18.85, 14.69) controlPoint1: CGPointMake(11.78, 14.69) controlPoint2: CGPointMake(15.32, 14.69)];
   [bezierPath addLineToPoint: CGPointMake(19.6, 14.69)];
   [bezierPath addCurveToPoint: CGPointMake(19.66, 14.5) controlPoint1: CGPointMake(19.62, 14.63) controlPoint2: CGPointMake(19.64, 14.57)];
   [bezierPath closePath];
   [bezierPath moveToPoint: CGPointMake(39.24, 37.48)];
   [bezierPath addLineToPoint: CGPointMake(39.24, 16.36)];
   [bezierPath addLineToPoint: CGPointMake(8.84, 16.36)];
   [bezierPath addLineToPoint: CGPointMake(8.84, 37.48)];
   [bezierPath addLineToPoint: CGPointMake(39.24, 37.48)];
   [bezierPath closePath];
   [bezierPath moveToPoint: CGPointMake(14.82, 39.26)];
   [bezierPath addLineToPoint: CGPointMake(12.73, 39.26)];
   [bezierPath addCurveToPoint: CGPointMake(13.72, 40.31) controlPoint1: CGPointMake(12.87, 39.86) controlPoint2: CGPointMake(13.16, 40.28)];
   [bezierPath addCurveToPoint: CGPointMake(14.82, 39.26) controlPoint1: CGPointMake(14.34, 40.36) controlPoint2: CGPointMake(14.64, 39.9)];
   [bezierPath closePath];
   [bezierPath moveToPoint: CGPointMake(33.31, 39.25)];
   [bezierPath addCurveToPoint: CGPointMake(34.43, 40.31) controlPoint1: CGPointMake(33.52, 39.89) controlPoint2: CGPointMake(33.8, 40.36)];
   [bezierPath addCurveToPoint: CGPointMake(35.43, 39.25) controlPoint1: CGPointMake(35, 40.27) controlPoint2: CGPointMake(35.26, 39.84)];
   [bezierPath addLineToPoint: CGPointMake(33.31, 39.25)];
   [bezierPath closePath];
   [fillColor5 setFill];
   [bezierPath fill];


   //// Bezier 2 Drawing
   UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
   [bezier2Path moveToPoint: CGPointMake(24.07, 36.03)];
   [bezier2Path addLineToPoint: CGPointMake(11.85, 36.03)];
   [bezier2Path addCurveToPoint: CGPointMake(10.47, 34.65) controlPoint1: CGPointMake(10.66, 36.03) controlPoint2: CGPointMake(10.47, 35.84)];
   [bezier2Path addCurveToPoint: CGPointMake(10.5, 19.32) controlPoint1: CGPointMake(10.48, 29.54) controlPoint2: CGPointMake(10.48, 24.44)];
   [bezier2Path addCurveToPoint: CGPointMake(11.79, 18.02) controlPoint1: CGPointMake(10.5, 18.24) controlPoint2: CGPointMake(10.72, 18.02)];
   [bezier2Path addLineToPoint: CGPointMake(36.31, 18.02)];
   [bezier2Path addCurveToPoint: CGPointMake(37.62, 19.3) controlPoint1: CGPointMake(37.4, 18.02) controlPoint2: CGPointMake(37.62, 18.24)];
   [bezier2Path addCurveToPoint: CGPointMake(37.66, 34.71) controlPoint1: CGPointMake(37.64, 24.44) controlPoint2: CGPointMake(37.65, 29.57)];
   [bezier2Path addCurveToPoint: CGPointMake(36.3, 36.03) controlPoint1: CGPointMake(37.66, 35.81) controlPoint2: CGPointMake(37.43, 36.02)];
   [bezier2Path addLineToPoint: CGPointMake(24.07, 36.03)];
   [bezier2Path closePath];
   [bezier2Path moveToPoint: CGPointMake(35.82, 34.22)];
   [bezier2Path addLineToPoint: CGPointMake(35.82, 19.85)];
   [bezier2Path addLineToPoint: CGPointMake(12.29, 19.85)];
   [bezier2Path addLineToPoint: CGPointMake(12.29, 34.22)];
   [bezier2Path addLineToPoint: CGPointMake(35.82, 34.22)];
   [bezier2Path closePath];
   [fillColor5 setFill];
   [bezier2Path fill];


   //// Bezier 3 Drawing
   UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
   [bezier3Path moveToPoint: CGPointMake(24.17, 31.67)];
   [bezier3Path addCurveToPoint: CGPointMake(23.24, 32.32) controlPoint1: CGPointMake(23.86, 31.89) controlPoint2: CGPointMake(23.57, 32.14)];
   [bezier3Path addCurveToPoint: CGPointMake(20.06, 32.14) controlPoint1: CGPointMake(22.15, 32.9) controlPoint2: CGPointMake(21.07, 32.85)];
   [bezier3Path addCurveToPoint: CGPointMake(18.56, 28.91) controlPoint1: CGPointMake(18.96, 31.37) controlPoint2: CGPointMake(18.47, 30.23)];
   [bezier3Path addCurveToPoint: CGPointMake(19.41, 28.16) controlPoint1: CGPointMake(18.59, 28.63) controlPoint2: CGPointMake(19.11, 28.18)];
   [bezier3Path addCurveToPoint: CGPointMake(20.3, 28.88) controlPoint1: CGPointMake(19.71, 28.15) controlPoint2: CGPointMake(20.09, 28.56)];
   [bezier3Path addCurveToPoint: CGPointMake(20.52, 29.83) controlPoint1: CGPointMake(20.47, 29.13) controlPoint2: CGPointMake(20.4, 29.53)];
   [bezier3Path addCurveToPoint: CGPointMake(21.8, 30.82) controlPoint1: CGPointMake(20.75, 30.41) controlPoint2: CGPointMake(21.17, 30.95)];
   [bezier3Path addCurveToPoint: CGPointMake(23.04, 29.86) controlPoint1: CGPointMake(22.27, 30.72) controlPoint2: CGPointMake(22.69, 30.25)];
   [bezier3Path addCurveToPoint: CGPointMake(23.23, 28.99) controlPoint1: CGPointMake(23.21, 29.66) controlPoint2: CGPointMake(23.18, 29.28)];
   [bezier3Path addCurveToPoint: CGPointMake(24.19, 28.09) controlPoint1: CGPointMake(23.31, 28.42) controlPoint2: CGPointMake(23.63, 28.08)];
   [bezier3Path addCurveToPoint: CGPointMake(25.08, 28.96) controlPoint1: CGPointMake(24.69, 28.1) controlPoint2: CGPointMake(25.01, 28.41)];
   [bezier3Path addCurveToPoint: CGPointMake(25.34, 29.97) controlPoint1: CGPointMake(25.12, 29.31) controlPoint2: CGPointMake(25.13, 29.74)];
   [bezier3Path addCurveToPoint: CGPointMake(26.56, 30.8) controlPoint1: CGPointMake(25.67, 30.34) controlPoint2: CGPointMake(26.14, 30.78)];
   [bezier3Path addCurveToPoint: CGPointMake(27.71, 29.98) controlPoint1: CGPointMake(26.94, 30.81) controlPoint2: CGPointMake(27.41, 30.34)];
   [bezier3Path addCurveToPoint: CGPointMake(27.97, 28.96) controlPoint1: CGPointMake(27.91, 29.74) controlPoint2: CGPointMake(27.9, 29.31)];
   [bezier3Path addCurveToPoint: CGPointMake(28.95, 28.11) controlPoint1: CGPointMake(28.07, 28.41) controlPoint2: CGPointMake(28.38, 28.07)];
   [bezier3Path addCurveToPoint: CGPointMake(29.79, 29.1) controlPoint1: CGPointMake(29.52, 28.16) controlPoint2: CGPointMake(29.81, 28.52)];
   [bezier3Path addCurveToPoint: CGPointMake(27.82, 32.38) controlPoint1: CGPointMake(29.73, 30.55) controlPoint2: CGPointMake(29.16, 31.73)];
   [bezier3Path addCurveToPoint: CGPointMake(24.36, 31.8) controlPoint1: CGPointMake(26.56, 32.99) controlPoint2: CGPointMake(25.39, 32.73)];
   [bezier3Path addCurveToPoint: CGPointMake(24.17, 31.67) controlPoint1: CGPointMake(24.31, 31.76) controlPoint2: CGPointMake(24.24, 31.72)];
   [bezier3Path closePath];
   [bezier3Path moveToPoint: CGPointMake(34.21, 26.23)];
   [bezier3Path addCurveToPoint: CGPointMake(32.87, 27.2) controlPoint1: CGPointMake(34.23, 27.09) controlPoint2: CGPointMake(33.52, 27.57)];
   [bezier3Path addCurveToPoint: CGPointMake(27.72, 24.11) controlPoint1: CGPointMake(31.14, 26.2) controlPoint2: CGPointMake(29.42, 25.16)];
   [bezier3Path addCurveToPoint: CGPointMake(27.44, 22.91) controlPoint1: CGPointMake(27.27, 23.83) controlPoint2: CGPointMake(27.17, 23.38)];
   [bezier3Path addCurveToPoint: CGPointMake(28.62, 22.57) controlPoint1: CGPointMake(27.7, 22.44) controlPoint2: CGPointMake(28.18, 22.32)];
   [bezier3Path addCurveToPoint: CGPointMake(33.84, 25.69) controlPoint1: CGPointMake(30.37, 23.58) controlPoint2: CGPointMake(32.11, 24.62)];
   [bezier3Path addCurveToPoint: CGPointMake(34.21, 26.23) controlPoint1: CGPointMake(34.04, 25.82) controlPoint2: CGPointMake(34.13, 26.12)];
   [bezier3Path closePath];
   [bezier3Path moveToPoint: CGPointMake(19.37, 22.92)];
   [bezier3Path addCurveToPoint: CGPointMake(19.98, 23.58) controlPoint1: CGPointMake(19.53, 23.08) controlPoint2: CGPointMake(19.94, 23.3)];
   [bezier3Path addCurveToPoint: CGPointMake(19.61, 24.59) controlPoint1: CGPointMake(20.03, 23.9) controlPoint2: CGPointMake(19.86, 24.46)];
   [bezier3Path addCurveToPoint: CGPointMake(14.99, 26.75) controlPoint1: CGPointMake(18.1, 25.37) controlPoint2: CGPointMake(16.55, 26.06)];
   [bezier3Path addCurveToPoint: CGPointMake(13.88, 26.29) controlPoint1: CGPointMake(14.52, 26.96) controlPoint2: CGPointMake(14, 26.8)];
   [bezier3Path addCurveToPoint: CGPointMake(14.19, 25.19) controlPoint1: CGPointMake(13.8, 25.95) controlPoint2: CGPointMake(13.95, 25.32)];
   [bezier3Path addCurveToPoint: CGPointMake(18.94, 22.98) controlPoint1: CGPointMake(15.74, 24.4) controlPoint2: CGPointMake(17.35, 23.71)];
   [bezier3Path addCurveToPoint: CGPointMake(19.37, 22.92) controlPoint1: CGPointMake(19.01, 22.95) controlPoint2: CGPointMake(19.09, 22.96)];
   [bezier3Path closePath];
   [fillColor5 setFill];
   [bezier3Path fill];

}



@end
