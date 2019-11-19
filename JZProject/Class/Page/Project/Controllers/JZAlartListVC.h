//
//  JZAlartListVC.h
//  JZProject
//
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZAlartListVC : JZBaseViewController
@property(nonatomic,assign)CGFloat contentHeight;
///type  0  事件警告   1  维护记录
@property(nonatomic,assign)NSInteger alartType;
///项目id
@property(nonatomic,copy)NSString *projectId;
@end

NS_ASSUME_NONNULL_END
