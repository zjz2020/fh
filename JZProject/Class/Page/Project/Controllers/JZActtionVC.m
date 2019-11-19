//
//  JZActtionVC.m
//  JZProject
//
//  Created by zjz on 2019/8/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZActtionVC.h"

@interface JZActtionVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;

@end

@implementation JZActtionVC
+ (JZActtionVC *)shareActionVC {
    return [[JZActtionVC alloc] initWithNibName:@"JZActtionVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.Showtitle;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = GrayColor2.CGColor;
    self.textView.layer.borderWidth = 1;
    if (self.planText) {
        self.textView.text = self.planText;
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)upBtnAction:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    if ([self.Showtitle isEqualToString:@"提交计划"]) {
        [self.faultNetModel insertHandlePlanWithFaultid:self.faultid plan:self.textView.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                 [[NSNotificationCenter defaultCenter] postNotificationName:notification_alart object:@""];
                [JZTost showTost:@"提交计划成功"];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    } else if ([self.Showtitle isEqualToString:@"确认计划"]) {
        [self.faultNetModel confirmFaultPlanWithDefendid:self.faultid resultdesc:self.textView.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                 [[NSNotificationCenter defaultCenter] postNotificationName:notification_alart object:@""];
                 [[NSNotificationCenter defaultCenter] postNotificationName:notification_record object:@""];
                [JZTost showTost:@"确认计划成功"];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    } else if ([self.Showtitle isEqualToString:@"维护完成"]) {
        [self.faultNetModel finishFaultDefendWithFaultid:self.faultid resultdesc:self.textView.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                 [[NSNotificationCenter defaultCenter] postNotificationName:notification_record object:@""];
                [JZTost showTost:@"维护完成成功"];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    } else if ([self.Showtitle isEqualToString:@"确认完成"]) {
        [self.faultNetModel confirmFinishFaultDefendWithDefendid:self.faultid resultdesc:self.textView.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:notification_record object:@""];
                [JZTost showTost:@"确认成功"];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    }
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
