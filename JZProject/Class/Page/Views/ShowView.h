//
//  ShowView.h
//  JZProject
//
//  Created by zjz on 2019/11/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowView : UIView
@property (weak, nonatomic) IBOutlet UILabel *firstLeftL;
@property (weak, nonatomic) IBOutlet UILabel *firstRightL;
@property (weak, nonatomic) IBOutlet UILabel *secLeftL;
@property (weak, nonatomic) IBOutlet UILabel *secRightL;
@property (weak, nonatomic) IBOutlet UILabel *thredLeftL;
@property (weak, nonatomic) IBOutlet UILabel *thredRightL;
@property (weak, nonatomic) IBOutlet UILabel *forthLeftL;
@property (weak, nonatomic) IBOutlet UILabel *forthRightL;
@property (weak, nonatomic) IBOutlet UILabel *fiveLeftL;
@property (weak, nonatomic) IBOutlet UILabel *fiveRightL;
@property (weak, nonatomic) IBOutlet UIView *secView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secViewTop;
@property (weak, nonatomic) IBOutlet UIView *thredView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *firveView;
+ (ShowView *)creatShowView;
- (void)makeSizeToFit;
@end

NS_ASSUME_NONNULL_END
