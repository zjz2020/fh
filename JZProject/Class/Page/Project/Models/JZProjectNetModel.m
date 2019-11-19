//
//  JZProjectNetModel.m
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProjectNetModel.h"
#import "JZMainProjectModel.h"
#import "JZProjectModel.h"
#import "JZNotificaModel.h"
@implementation JZProjectNetModel
+ (JZProjectNetModel *)shareProjectNetModel{
    return [[JZProjectNetModel alloc]  init];
}
///创建项目
- (void)createProjectWithModel:(JZProjectModel *)model isEdit:(BOOL)edit backData:(data)backData {
    if (edit) {
        [self updateProjectWithModel:model backData:backData];
        return;
    }
    NSDictionary *dic = [JZProjectModel shareDicWithModel:model isCreat:true];
    NSNumber *parameterOk = dic[@"parameterOk"];
    if ([parameterOk isEqualToNumber:@0]) {
        return;
    }
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self createProjectWithParamts:newDic backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
- (void)createProjectWithParamts:(NSDictionary *)paramts backData:(nonnull data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/createProject"];
    [self postWithDic:paramts url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///删除项目 
-(void)delProjectWithProjectId:(NSString *)projectId backData:(data)backData{
    NSDictionary *dic = @{
                          @"projectId":projectId,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/delProject"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///查看用户项目
-(void)queryProjectWithProjectStatus:(NSString *)status content:(NSString *)content backData:(data)backData{
    NSDictionary *dic = @{
                          @"userId":[JZNetWorkHelp shareNetWork].userId?[JZNetWorkHelp shareNetWork].userId:@"",
                          };
    if (content && content.length > 0) {
       dic = @{
          @"userId":[JZNetWorkHelp shareNetWork].userId?[JZNetWorkHelp shareNetWork].userId:@"",
          @"content":content,
          };
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryProjectByUser"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *marray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZMainProjectModel *mainModel = [JZMainProjectModel shareMainModel];
                [mainModel setValuesForKeysWithDictionary:dic];
                [marray addObject:mainModel];
            }
            backData(netOk,marray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///更新用户项目
- (void)updateProjectWithModel:(JZProjectModel *)model backData:(data)backData {
    model.userId = [JZNetWorkHelp shareNetWork].userId;
    NSDictionary *dic = [JZProjectModel shareDicWithModel:model isCreat:false];
    NSNumber *parameterOk = dic[@"parameterOk"];
    if ([parameterOk isEqualToNumber:@0]) {
        return;
    }
    [self updateProjectWithParamts:dic backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
- (void)updateProjectWithParamts:(NSDictionary *)paramts backData:(nonnull data)backData{
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/updateProject"];
    [self postWithDic:paramts url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}

///查看警告列表
- (void)queryEventWarningWithProjectId:(NSString *)projectId time:(nonnull NSString *)time backData:(nonnull data)backData {
    NSDictionary *dic = @{
                          @"projectId":projectId,
                          };
    if (time && time.length > 0) {
        dic = @{
                @"projectId":projectId,
                @"time":time,
                };
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryEventWarning"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *maary = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZRecordListModel *listModel = [JZRecordListModel shareRecordList];
                listModel.month = dic[@"month"];
                NSMutableArray *listArray = [NSMutableArray new];
                for (NSDictionary *testDic in dic[@"dataBean"]) {
                    JZEventModel *event = [JZEventModel shareEventModel];
                    [event setValuesForKeysWithDictionary:testDic];
                    [listArray addObject:event];
                }
                listModel.recordList = listArray;
                [maary addObject:listModel];
            }
            backData(netOk,maary);
        } else {
             backData(netOk,responseObj);
        }
    }];
    
}
- (void)uploadProjectFileWithData:(NSData *)data backData:(nonnull data)backData{
     NSString *urlStr = @"http://api.fire2008.com.cn/operationscenter/project/uploadProjectFile";
    [self uploadImageWithData:data urlStr:urlStr backData:^(BOOL netOk, id  _Nonnull responseObj) {
        backData(netOk,responseObj);
    }];
}
///8.查看项目详情
- (void)queryProjectInfoWithProjectId:(NSString *)projectId backData:(data)backData {
    NSDictionary *dic = @{
                          @"projectId":projectId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryProjectInfo"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            JZProjectModel *model = [JZProjectModel shareModel];
            [model setValuesForKeysWithDictionary:responseObj];
            backData(netOk,model);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///9.查看通知列表
- (void)queryMsgRecordWithContent:(NSString *)content BackData:(data)backData {
    NSDictionary *dic = @{
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    if (content && content.length > 0) {
        dic = @{
                @"userId":[JZNetWorkHelp shareNetWork].userId,
                @"content":content,
                };
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryMsgRecord"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                JZNotificaModel *notific = [JZNotificaModel shareMotificaModel];
                [notific setValuesForKeysWithDictionary:dic];
                [mArray addObject:notific];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///10.查看维护记录  queryEventRecord
- (void)queryEventRecordWithProjectId:(NSString *)projectId time:(NSString *)time backData:(data)backData{
    NSDictionary *dic = @{
                          @"projectId":projectId,
                          };
    if (time && time.length > 0) {
        dic = @{
                @"projectId":projectId,
                @"time":time,
                };
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryEventRecord"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj) {
                NSMutableArray *listArray = [NSMutableArray new];
                JZRecordListModel *listModel = [JZRecordListModel shareRecordList];
                listModel.month = dic[@"month"];
                for (NSDictionary *newDic in dic[@"dataBean"]) {
                    JZRecordModel *recordModel = [JZRecordModel shareRecordModel];
                    [recordModel setValuesForKeysWithDictionary:newDic];
                    [listArray addObject:recordModel];
                }
                listModel.recordList = listArray;
                [mArray addObject:listModel];
            }
            backData(netOk,mArray);
        } else {
            backData(netOk,responseObj);
        }
    }];
}

///11.查看zb信息
- (void)queryZbAccountWithProjectId:(NSString *)projectId backData:(data)backData{
    NSDictionary *dic = @{
                          @"projectId":projectId,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryZbAccount"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            if ([responseObj isKindOfClass:[NSDictionary class]]) {
                [JZNetWorkHelp shareNetWork].zbip = responseObj[@"zbip"];
                [JZNetWorkHelp shareNetWork].zbusername = responseObj[@"zbusername"];
                [JZNetWorkHelp shareNetWork].zbuserpwd = responseObj[@"zbuserpwd"];
                backData(netOk,responseObj);
            } else {
                [JZTost showTost:@"暂无zb数据"];
                 backData(false,@"暂无zb数据");
            }
            
        } else {
            backData(netOk,responseObj);
        }
    }];
}
///12.告警接收  推送通知
- (void)pushEventbackData:(data)backData {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/events/pushEvent"];
    [self postWithDic:@{} url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
      
    }];
}
///13.告警取消
- (void)warningCancelWithId:(NSString *)eventWarningId backData:(nonnull data)backData{
    NSDictionary *dic = @{
                          @"eventWarningId":eventWarningId,
                          @"userId":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/events/warningCancel"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
           
        } else {
            
        }
    }];
}
- (void)passProjectWithId:(NSString *)projectId backData:(data)backData{
    NSDictionary *dic = @{
                          @"projectids":projectId,
                          @"userid":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/pass"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            
        } else {
            
        }
    }];
}
-(void)refuseProjectWithId:(NSString *)projectId backData:(data)backData{
    NSDictionary *dic = @{
                          @"projectids":projectId,
                          @"userid":[JZNetWorkHelp shareNetWork].userId,
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/refuse"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            
        } else {
            
        }
    }];
}
///超级管理员 项目列表
- (void)superManQueryProjectListWithprojectName:(NSString *)projectname pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize auditstatus:(NSString *)auditstatus backData:(data)backData {
    
    NSDictionary *dic = @{
                          @"pageNo":pageNo,
                          @"pageSize":pageSize,
                          @"auditstatus":auditstatus,
                          @"userid":[JZNetWorkHelp shareNetWork].userId,
                          };
    if (projectname && projectname.length > 0) {
        dic = @{
                @"projectname":projectname,
                @"pageNo":pageNo,
                @"pageSize":pageSize,
                @"auditstatus":auditstatus,
                @"userid":[JZNetWorkHelp shareNetWork].userId,
                };
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,@"/project/queryProjectList"];
    [self postWithDic:dic url:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *marray = [NSMutableArray new];
            if ([responseObj[@"total"] intValue] == 0) {
                 backData(netOk,@[]);
            } else {
                for (NSDictionary *dic in responseObj[@"rows"]) {
                    JZMainProjectModel *mainModel = [JZMainProjectModel shareMainModel];
                    [mainModel setValuesForKeysWithDictionary:dic];
                    [marray addObject:mainModel];
                }
                backData(netOk,marray);
            }
        } else {
            backData(netOk,responseObj);
        }
    }];
}
@end
