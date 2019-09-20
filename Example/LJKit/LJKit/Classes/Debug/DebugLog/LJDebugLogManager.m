//
//  LJDebugLogManager.m
//  LJKit_Example
//
//  Created by developer on 2019/9/16.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJDebugLogManager.h"
#import "LJDebugLogView.h"

@interface LJDebugLogManager ()

/** 定时器 */
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, weak) LJDebugLogView *logView;



@end

@implementation LJDebugLogManager

+ (instancetype)sharedManager {
    static LJDebugLogManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LJDebugLogManager new];
    });
    return instance;
}

+ (void)show {
    
    LJDebugLogView *logView = [[LJDebugLogView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:logView];
    LJDebugLogManager *manager = [LJDebugLogManager sharedManager];
    manager.logView = logView;

    [manager displayLink];
}

+ (void)dismiss {
    LJDebugLogManager *manager = [LJDebugLogManager sharedManager];
    [manager.logView removeFromSuperview];
    manager.logView = nil;
}


- (void)updateDate {
    NSString *text = [[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];

    NSLog(@"===%@===",[NSDate date]);
    self.logView.logStr = text;
}



- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDate)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink = displayLink;
    }
    return _displayLink;
}

- (NSString *)filePath {
    if (!_filePath) {
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fileName = @"test.txt";
        _filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    }
    return _filePath;
}
@end
