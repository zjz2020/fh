//
//  JZAlartViewCell.h
//  JZProject
//
//  Created by zjz on 2019/7/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZProjectModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JZAlartViewCellDelegate <NSObject>
@optional
/** 代理方法返回省市区*/
- (void)clickUpActionBtn:(JZEventModel *)model title:(NSString *)title;
- (void)clickCancelActionBtn:(JZEventModel *)model title:(NSString *)title;
@end
@interface JZAlartViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property(nonatomic,weak)id<JZAlartViewCellDelegate>delegate;
- (void)shareCellWithEvenModel:(JZEventModel *)eventModel;

@end

NS_ASSUME_NONNULL_END
