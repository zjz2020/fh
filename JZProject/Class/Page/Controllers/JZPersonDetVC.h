//
//  JZPersonDetVC.h
//  JZProject
//
//  Created by zjz on 2019/11/9.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"
#import "JZShowManModel.h"
#import "JZRegisterNetModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^data)(BOOL netOk,id responseObj);
@interface JZPersonDetVC : JZBaseViewController
@property(nonatomic,assign)NSInteger showPass;
@property(nonatomic,strong)JZShowManModel *model;
@property(nonatomic,strong)JZRegisterNetModel *netModel;
@property(nonatomic,copy)data backData;
@end

NS_ASSUME_NONNULL_END
