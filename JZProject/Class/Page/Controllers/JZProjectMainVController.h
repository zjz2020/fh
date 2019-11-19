//
//  JZProjectMainVController.h
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZProjectMainVController : JZBaseViewController
+(JZProjectMainVController *)shareMainProject;
///项目id
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *eventwarringId;
@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *faultStatus;
@end

NS_ASSUME_NONNULL_END
