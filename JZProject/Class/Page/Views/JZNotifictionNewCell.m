//
//  JZNotifictionNewCell.m
//  JZProject
//
//  Created by zjz on 2019/8/14.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNotifictionNewCell.h"

@implementation JZNotifictionNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    self.lowView.layer.masksToBounds = YES;
    self.lowView.layer.cornerRadius = 5;
    // Initialization code
}
+ (JZNotifictionNewCell *)shareNotifictionCell {
    return [[NSBundle mainBundle] loadNibNamed:@"JZNotifictionNewCell" owner:self options:nil].firstObject;
}
- (void)showViewWithModel:(JZNotificaModel *)model {
    self.leftLabel.text = [NSString stringWithFormat:@"%@",model.msgtitle];
    self.rightLabel.text = model.pushtime;
    self.contentLabel.text = model.msgcontext;
    [self.contentLabel sizeToFit];
    self.contentHeight.constant = self.contentLabel.height;
    
    self.height = 50 + self.contentLabel.height + 40;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
