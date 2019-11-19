//
//  JZFaultModel.h
//  JZProject
//  故障申报    维护信息修改
//  Created by zjz on 2019/7/14.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///故障申请
@interface JZFaultModel : NSObject
+ (JZFaultModel *)shareFaultModel;
- (NSDictionary *)changeModelToDic;
///项目ID
@property(nonatomic,copy)NSString *projectId;
///故障类型
@property(nonatomic,copy)NSString *faulttype;
///故障问题描述
@property(nonatomic,copy)NSString *faultdesc;
///故障开始时间  date-time
@property(nonatomic,copy)NSString *starttime;
///当前网络状态
@property(nonatomic,copy)NSString *networkstatus;
///申报人
@property(nonatomic,copy)NSString *declarer;
///备注
@property(nonatomic,copy)NSString *remark;
@end

///维护信息修改
@interface JZFaultUpdateModel : NSObject
+ (JZFaultUpdateModel *)shareFaultUpdateModel;
- (NSDictionary *)changeModelToDic;
///维护单ID
@property(nonatomic,copy)NSString *faultDefendId;
///维护人ID
@property(nonatomic,copy)NSString *defenderId;
///故障开始时间  date-time
@property(nonatomic,copy)NSString *startTime;
///维护人员定位
@property(nonatomic,copy)NSString *defenderPosition;
///定位时间
@property(nonatomic,copy)NSString *locationTime;
@end



NS_ASSUME_NONNULL_END
