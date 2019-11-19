//
//  JZMaintenanceCell.m
//  JZProject
//
//  Created by zjz on 2019/7/28.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZMaintenanceCell.h"
@interface JZMaintenanceCell()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *statuL;
@property (weak, nonatomic) IBOutlet UILabel *faultDescriptionL;
@property (weak, nonatomic) IBOutlet UILabel *objectL;
@property (weak, nonatomic) IBOutlet UILabel *addDescriptionL;
@property (weak, nonatomic) IBOutlet UILabel *upPersonL;
@property (weak, nonatomic) IBOutlet UILabel *servicePersonL;
@property (weak, nonatomic) IBOutlet UILabel *serviceResult;
@property (weak, nonatomic) IBOutlet UILabel *ipDescription;
@property (weak, nonatomic) IBOutlet UITextView *serviceResultDescriptionL;
@property(nonatomic,strong)JZRecordModel *model;
@property (weak, nonatomic) IBOutlet UIView *ipView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ipvViewHeight;
@property (weak, nonatomic) IBOutlet UIView *serveceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serveceViewHeight;

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIView *line7;
@property (weak, nonatomic) IBOutlet UIView *addView;

@end
@implementation JZMaintenanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeLineBackColor];
    // Initialization code
}
- (void)makeLineBackColor {
    self.bottomView.backgroundColor = GrayColor2;
    self.lineView.backgroundColor = GrayColor1;
    self.line1.backgroundColor = GrayColor1;
    self.line2.backgroundColor = GrayColor1;
    self.line3.backgroundColor = GrayColor1;
    self.line4.backgroundColor = GrayColor1;
    self.line5.backgroundColor = GrayColor1;
    self.line6.backgroundColor = GrayColor1;
    self.line7.backgroundColor = GrayColor1;
}
- (void)showRecodeModel:(JZRecordModel *)recordModel {
    NSString *stateName = @"自动报警";
    if ([recordModel.faultStatus isEqualToString:@"1"]) {//创建成功
        stateName = @"创建成功";
    } else if ([recordModel.faultStatus isEqualToString:@"2"]) {
        stateName = @"已取消";
    } else if ([recordModel.faultStatus isEqualToString:@"3"]) {
        stateName = @"计划处理中";
    } else if ([recordModel.faultStatus isEqualToString:@"4"]) {
        stateName = @"维护中";
    } else if ([recordModel.faultStatus isEqualToString:@"5"]) {
        stateName = @"维护完成";
    } else if ([recordModel.faultStatus isEqualToString:@"6"]) {
        stateName = @"已修复";
    }
    self.statuL.text = stateName;
    if ([recordModel.faultStatus isEqualToString:@"6"]) {
        [self.statuL setTextColor:[UIColor greenColor]];
    }
    self.timeL.text = [NSString stringWithFormat:@"%@(%@)",[self changeStringToTime:recordModel.faultTime],recordModel.projectName];
    self.timeL.text = recordModel.equipment;
    self.model = recordModel;
    self.objectL.text = recordModel.equipment;
    [self.objectL setTextColor:[UIColor redColor]];
    self.faultDescriptionL.text = recordModel.faultDesc;
    self.ipDescription.text = recordModel.ip;
    self.ipDescription.hidden = YES;
    self.ipView.hidden = YES;
    self.serveceView.hidden = YES;
    self.upPersonL.text = recordModel.declarer;
    self.servicePersonL.text = recordModel.defender;
    self.serviceResult.text = recordModel.defendRemark;
    self.serviceResultDescriptionL.text = recordModel.defendResultDesc;
    self.addDescriptionL.text = [self changeStringToTime:recordModel.faultTime];
}
- (NSString *)changeStringToTime:(NSString *)time {
    NSString *str = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"MM月dd日HH时mm分"];
    return [formatter stringFromDate:date];
}
//- (NSString *)changeStringToTime:(NSString *)time {
//    NSString *str = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *date = [formatter dateFromString:str];
//    [formatter setDateFormat:@"MM月dd日HH时mm分"];
//    return [formatter stringFromDate:date];
//}
- (IBAction)sureBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickeSureCompleteWithModel:title:)]) {
        [self.delegate clickeSureCompleteWithModel:self.model title:sender.titleLabel.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
