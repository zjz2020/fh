//
//  JZProgress.m
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProgress.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation JZProgress
+ (void)show{
    [SVProgressHUD show];
}
+ (void)showWithStatus:(NSString*)string{
    [SVProgressHUD showWithStatus:string];
}
+ (void)showProgress:(CGFloat)progress{
    [SVProgressHUD showProgress:progress];
}
+ (void)showProgress:(CGFloat)progress status:(NSString*)status{
    [SVProgressHUD showProgress:progress status:status];
}
+ (void)dismiss{
    [SVProgressHUD dismiss];
}
+ (void)dismissWithDelay:(NSTimeInterval)delay{
    [SVProgressHUD dismissWithDelay:delay];
}
@end
