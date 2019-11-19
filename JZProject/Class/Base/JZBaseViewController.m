//
//  JZBaseViewController.m
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

@interface JZBaseViewController ()

@end

@implementation JZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    self.widnow = widow;
    self.netHelp = [JZNetWorkHelp shareNetWork];
    self.projectNetModel = [JZProjectNetModel shareProjectNetModel];
    self.faultNetModel = [JZFaultNetModel shareFaultNetModel];
    self.baseNetMode = [JZBaseNetModel shareBaseNetModel];
    [self creactUI];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    // Do any additional setup after loading the view.
}
- (BOOL)isIphone:(NSString *)string {
    NSString *phoneRegex = @"^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[4,5,6,7,8,9])|(19[8,9])|(166))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

- (BOOL)isString:(NSString *)string {
    if (!string || string.length == 0) {
        return NO;
    }
    return YES;
}
- (NSString *)changeStringToTime:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];//yyyy年MM月dd日
    
    NSString *dateString = [time substringToIndex:10];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:date];
}
- (UIAlertController *)alertWithTitle:(NSString *)title content:(NSString *)content okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle okAction:(void (^)(void))okAction cancelAction:(void (^)(void))cancelAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelAction();
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okAction();
    }];
    [alertC addAction:cancel];
    [alertC addAction:ok];
    
    return alertC;
}
- (void)creactUI{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
