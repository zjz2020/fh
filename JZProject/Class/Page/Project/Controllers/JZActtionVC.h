//
//  JZActtionVC.h
//  JZProject
//
//  Created by zjz on 2019/8/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZActtionVC : JZBaseViewController
@property(nonatomic,copy)NSString *Showtitle;
@property(nonatomic,copy)NSString *faultid;
///计划内容
@property(nonatomic,copy)NSString *planText;
+ (JZActtionVC *)shareActionVC;
@end

NS_ASSUME_NONNULL_END
