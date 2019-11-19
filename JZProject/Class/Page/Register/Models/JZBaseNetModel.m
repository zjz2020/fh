//
//  JZBaseNetModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseNetModel.h"
#import "JZServiceItemModel.h"
#import "JZProjectModel.h"
@implementation JZBaseNetModel
+ (JZBaseNetModel *)shareBaseNetModel{
    return [[JZBaseNetModel alloc] init];
}
///故障类型列表
- (void)faultTypeList:(NSString *)test backData:(data)backData{
    NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
     NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/faultTypeList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *testArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZServiceItemModel *model = [JZServiceItemModel shareServiceItem];
                model.itemID = dic[@"id"];
                model.serviceName = dic[@"typename"];
                [testArray addObject:model];
            }
            backData(netOk,testArray);
            
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///获取角色列表
- (void)getRoleList:(NSString *)test backData:(data)backData{
     NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/getRoleList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
             JZRoleItemModel *roleModel = [JZRoleItemModel shareRoleItem];
                [roleModel setValuesForKeysWithDictionary:dic];
                [mArray addObject:roleModel];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///巡检项目列表   /base/looptaskList
- (void)looptaskList:(NSString *)test backData:(data)backData{
     NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/looptaskList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZLooptaskItemModel *loopTask = [JZLooptaskItemModel shareLoopItem];
                [loopTask setValuesForKeysWithDictionary:dic];
                [mArray addObject:loopTask];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///个人意向   /base/personalintentionList
- (void)personalintentionList:(NSString *)test backData:(data)backData{
    NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/personalintentionList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZServiceItemModel *lintention = [JZServiceItemModel shareServiceItem];
                [lintention setValuesForKeysWithDictionary:dic];
                [mArray addObject:lintention];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///个人技能   /base/personalskillsList
- (void)personalskillsList:(NSString *)test backData:(data)backData{
    NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/personalskillsList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZServiceItemModel *skillModel = [JZServiceItemModel shareServiceItem];
                [skillModel setValuesForKeysWithDictionary:dic];
                [mArray addObject:skillModel];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}

///服务有效时间  /base/serviceTimeList
- (void)serviceTimeList:(NSString *)test backData:(data)backData{
    NSDictionary *dic = @{@"Token":[JZNetWorkHelp shareNetWork].token};
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/serviceTimeList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZServiceTimeModel *timeModel = [JZServiceTimeModel shareServiceTime];
                [timeModel setValuesForKeysWithDictionary:dic];
                [mArray addObject:timeModel];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}

///服务l内容列表  /base/serviceItemList
- (void)serviceItemList:(NSString *)test backData:(data)backData{
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/serviceItemList"];
    [self postWithDic:@{} url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *marray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZServiceItemModel *item = [JZServiceItemModel shareServiceItem];
                [item setValuesForKeysWithDictionary:dic];
                [marray addObject:item];
            }
            backData(netOk,marray);
        } else {
             backData(netOk,responseObj);
        }
    }];
}
///人员列表  /base/usersList
- (void)usersListRoleID:(NSString *)roleId usersIdStr:(NSString *)usersIdStr backData:(data)backData{
    NSDictionary *dic = @{
                          @"Token":[JZNetWorkHelp shareNetWork].token,
                          @"usersIdStr":usersIdStr,
                          @"roleId":roleId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/usersList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZManModel *manModel = [JZManModel shareModel];
                [manModel setValuesForKeysWithDictionary:dic];
                [mArray addObject:manModel];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
- (void)appGetVersionBackData:(data)backData{
    if ([[JZNetWorkHelp shareNetWork].token isEqualToString:@""]) {
        return;
    }
    NSDictionary *dic = @{
                          @"Token":[JZNetWorkHelp shareNetWork].token,
                          @"type":@"ios",
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/versionCheck"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///10.平台统计
- (void)platformStatisticsBackData:(data)backData{
    if ([[JZNetWorkHelp shareNetWork].token isEqualToString:@""]) {
        return;
    }
    NSDictionary *dic = @{
                          @"userid":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/base/platformStatistics"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
@end
