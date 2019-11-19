//
//  JZMaintenanceCell.h
//  JZProject
//
//  Created by zjz on 2019/7/28.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZProjectModel.h"
#import "JZRecordVC.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JZMaintenanceCellDeleget<NSObject>
@optional
/** 点击完成确认*/
- (void)clickeSureCompleteWithModel:(JZRecordModel *)recordModel title:(NSString *)title;
@end
@interface JZMaintenanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(nonatomic,assign)id<JZMaintenanceCellDeleget>delegate;
- (void)showRecodeModel:(JZRecordModel *)recordModel;

@end

NS_ASSUME_NONNULL_END
