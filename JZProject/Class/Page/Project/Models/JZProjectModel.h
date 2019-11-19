//
//  JZProjectModel.h
//  JZProject
//  项目创建
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZProjectModel : NSObject
+ (JZProjectModel *)shareModel;
+ (NSDictionary *)shareDicWithModel:(JZProjectModel *)model isCreat:(BOOL)creat;
///项目名称
@property(nonatomic,copy)NSString *projectname;
///项目id
@property(nonatomic,copy)NSString *projectid;
///单位名称n
@property(nonatomic,copy)NSString *orgname;
///省
@property(nonatomic,copy)NSString *province;
///市
@property(nonatomic,copy)NSString *city;
///区
@property(nonatomic,copy)NSString *county;
///详细地址
@property(nonatomic,copy)NSString *address;
///项目创建时间
@property(nonatomic,copy)NSString *projectcreatetime;//
///服务有效时间
@property(nonatomic,copy)NSString *effectivetime;
///服务有效时间描述
@property(nonatomic,copy)NSString *effectiveDec;
///服务内容ID
@property(nonatomic,copy)NSString *serviceid;
///服务内容描述
@property(nonatomic,copy)NSString *serviceditemetail;//
///巡检项目ID
@property(nonatomic,copy)NSString *taskid;
///巡检名
@property(nonatomic,copy)NSString *taskname;//
///服务开始时间
@property(nonatomic,copy)NSString *servicestarttime;
///服务结束时间
@property(nonatomic,copy)NSString *serviceendtime;
///项目负责人ID
@property(nonatomic,copy)NSString *headid;
///项目负责人
@property(nonatomic,copy)NSString *headname;
///项目负责人手机号
@property(nonatomic,copy)NSString *headmobile;
///维护人员列表
@property(nonatomic,copy)NSArray *servicePerson;
///甲方负责人列表
@property(nonatomic,copy)NSArray *partyasPerson;
///补充说明
@property(nonatomic,copy)NSString *projectmemo;//
///用户ID
@property(nonatomic,copy)NSString *userId;
///图片地址
@property(nonatomic,copy)NSString *fileurl;
///状态
@property(nonatomic,copy)NSString *auditstatus;
@end

///项目人员

@interface JZManModel : NSObject
+ (JZManModel *)shareModel;
- (NSDictionary *)shareDicWithModel:(JZManModel *)model;
- (JZManModel *)shareManModelWithDic:(NSDictionary *)dic;
///用户ID
@property(nonatomic,copy)NSString *userId;
///用户名
@property(nonatomic,copy)NSString *userName;
///手机号
@property(nonatomic,copy)NSString *mobile;
///省
@property(nonatomic,copy)NSString *provice;
///市
@property(nonatomic,copy)NSString *city;
///区
@property(nonatomic,copy)NSString *area;
///详细地址
@property(nonatomic,copy)NSString *address;
@end


///维护信息修改
@interface JZEventModel : NSObject
+ (JZEventModel *)shareEventModel;
///id---faultid
@property(nonatomic,copy)NSString *eventId;
///id---id
@property(nonatomic,copy)NSString *id_id;
///host
@property(nonatomic,copy)NSString *eventhost;
///ip
@property(nonatomic,copy)NSString *eventip;
///详情
@property(nonatomic,copy)NSString *eventdetail;
///说明
@property(nonatomic,copy)NSString *declaretxt;
///time
@property(nonatomic,copy)NSString *eventtime;
///zabbixeid
@property(nonatomic,copy)NSString *zabbixeid;
///是否删除
@property(nonatomic,assign)BOOL isdelete;
///自己的名字  申报人名字
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *faulttype;
@property(nonatomic,copy)NSString *projectname;
///计划
@property(nonatomic,copy)NSString *plan;
///设备名
@property(nonatomic,copy)NSString *equipment;
- (NSDictionary *)backEvenDic;
@end

//维护列表数据
@interface JZRecordListModel : NSObject
+ (JZRecordListModel *)shareRecordList;
@property(nonatomic,strong)NSArray *recordList;
@property(nonatomic,copy)NSString *month;
@end

///维护信息修改
@interface JZRecordModel : NSObject
+ (JZRecordModel *)shareRecordModel;
///项目名称
@property(nonatomic,copy)NSString *projectName;
///备注
@property(nonatomic,copy)NSString *remark;
///ip
@property(nonatomic,copy)NSString *ip;
///z故障ID
@property(nonatomic,copy)NSString * faultid;
///z故障状态
@property(nonatomic,copy)NSString * faultStatus;
///故障时间
@property(nonatomic,copy)NSString *faultTime;
///维护时间
@property(nonatomic,copy)NSString *defendTime;
///故障描述
@property(nonatomic,copy)NSString *faultDesc;
///维护
@property(nonatomic,copy)NSString *defender;
///维护状态
@property(nonatomic,copy)NSString *defendStatus;
///维护结果描述
@property(nonatomic,copy)NSString *defendResultDesc;
///庄家
@property(nonatomic,copy)NSString *declarer;
///维护结果
@property(nonatomic,strong)NSNumber *defendResult;
///维护结果 defendRemark
@property(nonatomic,copy)NSString *defendRemark;
///故障类型
@property(nonatomic,copy)NSString *eventhost;
///设备
@property(nonatomic,copy)NSString *equipment;
@end
NS_ASSUME_NONNULL_END
