//
//  JZFaultModel.m
//  JZProject
//
//  Created by zjz on 2019/7/14.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZFaultModel.h"

@implementation JZFaultModel
+ (JZFaultModel *)shareFaultModel{
    return [[JZFaultModel alloc] init];
}
- (NSDictionary *)changeModelToDic{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.projectId) {
        [dic setValue:self.projectId forKey:@"projectId"];
    }
    if (self.faultdesc) {
        [dic setValue:self.faultdesc forKey:@"faultdesc"];
    }
    if (self.faulttype) {
        [dic setValue:self.faulttype forKey:@"faulttype"];
    }
    if (self.starttime) {
        [dic setValue:self.starttime forKey:@"starttime"];
    }
    if (self.networkstatus) {
        [dic setValue:self.networkstatus forKey:@"networkstatus"];
    }
    if (self.declarer) {
        [dic setValue:self.declarer forKey:@"declarer"];
    }
    if (self.remark) {
        [dic setValue:self.remark forKey:@"remark"];
    }
    return dic;
}
@end

@implementation JZFaultUpdateModel

+ (JZFaultUpdateModel *)shareFaultUpdateModel{
    return [[JZFaultUpdateModel alloc] init];
}
- (NSDictionary *)changeModelToDic{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.faultDefendId) {
        [dic setValue:self.faultDefendId forKey:@"faultDefendId"];
    }
    if (self.defenderId) {
        [dic setValue:self.defenderId forKey:@"defenderId"];
    }
    if (self.startTime) {
        [dic setValue:self.startTime forKey:@"startTime"];
    }
    if (self.defenderPosition) {
        [dic setValue:self.defenderPosition forKey:@"defenderPosition"];
    }
    if (self.locationTime) {
        [dic setValue:self.locationTime forKey:@"locationTime"];
    }
    return dic;
}

@end



