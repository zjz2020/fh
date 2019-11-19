//
//  JZProjectModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProjectModel.h"
@implementation JZProjectModel
+ (JZProjectModel *)shareModel{
    return [[JZProjectModel alloc] init];
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"fileurl"]) {
        if ([value isEqualToString:@""]) {
            
        } else {
            [super setValue:value forKey:key];
        }
    } else if ([key isEqualToString:@"auditstatus"]) {
        if ([value isEqual:@0]) {
            self.auditstatus = @"未审批";
        } else if ([value isEqual:@1]) {
            self.auditstatus = @"审核通过";
        } else if ([value isEqual:@2]){
            self.auditstatus = @"审批拒绝";
        } else {
            self.auditstatus = @"关闭";
        }
    } else {
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"servicers"]) {//服务人员
        self.servicePerson = [self backNewArrayWithArray:value];
    }
    if ([key isEqualToString:@"partyas"]) {//甲方负责人
         self.partyasPerson = [self backNewArrayWithArray:value];
    }
}
- (NSArray *)backNewArrayWithArray:(NSArray *)data {
    NSMutableArray *mArray = [NSMutableArray new];
    for (NSDictionary *dic in data) {
        JZManModel *model = [JZManModel shareModel];
        [model setValuesForKeysWithDictionary:dic];
        [mArray addObject:model];
    }
    return mArray;
}
+ (NSDictionary *)shareDicWithModel:(JZProjectModel *)model isCreat:(BOOL)creat{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    BOOL parameterOk = YES;
    if (model.projectname && model.projectname.length > 0) {//projectName
        if (creat) {
             [dic setValue:model.projectname forKey:@"projectName"];
        } else {
             [dic setValue:model.projectname forKey:@"projectname"];
        }
    } else {
//        parameterOk = NO;
//        [JZTost showTost:@"请输入单位名称"];
    }
    if (model.userId) {
        [dic setValue:model.userId forKey:@"userId"];
    }
    if (model.projectid) {
         [dic setValue:model.projectid forKey:@"projectid"];
    }
    if (model.orgname && model.orgname.length > 0) {
        if (creat) {
            [dic setValue:[NSString stringWithFormat:@"%@",model.orgname] forKey:@"orgName"];
        } else {
             [dic setValue:[NSString stringWithFormat:@"%@",model.orgname] forKey:@"orgname"];
        }
    }
    if (model.province && model.province.length > 0) {//provice  province
        [dic setValue:model.province forKey:@"province"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请输入地址"];
    }
    if (model.city && model.city.length > 0) {
        [dic setValue:model.city forKey:@"city"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请输入地址"];
    }
    if (model.county && model.county.length > 0) {
        [dic setValue:model.county forKey:@"county"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请输入地址"];
    }
    if (model.address && model.address.length > 0) {
        [dic setValue:model.address forKey:@"address"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请输入详细地址"];
    }
    if (model.effectivetime && model.effectivetime.length > 0) {
        [dic setValue:model.effectivetime forKey:@"effectivetime"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择服务有效时间"];
    }
    if (model.serviceid) {
        if (creat) {
            [dic setValue:model.serviceid forKey:@"serviceId"];
        } else {
             [dic setValue:model.serviceid forKey:@"serviceid"];
        }
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择服务内容"];
    }
    if (model.taskid) {
        if (creat) {
             [dic setValue:model.taskid forKey:@"taskId"];
        } else {
             [dic setValue:model.taskid forKey:@"taskid"];
        }
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择巡检时间"];
    }
    if (model.servicestarttime && model.servicestarttime.length > 0) {
        if (creat) {
             [dic setValue:model.servicestarttime forKey:@"serviceStartTime"];
        } else {
            [dic setValue:model.servicestarttime forKey:@"servicestarttime"];
        }
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择服务开始时间"];
    }
    if (model.projectmemo && model.projectmemo.length > 0) {
        [dic setValue:model.projectmemo forKey:@"projectmemo"];
    }
    if (model.serviceendtime && model.serviceendtime.length > 0) {
        if (creat) {
              [dic setValue:model.serviceendtime forKey:@"serviceEndTime"];
        } else {
            [dic setValue:model.serviceendtime forKey:@"serviceendtime"];
        }
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择服务结束时间"];
    }
    if (model.headid && model.headid.length > 0) {
        if (creat) {
             [dic setValue:model.headid forKey:@"headId"];
        } else {
            [dic setValue:model.headid forKey:@"headid"];
        }
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择项目负责人"];
    }
    if (model.headname && model.headname.length > 0) {
        [dic setValue:model.headname forKey:@"headname"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择项目负责人"];
    }
    if (model.headmobile && model.headmobile.length > 0) {
          [dic setValue:model.headmobile forKey:@"headmobile"];
    }
    if (model.servicePerson && model.servicePerson.count > 0) {
        NSMutableString *mstring = [NSMutableString stringWithFormat:@""];
        for (NSInteger i = 0; i < model.servicePerson.count; i ++) {
            JZManModel *man = model.servicePerson[i];
            if (i == 0) {
                [mstring appendString:man.userId];
            } else {
                [mstring appendString:[NSString stringWithFormat:@",%@",man.userId]];
            }
        }
        [dic setValue:mstring forKey:@"servicersIds"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择维护人员"];
    }
    if (model.fileurl) {
        [dic setValue:model.fileurl forKey:@"fileurl"];
    }
    if (model.partyasPerson && model.partyasPerson.count > 0) {
         NSMutableString *mstring = [NSMutableString stringWithFormat:@""];
        for (NSInteger i = 0; i < model.partyasPerson.count; i ++) {
            JZManModel *man = model.partyasPerson[i];
            if (i == 0) {
                [mstring appendString:man.userId];
            } else {
                [mstring appendString:[NSString stringWithFormat:@",%@",man.userId]];
            }
        }
        [dic setValue:mstring forKey:@"partyAId"];
    } else {
        parameterOk = NO;
        [JZTost showTost:@"请选择甲方负责人"];
    }
    if (parameterOk) {
        [dic setValue:@1 forKey:@"parameterOk"];
    } else {
        [dic setValue:@0 forKey:@"parameterOk"];
    }
    return dic;
}
@end


@implementation JZManModel
+ (JZManModel *)shareModel{
    return [[JZManModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
    if ([key isEqualToString:@"name"]) {
        self.userName = value;
    }
    if ([key isEqualToString:@"mobile"]) {
        self.mobile = value;
    }
}
- (NSDictionary *)shareDicWithModel:(JZManModel *)model{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (model.userId && model.userId.length > 0) {
        [dic setValue:model.userId forKey:@"userId"];
    }
    if (model.userName && model.userName.length > 0) {
        [dic setValue:model.userName forKey:@"userName"];
    }
    if (model.mobile && model.mobile.length > 0) {
        [dic setValue:model.mobile forKey:@"mobile"];
    }
    if (model.provice && model.provice.length > 0) {
        [dic setValue:model.provice forKey:@"provice"];
    }
    if (model.city && model.city.length > 0) {
        [dic setValue:model.city forKey:@"city"];
    }
    if (model.area && model.area.length > 0) {
        [dic setValue:model.area forKey:@"area"];
    }
    if (model.address && model.address.length > 0) {
        [dic setValue:model.address forKey:@"address"];
    }
    return dic;
}
- (JZManModel *)shareManModelWithDic:(NSDictionary *)dic{
    JZManModel *model = [JZManModel shareModel];
    for (NSString *key in dic.allKeys) {
        if ([key isEqualToString:@"userId"] || [key isEqualToString:@"id"]) {
            model.userId = dic[@"userId"];
        }
        if ([key isEqualToString:@"userName"] || [key isEqualToString:@"name"]) {
            model.userName = dic[@"userName"];
        }
        if ([key isEqualToString:@"mobile"]) {
            model.mobile = dic[@"mobile"];
        }
        if ([key isEqualToString:@"provice"]) {
             model.provice = dic[@"provice"];
        }
        if ([key isEqualToString:@"city"]) {
             model.city = dic[@"city"];
        }
        if ([key isEqualToString:@"area"]) {
             model.area = dic[@"area"];
        }
        if ([key isEqualToString:@"address"]) {
             model.address = dic[@"address"];
        }
    }
    return model;
}
@end

@implementation JZEventModel

+ (JZEventModel *)shareEventModel {
    return [[JZEventModel alloc] init];
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"eventtime"]) {//eventtime
        self.eventtime = [self changeStringToTime:value];
    } else if ([key isEqualToString:@"status"]){
        self.status = [NSString stringWithFormat:@"%@",value];
    }else if ([key isEqualToString:@"faulttype"]){
        self.faulttype = [NSString stringWithFormat:@"%@",value];
    } else {
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_id = value;
    } else if ([key isEqualToString:@"faultid"]) {
        self.eventId = value;
    }
}
- (NSString *)changeStringToTime:(NSString *)time {
    NSString *str = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"yyyy年MM月dd日HH:mm:ss"];
    NSString *newTime = [formatter stringFromDate:date];
    return newTime;
}
- (NSDictionary *)backEvenDic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.eventId) {
        dic[@"eventId"] = self.eventId ;
    }
    if (self.eventhost) {
         dic[@"eventhost"] = self.eventhost;
    }
    if (self.eventip) {
         dic[@"eventip"] = self.eventip;
    }
    if (self.eventdetail) {
         dic[@"eventdetail"] = self.eventdetail;
    }
    if (self.declaretxt) {
         dic[@"declaretxt"] = self.declaretxt;
    }
    if (self.eventtime) {
         dic[@"eventtime"] = self.eventtime;
    }
    if (self.zabbixeid) {
         dic[@"zabbixeid"] = self.zabbixeid;
    }
    if (self.userName) {
         dic[@"userName"] = self.userName;
    }
    return dic;
}
@end

@implementation JZRecordListModel

+ (JZRecordListModel *)shareRecordList {
    return [[JZRecordListModel alloc] init];
}

@end

@implementation JZRecordModel

+ (JZRecordModel *)shareRecordModel {
    return [[JZRecordModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
