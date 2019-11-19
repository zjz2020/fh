//
//  JZBaseViewController.h
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZNetWorkHelp.h"
#import "JZProjectNetModel.h"
#import "JZFaultNetModel.h"
#import "JZBaseNetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZBaseViewController : UIViewController
@property(nonatomic,strong)UIWindow *widnow;
@property(nonatomic,strong)JZNetWorkHelp *netHelp;
@property(nonatomic,strong)JZProjectNetModel *projectNetModel;
@property(nonatomic,strong)JZFaultNetModel *faultNetModel;
@property(nonatomic,strong)JZBaseNetModel *baseNetMode;
@property(nonatomic,strong)UIAlertController *alertController;
- (UIAlertController *)alertWithTitle:(NSString *)title content:(NSString *)content okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle okAction:(void(^)(void))okAction cancelAction:(void(^)(void))cancelAction;
- (void)creactUI;
- (BOOL)isIphone:(NSString *)string;
- (BOOL)isString:(NSString *)string;
///时间戳转换
- (NSString *)changeStringToTime:(NSString *)time;
@end

NS_ASSUME_NONNULL_END
