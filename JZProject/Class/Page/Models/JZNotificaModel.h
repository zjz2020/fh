//
//  JZNotificaModel.h
//  JZProject
//
//  Created by zjz on 2019/7/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZNotificaModel : NSObject
+ (JZNotificaModel *)shareMotificaModel;
///用户ID
@property(nonatomic,copy)NSString *userid;
///备注
@property(nonatomic,copy)NSString *remark;
///推送时间
@property(nonatomic,copy)NSString *pushtime;
///消息名称
@property(nonatomic,copy)NSString *msgtitle;
///n通知内容
@property(nonatomic,copy)NSString *msgcontext;
///通知ID
@property(nonatomic,strong)NSNumber *noticeId;
///创建时间
@property(nonatomic,strong)NSNumber *createtime;
///项目名称
@property(nonatomic,copy)NSString *projectname;
///项目ID
@property(nonatomic,copy)NSString *projectid;
///故障ID
@property(nonatomic,copy)NSString *faultid;
///通知类型  1告警 2.项目管理  3.人员管理
@property(nonatomic,copy)NSString *type;
///警告事件状态
@property(nonatomic,strong)NSNumber *warringstatus;
@end

NS_ASSUME_NONNULL_END
