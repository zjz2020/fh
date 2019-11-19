//
//  JZRegisterNetModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZRegisterNetModel.h"
#import "JZShowManModel.h"
@implementation JZRegisterNetModel
+ (JZRegisterNetModel *)shareRegistNetModel{
    JZRegisterNetModel *model = [[JZRegisterNetModel alloc] init];
    return model;
}
///检查用户是否注册
- (void)checkUserRegister:(NSString *)phone backData:(data)backData{
    NSDictionary *dic = @{
                          @"phone":phone
                          };
     NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/checkUserRegister"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
    
}
///系统用户登录  POST /users/login
- (void)loginWithName:(NSString *)name passWord:(NSString *)passWord backData:(data)backData{
    NSDictionary *dic = @{
                          @"loginName":name,
                           @"passWord":passWord,
                          };
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/login"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///项目负责人列表  /users/projectHeadList
- (void)projectHeadList:(NSString *)test backData:(data)backData{
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/projectHeadList"];
}
///甲方负责人列表  POST /users/projectPartyAList
- (void)projectPartyAList:(NSString *)test backData:(data)backData{
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/projectPartyAList"];
}
///维护人员列表  POST /users/projectServicerList
- (void)projectServicerList:(NSString *)test backData:(data)backData{
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/projectServicerList"];
}
///系统用户注册  /users/register
- (void)registerWithParamts:(NSDictionary *)paramts backData:(data)backData{
      NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/register"];
    [self postWithDic:paramts url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
- (void)sendSMSWithPhone:(NSString *)phone backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/sendSMS"];
    NSDictionary *dic = @{@"phone":phone};
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}

///修改密码
- (void)updatePwdWithPhone:(NSString *)phone passWordOld:(NSString *)passWordOld passWordNew:(NSString *)passWordNew backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/updatePwd"];
    NSDictionary *dic = @{@"phone":phone,
                          @"passWordOld":passWordOld,
                          @"passWordNew":passWordNew,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///忘记密码
- (void)resetPwdPwdWithPhone:(NSString *)phone passWord:(NSString *)passWord verifyCode:(NSString *)verifyCode backData:(data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/resetPwd"];
    NSDictionary *dic = @{@"phone":phone,
                          @"passWord":passWord,
                          @"verifyCode":verifyCode,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}


///极光ID上传
- (void)uploadJGpushIdWithPushId:(NSString *)pushId backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/uploadJGpushId"];
    NSDictionary *dic = @{@"pushId":pushId,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///删除用户
- (void)deleteUserid:(NSString *)userid backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/delete"];
    NSDictionary *dic = @{@"userid":[JZNetWorkHelp shareNetWork].userId,@"userids":userid};
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///通过用户审核
- (void)passUserid:(NSString *)userid backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/pass"];
    NSDictionary *dic = @{@"userid":[JZNetWorkHelp shareNetWork].userId,
                          @"userids":userid,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///用户列表  0:未审核，1:审核通过  1.甲方负责人  2.项目负责人  3.维护人员 4.系统管理员 5  注册工程师
- (void)userListWithUsername:(NSString *)username roleids:(NSString *)roleids status:(NSString *)status backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/list"];
    NSDictionary *dic = @{
                          @"status":status,
                          };
    if (username && username.length > 0) {
        dic = @{@"username":username,
                @"status":status,
                };
    }
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSArray *array = responseObj[@"rows"];
            NSMutableArray *marray = [NSMutableArray new];
            if (array.count == 0) {
                backData(netOk,@[]);
            } else {
                for (NSDictionary *dic in array) {
                    JZShowManModel *model = [[JZShowManModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [marray addObject:model];
                }
                backData(netOk,marray);
            }
        } else {
              backData(netOk,responseObj);
        }
    }];
}
///获取用户详情
- (void)userDetailUserid:(NSString *)userid backData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/users/detail"];
    NSDictionary *dic = @{
                          @"userid":userid,
                          };
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            JZShowManModel *man = [JZShowManModel showMan];
            [man setValuesForKeysWithDictionary:responseObj];
            backData(netOk,man);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
@end
