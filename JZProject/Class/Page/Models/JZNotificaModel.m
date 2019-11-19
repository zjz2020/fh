//
//  JZNotificaModel.m
//  JZProject
//
//  Created by zjz on 2019/7/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNotificaModel.h"

@implementation JZNotificaModel
+ (JZNotificaModel *)shareMotificaModel {
    return [[JZNotificaModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.noticeId = value;
    }
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"pushtime"]) {
        self.pushtime = [self changeStringToTime:value];
    } else {
        [super setValue:value forKey:key];
    }
}
- (NSString *)changeStringToTime:(NSString *)time {
    NSString *str = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"MM月dd日HH时mm分"];
    return [formatter stringFromDate:date];
}
@end
