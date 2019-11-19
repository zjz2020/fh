//
//  JZNetWorkHelp.h
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^data)(BOOL netOk,id responseObj);
@interface JZNetWorkHelp : NSObject
+ (JZNetWorkHelp *)shareNetWork;
///用户登录token
@property(nonatomic,copy)NSString *token;
///用户ID
@property(nonatomic,copy)NSString *userId;
///用户名
@property(nonatomic,copy)NSString *userName;
///角色名字  1.甲方负责人  2.项目负责人  3.维护人员 4.系统管理员 5  注册工程师
@property(nonatomic,copy)NSString *roleId;
@property(nonatomic,copy)NSString *roleName;
///phone
@property(nonatomic,copy)NSString *phone;
///zbttoken
@property(nonatomic,copy)NSString *zbToken;
///zbip
@property(nonatomic,copy)NSString *zbip;
///zbusername
@property(nonatomic,copy)NSString *zbusername;
///zbuserpwd
@property(nonatomic,copy)NSString *zbuserpwd;
- (void)postWithDic:(NSDictionary *)dic url:(NSString *)url backData:(data)backData;
- (void)getWithDic:(NSDictionary *)dic url:(NSString *)url backData:(data)backData;
//获取token令牌
- (void)zbLoginNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData;
//获取item
- (void)zbGetItemNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData;
//获取host
- (void)zbGetHostNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData;
//获取历史
//获取host
- (void)zbGetHistoryNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData;
- (void)uploadImageWithData:(NSData *)data  urlStr:(NSString *)url backData:(data)backData;
@end

NS_ASSUME_NONNULL_END
