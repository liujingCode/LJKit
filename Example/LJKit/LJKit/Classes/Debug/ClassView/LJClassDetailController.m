//
//  LJClassDetailController.m
//  LJKit_Example
//
//  Created by developer on 2019/9/12.
//  Copyright © 2019 liujing. All rights reserved.
//



#import "LJClassDetailController.h"

@interface LJClassDetailController ()
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UITableView *tableView;
/** 隐藏或显示父类 */
@property (nonatomic, weak) UIButton *superEnableBtn;
/** 文本或列表显示 */
@property (nonatomic, weak) UIButton *showTypeBtn;
/** class详情 */
@property (nonatomic, copy) NSString *classDetail;
@end

@implementation LJClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"class详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *classDetail = [[self.targetClass new] lj_methodListWithContainSuperClass:NO];
    
    NSString *ivar = [[self.targetClass new] lj_ivarList];
    
    NSArray *arr = [ivar componentsSeparatedByString:@"\n"];
    
    [classDetail substringFromIndex:1];
    
//    NSString *testStr = @"protocol://customProtocol|title=this is title|message=this is message|shareUrl=this is url";
    // 获取 前缀为<,后缀为>  获取中间的内容(包含<和>)
    
    /*
     @"in .*?:"         匹配所有的类           匹配结果: in NSObject:
     @"\\+ \\(.*?;"     匹配所有的类方法        匹配结果: + (id) test;
     @"\\- \\(.*?;"     匹配所有的对象方法
     */
    NSString *parten = @"\\- \\(.*?;";
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:&error]; //options 根据自己需求选择
    
    NSArray *matches = [reg matchesInString:classDetail options:NSMatchingReportCompletion range:NSMakeRange(0, classDetail.length)];
    
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range]; //获取所匹配的最长字符串
        for (int i = 0; i < match.numberOfRanges; i++) {
            NSRange matchRange = [match rangeAtIndex:i];
            NSString *matchString = [classDetail substringWithRange:matchRange];
            NSLog(@"index:%@, %@", @(i), matchString);
        }
    }
    
    [self setupNav];
    
    self.showTypeBtn.hidden = YES;
    [self clickSuperEnableBtn:self.superEnableBtn];
    
}

- (void)setupNav {
    // 是否显示父类属性和方法
    UIButton *superEnableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [superEnableBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1.0] forState:UIControlStateNormal];
    [superEnableBtn setTitle:@"显示父类" forState:UIControlStateNormal];
    [superEnableBtn setTitle:@"隐藏父类" forState:UIControlStateSelected];
    [superEnableBtn addTarget:self action:@selector(clickSuperEnableBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superEnableBtn sizeToFit];
    self.superEnableBtn = superEnableBtn;
    
    
    UIButton *showTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showTypeBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1.0] forState:UIControlStateNormal];
    [showTypeBtn setTitle:@"列表" forState:UIControlStateNormal];
    [showTypeBtn setTitle:@"文本" forState:UIControlStateNormal];
    [showTypeBtn addTarget:self action:@selector(clickShowTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [showTypeBtn sizeToFit];
    self.showTypeBtn = showTypeBtn;
    
    UIBarButtonItem *right1Item = [[UIBarButtonItem alloc] initWithCustomView:superEnableBtn];
    UIBarButtonItem *right2Item = [[UIBarButtonItem alloc] initWithCustomView:showTypeBtn];
    
    self.navigationItem.rightBarButtonItems = @[right1Item,right2Item];
}

#pragma mark - 点击按钮
- (void)clickSuperEnableBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self showText];
}

- (void)clickShowTypeBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        
    } else {
        
    }
}

// 展示详情
- (void)showText {
    self.tableView.hidden = YES;
    self.textView.hidden = NO;
    self.classDetail = [[self.targetClass new] lj_methodListWithContainSuperClass:self.superEnableBtn.selected];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    label.numberOfLines = 0;
    label.text = self.classDetail;
    [label sizeToFit];
    self.textView.text = self.classDetail;
}

- (void)showList{
    self.textView.hidden = YES;
    self.tableView.hidden = NO;
    
}

//#pragma mark - 正则匹配对象方法和类方法
//- (void)test {
//    NSString *parten = @"\\- \\(.*?;";
//    NSError *error = nil;
//    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:&error]; //options 根据自己需求选择
//    
//    NSArray *matches = [reg matchesInString:classDetail options:NSMatchingReportCompletion range:NSMakeRange(0, classDetail.length)];
//    
//    for (NSTextCheckingResult *match in matches) {
//        //NSRange matchRange = [match range]; //获取所匹配的最长字符串
//        for (int i = 0; i < match.numberOfRanges; i++) {
//            NSRange matchRange = [match rangeAtIndex:i];
//            NSString *matchString = [classDetail substringWithRange:matchRange];
//            NSLog(@"index:%@, %@", @(i), matchString);
//        }
//    }
//}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        
    }
    return _tableView;
}
- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        textView.font = [UIFont systemFontOfSize:13.0];
        textView.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        [self.view addSubview:textView];
        _textView = textView;
    }
    return _textView;
}
@end



