//
//  JZNotifictionCell.m
//  JZProject
//  消息通知cell
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNotifictionCell.h"

@implementation JZNotifictionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pointView.layer.masksToBounds = true;
    self.pointView.layer.cornerRadius = 7.5;
    self.lineView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    // Initialization code
}
+ (JZNotifictionCell *)creatCellWithXIBWithReuseIdentifier:(NSString *)identifier{
    JZNotifictionCell *cell = [[NSBundle mainBundle] loadNibNamed:@"JZNotifictionCell" owner:nil options:nil].firstObject;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
