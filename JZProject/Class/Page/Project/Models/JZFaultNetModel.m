//
//  JZFaultNetModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZFaultNetModel.h"

@implementation JZFaultNetModel
+ (JZFaultNetModel *)shareFaultNetModel{
    return [[JZFaultNetModel alloc] init];
}
///甲方确认维护单  /fault/confirmFaultDefend
- (void)confirmFinishFaultWithFaultid:(NSString *)faultid resultdesc:(NSString *)resultdesc backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/confirmFinishFaultDefend"];
    NSDictionary *dic = @{
                          @"faultid":faultid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          @"resultdesc":resultdesc,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///生成维护单   /fault/createFaultDefend
- (void)createFaultDefendWithFaultid:(NSString *)faultid backData:(data)backData{
    NSDictionary *dic = @{
                          @"faultid":faultid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/createFaultDefend"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///故障取消   /fault/faultCancel
- (void)faultCancelWithFaultid:(NSString *)faultid backData:(data)backData{
    NSDictionary *dic = @{
                          @"faultid":faultid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/faultCancel"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///故障申报   /fault/faultCreate
- (void)faultCreateWithDic:(NSDictionary *)dic backData:(data)backData{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/faultCreate"];
    [self postWithDic:mDic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///维护信息修改   /fault/faultDefendUpdate
- (void)faultDefendUpdateWithDic:(NSDictionary *)dic backData:(data)backData{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    mDic[@"Token"] = [JZNetWorkHelp shareNetWork].token;
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/faultDefendUpdate"];
    [self postWithDic:mDic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///故障修改    /fault/faultUpdate
- (void)registerWithParamts:(NSDictionary *)paramts backData:(data)backData{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:paramts];
    mDic[@"Token"] = [JZNetWorkHelp shareNetWork].token;
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/faultUpdate"];
    [self postWithDic:mDic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///提交维护结果    /fault/subFaultResult
- (void)subFaultResult:(NSDictionary *)paramts backData:(data)backData{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:paramts];
    mDic[@"Token"] = [JZNetWorkHelp shareNetWork].token;
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/subFaultResult"];
    [self postWithDic:mDic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
    
}
///8.甲方确认处理计划
- (void)confirmFaultPlanWithDefendid:(NSString *)defendid resultdesc:(NSString *)resultdesc backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/confirmFaultPlan"];
    NSDictionary *dic = @{
                          @"faultid":defendid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          @"resultdesc":resultdesc,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///9.甲方确认完成维护单
- (void)confirmFinishFaultDefendWithDefendid:(NSString *)defendid resultdesc:(NSString *)resultdesc backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/confirmFinishFaultDefend"];
    NSDictionary *dic = @{
                          @"faultid":defendid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///10.填报处理计划
- (void)insertHandlePlanWithFaultid:(NSString *)faultid plan:(NSString *)plan backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/insertHandlePlan"];
    NSDictionary *dic = @{
                          @"faultid":faultid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          @"plan":plan,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///11.维护人员维护完成
- (void)finishFaultDefendWithFaultid:(NSString *)faultid resultdesc:(NSString *)resultdesc backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/fault/finishFaultDefend"];
    NSDictionary *dic = @{
                          @"faultid":faultid,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          @"resultdesc":resultdesc,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
@end
