//
//  JZRegisterModel.h
//  JZProject
//  注册对象
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZRegisterModel : NSObject
+ (JZRegisterModel *)shareModel;
+ (NSDictionary *)changeDicWithModel:(JZRegisterModel *)model;
///角色ID
@property(nonatomic,copy)NSString *roleId;
///手机号
@property(nonatomic,copy)NSString *userPhone;
///验证码
@property(nonatomic,copy)NSString *verifyCode;
///密码
@property(nonatomic,copy)NSString *passWord;
///项目
@property(nonatomic,copy)NSString *userName;
///单位名称
@property(nonatomic,copy)NSString *companyname;
///省
@property(nonatomic,copy)NSString *provice;
///市
@property(nonatomic,copy)NSString *city;
///区
@property(nonatomic,copy)NSString *area;
///详细地址
@property(nonatomic,copy)NSString *address;
///服务需求
@property(nonatomic,copy)NSString *serviceid;
///联系人
@property(nonatomic,copy)NSString *contacts;
///联系方式
@property(nonatomic,copy)NSString *contactstel;
///希望技术支持
@property(nonatomic,copy)NSString *expectsuppor;
///补充说明
@property(nonatomic,copy)NSString *remark;
///毕业院校
@property(nonatomic,copy)NSString *university;
///工作经验
@property(nonatomic,copy)NSString *experience;
///性别
@property(nonatomic,copy)NSString *sex;
///技能
@property(nonatomic,copy)NSString *skill;
///意向
@property(nonatomic,copy)NSString *intention;
///个人证书
@property(nonatomic,copy)NSString *certificate;
@end

NS_ASSUME_NONNULL_END
