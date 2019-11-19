//
//  JZAlartDetailVC.h
//  JZProject
//
//  Created by zjz on 2019/7/20.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"
#import "JZProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZAlartDetailVC : JZBaseViewController
+ (JZAlartDetailVC *)shareAlartDetail;
@property(nonatomic,strong)JZEventModel *eventModel;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,assign)BOOL isCreat;
@end

NS_ASSUME_NONNULL_END
