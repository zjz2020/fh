//
//  JZMainProjectModel.h
//  JZProject
//
//  Created by zjz on 2019/7/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZMainProjectModel : NSObject
+(JZMainProjectModel *)shareMainModel;
///项目ID
@property(nonatomic,strong)NSString *projectId;
///项目名称
@property(nonatomic,strong)NSString *projectName;
///状态  0 未激活  1 正常  2 异常
@property(nonatomic,strong)NSNumber *projectStatus;
///项目创建时间 
@property(nonatomic,copy)NSString *projectcreatetime;
@end

NS_ASSUME_NONNULL_END
