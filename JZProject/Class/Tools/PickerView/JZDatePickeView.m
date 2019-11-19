//
//  JZDatePickeView.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZDatePickeView.h"
@interface JZDatePickeView()
@property (strong, nonatomic) UIDatePicker *datePicker;
@property(nonatomic,copy)NSString *selectDate;
@end

@implementation JZDatePickeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setBaseView];
    }
    return self;
}
- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIColor *color = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    UIColor *btnColor = [UIColor colorWithRed:65.0/255 green:164.0/255 blue:249.0/255 alpha:1];
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(0, 0, width, height -210);
    [topBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:topBtn];
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 220, width, 60)];
    selectView.backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    [self addSubview:selectView];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, height - 180 , width,  180)];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置当前显示时间
    [_datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [_datePicker setMinimumDate:[NSDate date]];
    //监听DataPicker的滚动
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.selectDate = [self transfromDateToString:[NSDate new]];
    [self addSubview:self.datePicker];
}
-(void)dateChange:(UIDatePicker *)datePicker{
    self.selectDate = [self  transfromDateToString:datePicker.date];
}
- (NSString *)transfromDateToString:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:date];
}
- (void)setIsMonth:(BOOL)isMonth{
    _isMonth = isMonth;
    [self.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
}
- (void)dateCancleAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicerCancel:)]) {
        [self.delegate datePicerCancel:self];
    }
}

- (void)dateEnsureAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerSelectData:pickerView:)]) {
        [self.delegate datePickerSelectData:self.selectDate pickerView:self];
    }
}
@end
