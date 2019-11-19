//
//  JZCreatProjectVC.h
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"
#import "JZProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZCreatProjectVC : JZBaseViewController
+ (JZCreatProjectVC *)shareProject;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,copy)NSString *projectId;
@end

NS_ASSUME_NONNULL_END
