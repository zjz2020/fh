//
//  JZTheViewController.m
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZTheViewController.h"
#import "JZNetWorkHelp.h"
#import "JZPickeView.h"
#import "JzOnePickerView.h"
#import "JZUserRegisterVC.h"
#import "JZEngineerRegistVC.h"
#import "JZDatePickeView.h"
#import "JZRegisterNetModel.h"
#import "HXLineChart.h"
#import "JZForgetPassWordVC.h"
#import "JPUSHService.h"
#import "JZRegisterNetModel.h"
#import "JZWebViewController.h"
@interface JZTheViewController ()<AddressPickerDelegate,UITextFieldDelegate,onePickerDelegate,datePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,copy)login logState;
@property(nonatomic,strong)JZPickeView *addPickeView;
@property(nonatomic,strong)JZOnePickerView *onePicker;
@property (weak, nonatomic) IBOutlet UIView *storkView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong)JZDatePickeView *nDatePicker;

@end

@implementation JZTheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.loginBtn.layer.masksToBounds = true;
    self.loginBtn.layer.cornerRadius = 5;
    self.timeTF.delegate = self;
    self.timeTF.hidden = YES;
  
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:user_name_save];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:user_pass_word_save];
    if (name && name.length > 0) {
        self.contentTF.text = name;
    }
    if (password && password.length > 0) {
        self.passWordTF.text = password;
    }
    
    [self.baseNetMode appGetVersionBackData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (responseObj[@"isforce"]) {//
            [self checkVersion:responseObj[@"version"] force:responseObj[@"isforce"] url:responseObj[@"url"]];
        }
    }];
//    self.timeTF.inputView = self.datePicker;
//    [self.datePicker addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotification:) name:@"test" object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//用户协议
- (IBAction)userAction:(UIButton *)sender {
    JZWebViewController *web = [[JZWebViewController alloc] init];
    web.title = @"用户协议";
    web.urlStr = @"http://www.fire2008.com.cn/html/fenghuo_user_protocol.html";
     [self presentViewController:web animated:YES completion:nil];
}

//隐私政策
- (IBAction)userActionTwe:(UIButton *)sender {
    JZWebViewController *web = [[JZWebViewController alloc] init];
    web.title = @"隐私政策";
    web.urlStr = @"http://www.fire2008.com.cn/html/fenghuo_conceal_protocol.html";
     [self presentViewController:web animated:YES completion:nil];
}

-(void)didNotification:(NSNotification *)notifiction {
    [self login];
}
- (NSString*) getLocalVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //当前版本号
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return currentVersion;
}
- (void)checkVersion:(NSString *)version force:(BOOL)force url:(NSString *)url{//版本判断
    return;
//    url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",@"1066602104"];
    NSString *currentVersion = [self getLocalVersion];
    NSArray *currentArray = [currentVersion componentsSeparatedByString:@"."];
    NSArray *appStroArray = [version componentsSeparatedByString:@"."];
    BOOL refresh = NO;
    NSInteger num = currentArray.count >= appStroArray.count ? appStroArray.count : currentArray.count;
    for (NSInteger i = 0; i < num; i ++) {
        if ([appStroArray[i] integerValue] > [currentArray[i] integerValue]) {
            refresh = YES;
            break;
        }else if ([appStroArray[i] integerValue] < [currentArray[i] integerValue]){
            refresh = NO;
            break;
        }
    }
    //  NSDictionary *result = @{@"ver" : currentVersion};
    
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"注意" message:@"有新版本需可以更新" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (force) {
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];
        }
        //    NSLog(@"点击了按钮1，进入按钮1的事件");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //    callback(@[@(1),@"fsf"]);
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:ok];
    if (!force) {//
        [actionSheet addAction:cacel];
    }
    
    //相当于之前的[actionSheet show];
    if (refresh) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];
    }
}
- (void)loginStata:(login)callback{
    self.logState = callback;
}

- (IBAction)userRegister:(id)sender {
    [self presentViewController:[JZUserRegisterVC shareRegister] animated:YES completion:nil];
//    [self.navigationController pushViewController:[JZUserRegisterVC shareRegister] animated:YES];
}
- (IBAction)engineerRegister:(id)sender {
    JZEngineerRegistVC *eng = [JZEngineerRegistVC shareEngineer];
    eng.modalPresentationStyle = UIModalPresentationPageSheet;
     [self presentViewController:eng animated:YES completion:nil];
//    [self presentViewController:[JZEngineerRegisterVC shareEngineer] animated:YES completion:nil];
//    [self.navigationController pushViewController:[JZEngineerRegisterVC shareEngineer] animated:YES];
}
- (IBAction)resetPassWord:(UIButton *)sender {
    JZForgetPassWordVC *password = [JZForgetPassWordVC shareForgetPassWordVcWithType:0];
    password.type = 0;
    [self presentViewController:password animated:YES completion:nil];
}
- (IBAction)updatePassWord:(UIButton *)sender {
     JZForgetPassWordVC *password = [JZForgetPassWordVC shareForgetPassWordVcWithType:1];
     [self.navigationController pushViewController:password animated:YES];
}
- (void)keepUserName:(NSString *)name passWord:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:user_name_save];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:user_pass_word_save];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)loginAction:(UIButton *)sender {
    [self login];
}
- (void)login{
    [self.contentTF endEditing:YES];
    [self.passWordTF endEditing:YES];
    if (![super isString:self.contentTF.text] || ![super isString:self.passWordTF.text]) {
        [JZTost showTost:@"请输入你的账号密码"];
    }
    JZRegisterNetModel *regist = [JZRegisterNetModel shareRegistNetModel];
    __weak typeof(self) weakSelf = self;
    [regist loginWithName:self.contentTF.text passWord:self.passWordTF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [weakSelf keepUserName:self.contentTF.text passWord:self.passWordTF.text];
            [JZNetWorkHelp shareNetWork].token = responseObj[@"token"];
            [JZNetWorkHelp shareNetWork].userId = responseObj[@"userId"];
            [JZNetWorkHelp shareNetWork].phone = responseObj[@"phone"];
            [JZNetWorkHelp shareNetWork].userName = responseObj[@"userName"];
            [JZNetWorkHelp shareNetWork].roleId = responseObj[@"roleId"];
            [JZNetWorkHelp shareNetWork].roleName = responseObj[@"roleName"];
            NSString *jpushService = [[NSUserDefaults standardUserDefaults] objectForKey:@"jpushService"];
            if (!jpushService || jpushService.length == 0) {
                jpushService = [JPUSHService registrationID];
                [[NSUserDefaults standardUserDefaults] setObject:jpushService forKey:@"jpushService"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            if (jpushService && jpushService.length > 0) {
                JZRegisterNetModel *regist = [JZRegisterNetModel shareRegistNetModel];
                [regist uploadJGpushIdWithPushId:jpushService backData:^(BOOL netOk, id  _Nonnull responseObj) {
                    
                }];
            }
            
            self.logState(YES);
        } else {
            self.logState(NO);
            [JZTost showTost:responseObj];
        }
    }];
}
- (void)changeValue {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    self.timeTF.text = [formatter stringFromDate:date];
    JZLog(@"%@",[formatter stringFromDate:date]);
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.inputView = self.addPickeView;
    textField.inputView = [[UIView alloc] init];
    [self.view addSubview:self.nDatePicker];
//    [self.view addSubview:self.onePicker];
}
#pragma mark onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    self.timeTF.text = date;
     [self.timeTF resignFirstResponder];
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.timeTF resignFirstResponder];
    [self.onePicker removeFromSuperview];
}
#pragma mark AddressPickerDelegate
- (void)addressPickerWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    self.timeTF.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    [self.timeTF resignFirstResponder];
}
- (void)addressPickerCancleAction{
    [self.timeTF resignFirstResponder];
    [self.addPickeView removeFromSuperview];
}
#pragma mark datePickerDelegate
- (void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView{
     [self.timeTF resignFirstResponder];
    JZLog(@"%@",date);
    [pickerView removeFromSuperview];
}
- (void)datePicerCancel:(JZDatePickeView *)pickerView{
     [self.timeTF resignFirstResponder];
    [pickerView removeFromSuperview];
}
#pragma mark 懒加载
-(UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        self.datePicker = [[UIDatePicker alloc]init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minimumDate = [NSDate new];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"ZH"];
    }
    return _datePicker;
}
-(JZPickeView *)addPickeView {
    if (_addPickeView == nil) {
        self.addPickeView = [[JZPickeView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _addPickeView.delegate = self;
        _addPickeView.font = [UIFont systemFontOfSize:18];
    }
    return _addPickeView;
}
-(JZOnePickerView *)onePicker {
    if (_onePicker == nil) {
        self.onePicker = [[JZOnePickerView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _onePicker.delegate = self;
        _onePicker.dataArray = @[@"张三",@"李四",@"王五"];
        _onePicker.font = [UIFont systemFontOfSize:17];
    }
    return _onePicker;
}
-(JZDatePickeView *)nDatePicker {
    if (_nDatePicker == nil) {
        self.nDatePicker = [[JZDatePickeView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _nDatePicker.delegate = self;
    }
    return _nDatePicker;
}
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
