//
//  JZProjectVC.h
//  JZProject
//  项目信息
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZProjectVC : JZBaseViewController
+ (JZProjectVC *)shareProjectVc;
- (void)setSelfViewHeight:(CGFloat)height;
///项目id
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *titleName;
@end

NS_ASSUME_NONNULL_END
