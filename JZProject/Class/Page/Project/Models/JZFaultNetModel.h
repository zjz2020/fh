//
//  JZFaultNetModel.h
//  JZProject
//  维护订单  故障类型
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNetWorkHelp.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZFaultNetModel : JZNetWorkHelp
+ (JZFaultNetModel *)shareFaultNetModel;
///1.甲方确认维护单  /fault/confirmFaultDefend
- (void)confirmFinishFaultWithFaultid:(NSString *)faultid resultdesc:(NSString *)resultdesc backData:(data)backData;
///2.生成维护单   /fault/createFaultDefend
- (void)createFaultDefendWithFaultid:(NSString *)faultid backData:(data)backData;
///3.故障取消   /fault/faultCancel
- (void)faultCancelWithFaultid:(NSString *)faultid backData:(data)backData;
///4.故障申报   /fault/faultCreate
- (void)faultCreateWithDic:(NSDictionary *)dic backData:(data)backData;
///5.维护信息修改   /fault/faultDefendUpdate
- (void)faultDefendUpdateWithDic:(NSDictionary *)dic backData:(data)backData;
///6.故障修改    /fault/faultUpdate
- (void)registerWithParamts:(NSDictionary *)paramts backData:(data)backData;
///7.提交维护结果    /fault/subFaultResult
- (void)subFaultResult:(NSDictionary *)paramts backData:(data)backData;
///8.甲方确认处理计划
- (void)confirmFaultPlanWithDefendid:(NSString *)defendid resultdesc:(NSString *)resultdesc backData:(data)backData;
///9.甲方确认完成维护单 
- (void)confirmFinishFaultDefendWithDefendid:(NSString *)defendid resultdesc:(NSString *)resultdesc backData:(data)backData;
///10.填报处理计划
- (void)insertHandlePlanWithFaultid:(NSString *)faultid plan:(NSString *)plan backData:(data)backData;
///11.维护人员维护完成
- (void)finishFaultDefendWithFaultid:(NSString *)faultid resultdesc:(NSString *)resultdesc backData:(data)backData;
@end

NS_ASSUME_NONNULL_END
