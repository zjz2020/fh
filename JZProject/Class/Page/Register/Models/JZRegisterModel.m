//
//  JZRegisterModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZRegisterModel.h"

@implementation JZRegisterModel
+ (JZRegisterModel *)shareModel{
    return [[JZRegisterModel alloc] init];
}
+ (NSDictionary *)changeDicWithModel:(JZRegisterModel *)model{
    NSMutableDictionary *dic =[NSMutableDictionary new];
    [dic setValue:model.roleId forKey:@"roleId"];
    [dic setValue:model.userPhone forKey:@"userPhone"];
    [dic setValue:model.verifyCode forKey:@"verifyCode"];
    [dic setValue:model.passWord forKey:@"passWord"];
    if (model.userName && model.userName.length > 0) {
        [dic setValue:model.userName forKey:@"userName"];
    }
    if (model.companyname && model.companyname.length > 0) {
        [dic setValue:model.companyname forKey:@"companyname"];
    }
    if (model.provice && model.provice.length > 0) {
        [dic setValue:model.provice forKey:@"provice"];
    }
    if (model.city && model.city.length > 0) {
        [dic setValue:model.city forKey:@"city"];
    }
    if (model.area && model.area.length > 0) {
        [dic setValue:model.area forKey:@"area"];
    }
    if (model.address && model.address.length > 0) {
        [dic setValue:model.address forKey:@"address"];
    }
    if (model.serviceid) {
        [dic setValue:model.serviceid forKey:@"serviceid"];
    }
    if (model.contacts && model.contacts.length > 0) {
        [dic setValue:model.contacts forKey:@"contacts"];
    }
    if (model.contactstel && model.contactstel.length > 0) {
        [dic setValue:model.contactstel forKey:@"contactstel"];
    }
    if (model.expectsuppor && model.expectsuppor.length > 0) {
        [dic setValue:model.expectsuppor forKey:@"expectsuppor"];
    }
    if (model.remark && model.remark.length > 0) {
        [dic setValue:model.remark forKey:@"remark"];
    }
    if (model.university && model.university.length > 0) {
        [dic setValue:model.university forKey:@"university"];
    }
    if (model.experience && model.experience.length > 0) {
        [dic setValue:model.experience forKey:@"experience"];
    }
    if (model.sex && model.sex.length > 0) {
        [dic setValue:model.sex forKey:@"sex"];
    }
    if (model.skill) {
        [dic setValue:model.skill forKey:@"skill"];
    }
    if (model.intention) {
        [dic setValue:model.intention forKey:@"intention"];
    }
    if (model.certificate && model.certificate.length > 0) {
        [dic setValue:model.certificate forKey:@"certificate"];
    }
    return dic;
}
@end
