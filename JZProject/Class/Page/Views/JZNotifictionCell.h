//
//  JZNotifictionCell.h
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZNotifictionCell : UITableViewCell
+(JZNotifictionCell *)creatCellWithXIBWithReuseIdentifier:(NSString *)identifier;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidth;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UILabel *rightText;
@property (weak, nonatomic) IBOutlet UILabel *leftTextLab;
@property(nonatomic,copy)NSString *identifier;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

NS_ASSUME_NONNULL_END
