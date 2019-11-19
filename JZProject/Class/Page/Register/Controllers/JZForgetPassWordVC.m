 //
//  JZForgetPassWordVC.m
//  JZProject
//
//  Created by zjz on 2019/7/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZForgetPassWordVC.h"
#import "JZRegisterNetModel.h"
@interface JZForgetPassWordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWord1TF;
@property (weak, nonatomic) IBOutlet UITextField *passWord2TF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *passBtn1;
@property (weak, nonatomic) IBOutlet UIButton *passBtn2;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeHeight;
@property(nonatomic,strong)JZRegisterNetModel *registerNet;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headLabelHeght;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation JZForgetPassWordVC
+ (JZForgetPassWordVC *)shareForgetPassWordVcWithType:(NSInteger)type {
    JZForgetPassWordVC *VC= [[JZForgetPassWordVC alloc] initWithNibName:@"JZForgetPassWordVC" bundle:[NSBundle mainBundle]];
    VC.type = type;
    return VC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureBtn.layer.masksToBounds = true;
    self.sureBtn.layer.cornerRadius = 5;
    self.registerNet = [JZRegisterNetModel shareRegistNetModel];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)creactUI {
    self.passWord1TF.secureTextEntry = YES;
    self.passWord2TF.secureTextEntry = YES;
    
    self.phoneTextF.delegate = self;
     self.codeTF.delegate = self;
     self.passWord1TF.delegate = self;
     self.passWord2TF.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.passWord1TF.textContentType = UITextContentTypePassword;
        self.passWord2TF.textContentType = UITextContentTypePassword;
    }
    if (@available(iOS 12.0, *)) {
        self.passWord1TF.textContentType = UITextContentTypeNewPassword;
        self.passWord2TF.textContentType = UITextContentTypeNewPassword;
    } else {
        // Fallback on earlier versions
    }
    self.phoneTextF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    if (self.type == 0) {
        self.codeTF.placeholder = @"请输入验证码";
        self.passWord1TF.placeholder = @"请输入密码";
        self.passWord2TF.placeholder = @"二次输入密码";
        
    } else if (self.type == 1) {
        self.headLabel.hidden = YES;
        self.backBtn.hidden = YES;
        self.headLabel.height = 0;
        self.headLabelHeght.constant = 0;
        self.title = @"修改密码";
        self.codeView.height = 0;
        self.codeHeight.constant = 0;
        self.codeView.hidden = YES;
        self.passWord1TF.placeholder = @"请输入原密码";
        self.passWord2TF.placeholder = @"请输入新密码";
    }
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
//    NSDictionary *userInfo = [notification userInfo];
//    NSValue *value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGRect keyboardRect = [value CGRectValue];
//    int height = keyboardRect.size.height;
    if ((self.passWord2TF.isEditing || self.passWord1TF.isEditing ) && self.type == 0) {
        self.view.y = -50;
    }
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.view.y = 0;
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}
#pragma mark btnAction

- (IBAction)backBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)codeAction:(UIButton *)sender {
    if (![self isIphone:self.phoneTextF.text]) {
        [JZTost showTost:@"请输入正确手机号码"];
        return;
    }
    [self.registerNet sendSMSWithPhone:self.phoneTextF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (!netOk) {
            [JZTost showTost:responseObj];
        }
    }];
}
- (IBAction)passWord1BtnAction:(UIButton *)sender {
    self.passWord1TF.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}
- (IBAction)passWord2BtnAction:(UIButton *)sender {
    self.passWord2TF.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}
- (IBAction)okBtnAction:(UIButton *)sender {
    if (![self isIphone:self.phoneTextF.text]) {
        [JZTost showTost:@"请输入正确手机号码"];
        return;
    }
    if (self.type == 0) {
        if (self.codeTF.text.length == 0) {
            [JZTost showTost:@"请输入验证码"];
            return;
        }
        [self.registerNet resetPwdPwdWithPhone:self.phoneTextF.text passWord:self.passWord2TF.text verifyCode:self.codeTF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [self.navigationController popViewControllerAnimated:YES];
                [JZTost showTost:@"重置密码成功"];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    } else if (self.type == 1) {
        [self.registerNet updatePwdWithPhone:self.phoneTextF.text passWordOld:self.passWord1TF.text passWordNew:self.passWord2TF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [self dismissViewControllerAnimated:YES completion:nil];
                [JZTost showTost:@"修改密码成功"];
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
