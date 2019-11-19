//
//  JZOnePickerView.m
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZOnePickerView.h"
@interface JZOnePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickView;
@property(nonatomic,copy)NSString *selectData;
@property(nonatomic,assign)NSInteger selectIndex;
@end
@implementation JZOnePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setBaseView];
        self.selectIndex = 0;
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
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 210, width, 30)];
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
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height - 180 , width,  180)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = color;
    [self addSubview:self.pickView];
    [self.pickView reloadAllComponents];
    [self updateData];
}
- (void)onePickerSelectData:(NSString *)data{
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            NSString *newData = self.dataArray[i];
            NSInteger select = 0;
            if ([data isEqualToString:newData]) {
                select = i;
                [self.pickView selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    [self updateData];
}

- (void)dateCancleAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onePicerCancel:)]) {
        [self.delegate onePicerCancel:self];
    }
}

- (void)dateEnsureAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onePickerSelectData:pickerView:index:)]) {
        [self.delegate onePickerSelectData:self.selectData pickerView:self index:self.selectIndex];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.height = 45;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
     return [self.dataArray objectAtIndex:row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 45;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
    [self updateData];
}

- (void)updateData {
    self.selectData = [self.dataArray objectAtIndex:[self.pickView selectedRowInComponent:0]];
}
- (void)setDataArray:(NSArray *)dataArray{
    _selectIndex = 0;
    _dataArray= dataArray;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self setBaseView];
     self.selectData = dataArray[0];
}
@end
