//
//  JZServiceItemModel.h
//  JZProject
//
//  Created by zjz on 2019/7/13.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///服务需求model    故障类型model  个人意向 个人技能
@interface JZServiceItemModel : NSObject
+ (JZServiceItemModel *)shareServiceItem;
///id
@property(nonatomic,copy)NSString *itemID;
///服务名称
@property(nonatomic,copy)NSString *serviceName;
- (void)setDataWithDic:(NSDictionary *)dic;
@end

///角色列表
@interface JZRoleItemModel : NSObject
+ (JZRoleItemModel *)shareRoleItem;
@property(nonatomic,copy)NSString *roleid;
@property(nonatomic,copy)NSString *rolename;
@property(nonatomic,assign)NSInteger rolelevel;
- (void)setDataWithDic:(NSDictionary *)dic;
@end

///巡检项目
@interface JZLooptaskItemModel : NSObject
+ (JZLooptaskItemModel *)shareLoopItem;
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *taskname;
@property(nonatomic,copy)NSString *taskcycle;
- (void)setDataWithDic:(NSDictionary *)dic;
@end

///服务有效期
@interface JZServiceTimeModel : NSObject
+ (JZServiceTimeModel *)shareServiceTime;
///时间ID
@property(nonatomic,copy)NSString *itemId;
///时间
@property(nonatomic,copy)NSString *time;
///时间描述
@property(nonatomic,copy)NSString *timedesc;
- (void)setDataWithDic:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
