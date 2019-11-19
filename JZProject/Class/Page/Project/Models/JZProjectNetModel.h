//
//  JZProjectNetModel.h
//  JZProject
//  创建项目网络请求
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNetWorkHelp.h"
#import "JZProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZProjectNetModel : JZNetWorkHelp
+ (JZProjectNetModel *)shareProjectNetModel;
///1.创建项目
- (void)createProjectWithModel:(JZProjectModel *)model isEdit:(BOOL)edit backData:(data)backData;
- (void)createProjectWithParamts:(NSDictionary *)paramts backData:(data)backData;
///2.删除项目
- (void)delProjectWithProjectId:(NSString *)projectId backData:(data)backData;
///3.查看用户项目
- (void)queryProjectWithProjectStatus:(NSString *)status content:(NSString *)content backData:(data)backData;
///4.更新用户项目
- (void)updateProjectWithModel:(JZProjectModel *)model backData:(data)backData;
- (void)updateProjectWithParamts:(NSDictionary *)paramts backData:(data)backData;
///5.附件下载

///6.附件上传
- (void)uploadProjectFileWithData:(NSData *)data backData:(data)backData;
///7.查看警告列表
- (void)queryEventWarningWithProjectId:(NSString *)projectId time:(NSString *)time backData:(data)backData;
///8.查看项目详情
- (void)queryProjectInfoWithProjectId:(NSString *)projectId backData:(data)backData;
///9.查看通知列表
- (void)queryMsgRecordWithContent:(NSString *)content BackData:(data)backData;
///10.查看维护记录  queryEventRecord
- (void)queryEventRecordWithProjectId:(NSString *)projectId time:(NSString *)time backData:(data)backData;
///11.查看zb信息
- (void)queryZbAccountWithProjectId:(NSString *)projectId backData:(data)backData;
///12.告警接收  推送通知
- (void)pushEventbackData:(data)backData;
///13.告警取消
- (void)warningCancelWithId:(NSString *)eventWarningId backData:(data)backData;
///14.审核通过
- (void)passProjectWithId:(NSString *)projectId backData:(data)backData;
///15审核拒绝
- (void)refuseProjectWithId:(NSString *)projectId backData:(data)backData;
///超级管理员 项目列表
/** auditstatus
0 未审批
1 审批通过
2 审批拒绝
3 关闭*/
- (void)superManQueryProjectListWithprojectName:(NSString *)projectname pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize auditstatus:(NSString *)auditstatus backData:(data)backData;
@end

NS_ASSUME_NONNULL_END
