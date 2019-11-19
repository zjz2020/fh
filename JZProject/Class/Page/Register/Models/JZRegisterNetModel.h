//
//  JZRegisterNetModel.h
//  JZProject
//  注册类 网络请求
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNetWorkHelp.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZRegisterNetModel : JZNetWorkHelp
+ (JZRegisterNetModel *)shareRegistNetModel;
///检查用户是否注册  /users/checkUserRegister
- (void)checkUserRegister:(NSString *)phone backData:(data)backData;
///系统用户登录  POST /users/login
- (void)loginWithName:(NSString *)name passWord:(NSString *)passWord backData:(data)backData;
///项目负责人列表  /users/projectHeadList
- (void)projectHeadList:(NSString *)test backData:(data)backData;
///甲方负责人列表  POST /users/projectPartyAList
- (void)projectPartyAList:(NSString *)test backData:(data)backData;
///维护人员列表  POST /users/projectServicerList
- (void)projectServicerList:(NSString *)test backData:(data)backData;
///系统用户注册  /users/register
- (void)registerWithParamts:(NSDictionary *)paramts backData:(data)backData;
///获取验证码
- (void)sendSMSWithPhone:(NSString *)phone backData:(data)backData;
///修改密码
- (void)updatePwdWithPhone:(NSString *)phone passWordOld:(NSString *)passWordOld passWordNew:(NSString *)passWordNew backData:(data)backData;
///忘记密码
- (void)resetPwdPwdWithPhone:(NSString *)phone passWord:(NSString *)passWord verifyCode:(NSString *)verifyCode backData:(data)backData;
///极光ID上传
- (void)uploadJGpushIdWithPushId:(NSString *)pushId backData:(data)backData;
///删除用户
- (void)deleteUserid:(NSString *)userid backData:(data)backData;
///通过用户审核
- (void)passUserid:(NSString *)userid backData:(data)backData;
///用户列表  0:未审核，1:审核通过  1.甲方负责人  2.项目负责人  3.维护人员 4.系统管理员 5  注册工程师
- (void)userListWithUsername:(NSString *)username roleids:(NSString *)roleids status:(NSString *)status backData:(data)backData;
///获取用户详情
- (void)userDetailUserid:(NSString *)userid backData:(data)backData;
@end

NS_ASSUME_NONNULL_END
