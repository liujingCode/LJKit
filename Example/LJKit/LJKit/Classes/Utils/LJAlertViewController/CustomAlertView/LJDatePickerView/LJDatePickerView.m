//
//  LJDatePickerView.m
//  LJKit_Example
//
//  Created by developer on 2019/10/9.
//  Copyright © 2019 liujing. All rights reserved.


#import "LJDatePickerView.h"
#import <Masonry/Masonry.h>
@interface LJDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

// 取消按钮
@property (weak, nonatomic) UIButton *cancelBtn;
// 确定按钮
@property (weak, nonatomic) UIButton *confirmBtn;
// 工具条
@property (weak, nonatomic) UIView *headView;
// 选择器
@property (weak, nonatomic) UIPickerView *pickerView;


@property (copy, nonatomic) NSArray <NSArray *>*dataArray;

@property (assign, nonatomic) NSInteger year; //选中年
@property (assign, nonatomic) NSInteger month; //选中月
@property (assign, nonatomic) NSInteger day; //选中日
@property (assign, nonatomic) NSInteger hour; //选中时
@property (assign, nonatomic) NSInteger minute; //选中分

@property (assign, nonatomic) NSInteger maxYear; // 最大
@property (assign, nonatomic) NSInteger maxMonth; //选中月
@property (assign, nonatomic) NSInteger maxDay; //选中日
@property (assign, nonatomic) NSInteger maxHour; //选中时
@property (assign, nonatomic) NSInteger maxMinute; //选中分

@property (assign, nonatomic) NSInteger minYear; // 最小
@property (assign, nonatomic) NSInteger minMonth; //选中月
@property (assign, nonatomic) NSInteger minDay; //选中日
@property (assign, nonatomic) NSInteger minHour; //选中时
@property (assign, nonatomic) NSInteger minMinute; //选中分
@end
@implementation LJDatePickerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViewLayout];
        NSDate *currentDate = [NSDate date];
        NSDictionary *currentDateDict = [LJDatePickerView lj_getDateDictWithDate:currentDate];
        
        self.year = [[currentDateDict valueForKey:@"yyyy"] integerValue];
        self.month = [[currentDateDict valueForKey:@"MM"] integerValue];;
        self.day = [[currentDateDict valueForKey:@"dd"] integerValue];;
        self.hour = [[currentDateDict valueForKey:@"hh"] integerValue];;
        self.minute = [[currentDateDict valueForKey:@"mm"] integerValue];;
        
        
        self.maxYear = self.year;
        self.maxMonth = self.month;
        self.maxDay = self.day;
        self.maxHour = self.hour;
        self.maxMinute = self.minute;
        
        NSDictionary *minDateDict = [LJDatePickerView lj_getDateDictWithDate:[LJDatePickerView lj_dateWithYearsBeforeNow:10 andDate:currentDate]];
        
        self.minYear = [[minDateDict valueForKey:@"yyyy"] integerValue];
        self.minMonth = [[minDateDict valueForKey:@"MM"] integerValue];
        self.minDay = [[minDateDict valueForKey:@"dd"] integerValue];
        self.minHour = [[minDateDict valueForKey:@"hh"] integerValue];
        self.minMinute = [[minDateDict valueForKey:@"mm"] integerValue];
        
        
        
        // 默认选取最大值
        for (int i = 0; i < self.dataArray.count; i ++) {
            [self.pickerView selectRow:self.dataArray[i].count - 1 inComponent:i animated:NO];
        }

    }
    return self;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSArray *year = [self getYearList];
        NSArray *month = [self getMonthList];
        NSArray *day = [self getDayList];
        NSArray *hour = [self getHourList];
        NSArray *minute = [self getMinuteList];
        
        NSArray *arr = @[year,month,day,hour,minute];
        _dataArray = arr;
    }
    return _dataArray;
}

#pragma mark - 点击按钮
- (void)clickCancelBtn:(UIButton *)sender {
    if (self.actionHandle) {
        self.actionHandle(YES, nil);
    }
}

- (void)clickConfirmBtn:(UIButton *)sender {
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",self.year,self.month,self.day,self.hour,self.minute];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm";
    if (self.actionHandle) {
        self.actionHandle(NO, [dateFormatter dateFromString:dateStr]);
    }
}


#pragma mark - UIPickerView Delegate and Datasource
/// UIPickerView返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    // 年月时分秒
    return self.dataArray.count;
}

/// UIPickerView返回每组多少条数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.dataArray[component] count];
}

/// UIPickerView选择哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *temp = @"";
    if (row < self.dataArray[component].count) {
        temp = self.dataArray[component][row];
    } else {
    }
    
    if (component == 0) { // 年
        self.year = [[temp stringByReplacingOccurrencesOfString:@"年" withString:@""] integerValue];
    } else if (component == 1) { // 月
        self.month = [[temp stringByReplacingOccurrencesOfString:@"月" withString:@""] integerValue];
    } else if (component == 2) { // 日
        self.day = [[temp stringByReplacingOccurrencesOfString:@"日" withString:@""] integerValue];
    } else if (component == 3) { // 时
        self.hour = [[temp stringByReplacingOccurrencesOfString:@"时" withString:@""] integerValue];
    } else if (component == 4) { // 分
        self.minute = [[temp stringByReplacingOccurrencesOfString:@"分" withString:@""] integerValue];
    }
    
    if (component < self.dataArray.count - 1) {
        [self replaceDataWithIndex:component + 1];
        NSInteger currentMonth = [pickerView selectedRowInComponent:component + 1];
        [self pickerView:pickerView didSelectRow:currentMonth inComponent:component + 1];
    }
}

// UIPickerView返回每一行数据
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.dataArray[component] objectAtIndex:row];
}
// UIPickerView返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
// UIPickerView返回每一行的View
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *titleLbl;
    if (!view) {
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
        titleLbl.font = [UIFont systemFontOfSize:15];
        titleLbl.textAlignment = NSTextAlignmentCenter;
    } else {
        titleLbl = (UILabel *)view;
    }
    if (self.dataArray[component].count) {
        titleLbl.text = self.dataArray[component][row];
    } else {
        return nil;
    }
    

    return titleLbl;
}



#pragma mark - 设置UI布局
- (void)setupSubViewLayout {
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).offset(20);
        make.top.bottom.equalTo(self.headView);
        make.width.mas_equalTo(50);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView).offset(-20);
        make.top.bottom.equalTo(self.headView);
        make.width.mas_equalTo(50);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom);
    }];
}


#pragma mark - 初始化数据
// 获取年
- (NSArray *)getYearList {
    NSMutableArray *marr = [NSMutableArray array];
        for (NSInteger i = self.minYear; i <= self.maxYear; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%ld年", i]];
        }
    return [NSArray arrayWithArray:marr];
}

// 获取月
- (NSArray *)getMonthList {
    NSMutableArray *marr = [NSMutableArray array];
    if (self.year >= self.maxYear) {
        for (int i = 1; i <= self.maxMonth; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d月", i]];
        }
    } else if (self.year <= self.minYear) {
        for (NSInteger i = self.minMonth; i <= 12; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%ld月", i]];
        }
    } else {
        for (int i = 1; i <= 12; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d月", i]];
        }
    }
    return [NSArray arrayWithArray:marr];
}

// 获取默认的天数
- (NSArray *)getDayList {
    NSMutableArray *marr = [NSMutableArray array];
    if ((self.month >= self.maxMonth) && (self.year >= self.maxYear)) {
        for (int i = 1; i <= self.maxDay; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d日", i]];
        }
    } else if ((self.month <= self.minMonth) && (self.year <= self.minYear)) {
        for (NSInteger i = self.minDay; i <= [self getDayNumber:self.minYear month:self.minMonth].integerValue + 1; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%ld日", i]];
        }
    } else {
        for (int i = 1; i < [self getDayNumber:self.year month:self.month].integerValue + 1; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d日", i]];
        }
    }
    
    return [NSArray arrayWithArray:marr];
}

// 获取小时
- (NSArray *)getHourList {
    NSMutableArray *marr = [NSMutableArray array];
    
    if ((self.day >= self.maxDay) && (self.month >= self.maxMonth) && (self.year >= self.maxYear)) {
        for (int i = 1; i <= self.maxHour; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d时", i]];
        }
    } else if ((self.day <= self.minDay) && (self.month <= self.minMonth) && (self.year <= self.minYear)) {
        for (NSInteger i = self.minHour; i < 24; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%ld时", i]];
        }
    } else {
        for (int i = 0; i < 24; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d时", i]];
        }
    }
    return [NSArray arrayWithArray:marr];
}

// 获取分钟
- (NSArray *)getMinuteList {
    NSMutableArray *marr = [NSMutableArray array];
    if ((self.hour >= self.maxHour) && (self.day >= self.maxDay) && (self.month >= self.maxMonth) && (self.year >= self.maxYear)) {
        for (int i = 0; i < self.maxMinute; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d分", i]];
        }
    } else if ((self.hour <= self.minHour) && (self.day <= self.minDay) && (self.month <= self.minMonth) && (self.year <= self.minYear)) {
        for (NSInteger i = self.minMinute; i < 60; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%ld分", i]];
        }
    } else {
        for (int i = 0; i < 60; i ++) {
            [marr addObject:[NSString stringWithFormat:@"%d分", i]];
        }
    }
    
    return [NSArray arrayWithArray:marr];
}

- (void)replaceDataWithIndex:(NSInteger)index {
    NSArray *tempList = nil;
    switch (index) {
        case 1: // 月
                tempList = [self getMonthList];
            break;
        case 2:
                tempList = [self getDayList];
            break;
        case 3:
                 tempList = [self getHourList];
            break;
        case 4:
                tempList = [self getMinuteList];
            break;
            
        default:
            break;
            
    }
    
    NSMutableArray *marr = [NSMutableArray arrayWithArray:self.dataArray];
    [marr replaceObjectAtIndex:index withObject:tempList];
    self.dataArray = [NSArray arrayWithArray:marr];
    [self.pickerView reloadAllComponents];
}



// 获取当月天数 year 2019
- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}

#pragma mark - 时间处理
/// 获取时间的年月日时分秒的信息
/// @param date 时间
+ (NSDictionary *)lj_getDateDictWithDate:(NSDate *)date {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:6];
    // formatter "yyyy-MM-dd hh:mm:ss"
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy";
    mDict[@"yyyy"] = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"MM";
    mDict[@"MM"] = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"dd";
    mDict[@"dd"] = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"hh";
    mDict[@"hh"] = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"mm";
    mDict[@"mm"] = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"ss";
    mDict[@"ss"] = [formatter stringFromDate:date];
    
    return [NSDictionary dictionaryWithDictionary:mDict];
}
/// 获取 date yeal 年前的信息
/// @param year 多少年前
/// @param date 时间
+ (NSDate *)lj_dateWithYearsBeforeNow:(NSInteger)year andDate:(NSDate *)date{
    NSDate *currentDate = currentDate = [NSDate date];
    NSCalendar *calendar = nil;
    calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
    [dateComponents setYear:year * -1];
    
    return [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
}


#pragma mark - 懒加载UI控件
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:33/255.0 green:150/255.0  blue:243/255.0  alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:btn];
        _cancelBtn = btn;
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:33/255.0 green:150/255.0  blue:243/255.0  alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:btn];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}

- (UIView *)headView {
    if (!_headView) {
        UIView *headView = [[UIView alloc] init];
        headView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        [self addSubview:headView];
        _headView = headView;
    }
    return _headView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.showsSelectionIndicator = YES;
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}
@end
