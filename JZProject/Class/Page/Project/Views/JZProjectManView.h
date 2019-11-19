//
//  JZProjectManView.h
//  JZProject
//  操作人员视图
//  Created by zjz on 2019/6/29.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZProjectManView : UIView
+ (JZProjectManView *)shareManView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleL;

@end

NS_ASSUME_NONNULL_END
