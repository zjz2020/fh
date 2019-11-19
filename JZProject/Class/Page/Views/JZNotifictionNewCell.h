//
//  JZNotifictionNewCell.h
//  JZProject
//
//  Created by zjz on 2019/8/14.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZNotificaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZNotifictionNewCell : UITableViewCell
+ (JZNotifictionNewCell *)shareNotifictionCell;
- (void)showViewWithModel:(JZNotificaModel *)model;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *lowView;



@end

NS_ASSUME_NONNULL_END
