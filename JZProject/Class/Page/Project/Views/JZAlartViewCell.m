//
//  JZAlartViewCell.m
//  JZProject
//
//  Created by zjz on 2019/7/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZAlartViewCell.h"

@interface JZAlartViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectContenLabel;
@property (weak, nonatomic) IBOutlet UILabel *problemLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *objWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ipContenWidth;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *line1View;
@property (weak, nonatomic) IBOutlet UIView *line3View;
@property (weak, nonatomic) IBOutlet UIView *line2View;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property(nonatomic,strong)JZEventModel *evenModel;
@end

@implementation JZAlartViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat width = Width - 20;
    self.objWidth.constant = width *3/5;
    self.ipContenWidth.constant = width *2/5;
    [self creatLineView];
    // Initialization code
}
- (void)creatLineView {
    self.moreView.backgroundColor = GrayColor2;
    self.topView.backgroundColor = [UIColor whiteColor];
    self.line1View.backgroundColor = GrayColor1;
    self.line2View.backgroundColor = GrayColor1;
    self.line3View.backgroundColor = GrayColor2;
}
- (IBAction)upBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickUpActionBtn:title:)]) {
        [self.delegate clickUpActionBtn:self.evenModel title:sender.titleLabel.text];
    }
}
- (IBAction)cancelBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCancelActionBtn:title:)]) {
        [self.delegate clickCancelActionBtn:self.evenModel title:sender.titleLabel.text];
    }
}
- (void)shareCellWithEvenModel:(JZEventModel *)eventModel {
    NSString *stateName = @"自动报警";
    if ([eventModel.status isEqualToString:@"1"]) {//创建成功
        stateName = @"发现问题";
    } else if ([eventModel.status isEqualToString:@"2"]) {
         stateName = @"已取消";
    } else if ([eventModel.status isEqualToString:@"3"]) {
         stateName = @"计划处理中";
    } else if ([eventModel.status isEqualToString:@"4"]) {
         stateName = @"维护中";
    } else if ([eventModel.status isEqualToString:@"5"]) {
         stateName = @"维护完成";
    } else if ([eventModel.status isEqualToString:@"6"]) {
         stateName = @"已修复";
    }
    self.evenModel = eventModel;
    self.timeLabel.text = eventModel.equipment;
    self.ipContentLabel.text = eventModel.eventip;
    self.ipLabel.hidden = YES;
    self.ipContentLabel.hidden = YES;
    self.statusLabel.text = stateName;
    NSLog(@"%@",[self changeStringToTime:eventModel.eventtime]);
    self.middleLabel.text = [self changeStringToTime:eventModel.eventtime];
    self.objectContenLabel.text = eventModel.equipment;
    if ([eventModel.status isEqualToString:@"6"]) {
        [self.statusLabel setTextColor:[UIColor greenColor]];
    }
    self.problemLabel.text = eventModel.eventdetail;
}
- (NSString *)changeStringToTime:(NSString *)time {
    return [time substringFromIndex:5];
    NSString *str = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"MM月dd日HH时mm分"];
    return [formatter stringFromDate:date];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
