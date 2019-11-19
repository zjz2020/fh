//
//  JZShowManModel.h
//  JZProject
//
//  Created by zjz on 2019/11/9.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZShowManModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *loginname;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *provice;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *orgid;
@property(nonatomic,copy)NSString *orgname;
@property(nonatomic,copy)NSString *pushid;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *roleid;
@property(nonatomic,copy)NSString *rolename;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *last_login;
@property(nonatomic,copy)NSString *serviceid;
@property(nonatomic,copy)NSString *isdelete;
@property(nonatomic,copy)NSString *companyname;
@property(nonatomic,copy)NSString *servicecontext;
@property(nonatomic,copy)NSString *contacts;
@property(nonatomic,copy)NSString *contactstel;
@property(nonatomic,copy)NSString *expectsupport;
@property(nonatomic,copy)NSString *university;
@property(nonatomic,copy)NSString *experience;
@property(nonatomic,copy)NSString *skill;
@property(nonatomic,copy)NSString *intention;
@property(nonatomic,copy)NSString *certificate;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *status;
+ (JZShowManModel *)showMan;
@end

NS_ASSUME_NONNULL_END
