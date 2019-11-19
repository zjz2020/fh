//
//  JZServiceItemModel.m
//  JZProject
//
//  Created by zjz on 2019/7/13.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZServiceItemModel.h"

@implementation JZServiceItemModel
+ (JZServiceItemModel *)shareServiceItem{
    return [[JZServiceItemModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqual:@"id"]) {
        self.itemID = value;
    }
    if ([key isEqualToString:@"serviceitemdetail"]) {//服务类型
        self.serviceName = value;
    }
    if ([key isEqualToString:@"typename"]) {//故障类型
        self.serviceName = value;
    }
    if ([key isEqualToString:@"intention"]) {//个人意向
        self.serviceName = value;
    }
    if ([key isEqualToString:@"skill"]) {//个人技能
        self.serviceName = value;
    }
}
- (void)setDataWithDic:(NSDictionary *)dic{
    
}
@end

///角色列表

@implementation JZRoleItemModel

+ (JZRoleItemModel *)shareRoleItem {
    return [[JZRoleItemModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (void)setDataWithDic:(NSDictionary *)dic {
    
}
@end

//项目巡检
@implementation JZLooptaskItemModel

+ (JZLooptaskItemModel *)shareLoopItem {
    return [[JZLooptaskItemModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.itemId = value;
    }
}
- (void)setDataWithDic:(NSDictionary *)dic {
    
}
@end

//项目巡检
@implementation JZServiceTimeModel

+ (JZServiceTimeModel *)shareServiceTime {
    return [[JZServiceTimeModel alloc] init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.itemId = [NSString stringWithFormat:@"%@",value];
    }
}
- (void)setDataWithDic:(NSDictionary *)dic {
    
}
@end
