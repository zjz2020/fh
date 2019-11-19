//
//  JZBaseNetModel.h
//  JZProject
//  故障类型  获取角色
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNetWorkHelp.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZBaseNetModel : JZNetWorkHelp
+ (JZBaseNetModel *)shareBaseNetModel;
///1.故障类型列表  /base/faultTypeList
- (void)faultTypeList:(NSString *)test backData:(data)backData;
///2.获取角色列表   /base/getRoleList
- (void)getRoleList:(NSString *)test backData:(data)backData;
///3.巡检项目列表   /base/looptaskList
- (void)looptaskList:(NSString *)test backData:(data)backData;
///4.个人意向   /base/personalintentionList
- (void)personalintentionList:(NSString *)test backData:(data)backData;
///5.个人技能   /base/personalskillsList
- (void)personalskillsList:(NSString *)test backData:(data)backData;
///6.服务有效时间  /base/serviceTimeList
- (void)serviceTimeList:(NSString *)test backData:(data)backData;
///7.服务l内容列表  /base/serviceItemList
- (void)serviceItemList:(NSString *)test backData:(data)backData;
///8.人员列表  /base/usersList
- (void)usersListRoleID:(NSString *)roleId usersIdStr:(NSString *)usersIdStr backData:(data)backData;
///9.获取版本号
- (void)appGetVersionBackData:(data)backData;
///10.平台统计
- (void)platformStatisticsBackData:(data)backData;
@end

NS_ASSUME_NONNULL_END
