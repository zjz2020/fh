//
//  JZHistoryModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZHistoryModel.h"

@implementation JZHistoryModel
+ (JZHistoryModel *)shareHistoryModeWithData:(NSDictionary *)data{
    JZHistoryModel *model = [[JZHistoryModel alloc] init];
    for (NSString *key in data.allKeys) {
        if ([key isEqualToString:@"clock"]) {
            model.clock = [JZHistoryModel changeTimeIntervalToString:data[key] isDetail:NO];
            model.dclock = [JZHistoryModel changeTimeIntervalToString:data[key] isDetail:YES];
        }
        if ([key isEqualToString:@"itemid"]) {
            model.itemid = data[key];
        }
        if ([key isEqualToString:@"ns"]) {
            model.ns = data[key];
        }
        if ([key isEqualToString:@"value"]) {
            model.value = data[key];
        }
    }
    return model;
}
//时间戳 转换为时间
+ (NSString *)changeTimeIntervalToString:(NSString *)timeInterval isDetail:(BOOL)isDetail{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateString = [formatter stringFromDate: date];
    if (![dateString containsString:@":00"] && !isDetail) {
        dateString = [dateString substringFromIndex:3];
    }
    JZLog(@"%@",dateString);
    return dateString;
}
@end
