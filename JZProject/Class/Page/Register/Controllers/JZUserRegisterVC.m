//
//  JZUserRegisterVC.m
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZUserRegisterVC.h"
#import "JZPickeView.h"
#import "JzOnePickerView.h"
#import "JZDatePickeView.h"
#import "JZRegisterNetModel.h"
#import "JZBaseNetModel.h"
#import "JZRegisterModel.h"
#import "JZServiceItemModel.h"
@interface JZUserRegisterVC ()<UIScrollViewDelegate,onePickerDelegate,AddressPickerDelegate,UITextFieldDelegate,datePickerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *lowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adsViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
///单位名称
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *address1TF;
@property (weak, nonatomic) IBOutlet UITextField *address2TF;
///服务需求
@property (weak, nonatomic) IBOutlet UITextField *serviceTF;
///希望支持时间
@property (weak, nonatomic) IBOutlet UITextField *sureSupportTime;
///联系人
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
///联系人手机号
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTF;
///希望支持地点
@property (weak, nonatomic) IBOutlet UITextField *sureSupportAddress;
//补充说明
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;


@property(nonatomic,strong)JZPickeView *addressPicke;
@property(nonatomic,strong)JZOnePickerView *onePicke;
@property(nonatomic,strong)JZDatePickeView *datePicker;
//当前活跃的textFile
@property(nonatomic,strong)UITextField *activityField;
//当前活跃的textFile 地址
@property(nonatomic,strong)UITextField *activityAddressField;
@property(nonatomic,strong)JZRegisterNetModel *registNetModel;
@property(nonatomic,strong)JZRegisterModel *dataModel;
///服务数组
@property(nonatomic,strong)NSArray *serviceArray;
@property(nonatomic,strong)NSMutableArray *serviceTitleArray;
@end

@implementation JZUserRegisterVC
+ (JZUserRegisterVC *)shareRegister{
    return [[JZUserRegisterVC alloc] initWithNibName:@"JZUserRegisterVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(Width, 980);}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeDatas];
    [self makeTextInputView];
    // Do any additional setup after loading the view from its nib.
}
- (void)makeUI{
    self.scrollView.delegate = self;
    [self makeBtnCornerRadius:self.loginBtn];
    [self makeBtnCornerRadius:self.cancelBtn];
    [self makeBtnCornerRadius:self.checkBtn];
    [self makeBtnCornerRadius:self.codeBtn];
    [self makeBtnCornerRadius:self.remarkTextView];
}
- (void)makeBtnCornerRadius:(UIView *)btn {
    btn.layer.masksToBounds = true;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = GrayColor2.CGColor;
}
- (void)makeDatas{
    self.registNetModel = [JZRegisterNetModel shareRegistNetModel];
}
- (void)makeTextInputView{
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.contactPhoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.address1TF.delegate = self;
    self.serviceTF.delegate = self;
    self.sureSupportTime.delegate = self;
    self.sureSupportAddress.delegate = self;
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (UIView *obj in self.lowView.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id tf in obj.subviews) {
                if ([tf isKindOfClass:[UITextField class]]  || [tf isKindOfClass:[UITextView class]]) {
                    [tf endEditing:YES];
                }
            }
        }
    }
}
-(void)dateChange:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    self.sureSupportTime.text = dateStr;
    [self.sureSupportTime resignFirstResponder];
}
#pragma mark btnAction
//检查手机号是否注册
- (IBAction)checkActon:(UIButton *)sender {
    BOOL isPhone = [super isIphone:self.phoneTF.text];
    if (!isPhone) {
        [JZTost showTost:@"请输入正确的手机号"];
        return;
    }
    [self.registNetModel checkUserRegister:self.phoneTF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [JZTost showTost:@"该手机号未注册"];
        }else{
            [JZTost showTost:responseObj];
        }
    }];
}
///获取验证码
- (IBAction)codeAction:(UIButton *)sender {//发送验证码
    BOOL isPhone = [super isIphone:self.phoneTF.text];
    if (!isPhone) {
        [JZTost showTost:@"请输入正确的手机号"];
        return;
    }
    [self.registNetModel sendSMSWithPhone:self.phoneTF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [JZTost showTost:@"验证码发送成功"];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
///提交操作
- (IBAction)sureBtnAction:(UIButton *)sender {
    BOOL isPhone = [super isIphone:self.phoneTF.text];
    if (!isPhone) {
        [JZTost showTost:@"请输入正确的手机号"];
//        return;
    }
    if (![super isString:self.codeTF.text]) {
        [JZTost showTost:@"请输入验证码"];
        return;
    }
    if (![super isString:self.passwordTF.text]) {
        [JZTost showTost:@"请输入密码"];
        return;
    }
    if (![super isString:self.serviceTF.text]) {
        [JZTost showTost:@"请选择服务需求"];
        return;
    }
    if (![super isString:self.codeTF.text]) {
        [JZTost showTost:@"请输入验证码"];
        return;
    }
    self.dataModel.roleId = @"1";
    self.dataModel.userPhone = self.phoneTF.text;
    self.dataModel.verifyCode = self.codeTF.text;
    self.dataModel.passWord   = self.passwordTF.text;
    self.dataModel.companyname = self.companyTF.text;
    self.dataModel.userName = self.contactTF.text;
    self.dataModel.address = self.address2TF.text;
    self.dataModel.contacts   = self.contactTF.text;
    self.dataModel.contactstel = self.contactPhoneTF.text;
    self.dataModel.expectsuppor = @"我需要技术支持";
    self.dataModel.remark = self.remarkTextView.text;
    NSDictionary *parameter = [JZRegisterModel changeDicWithModel:self.dataModel];
    [self.registNetModel registerWithParamts:parameter backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [JZTost showTost:@"注册成功"];
           [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [JZTost showTost:responseObj];
        }
    }];
    
}
//取消按钮
- (IBAction)cancalBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UITextInputDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.inputView = [[UIView alloc] init];
    self.activityField = textField;
    if ([textField isEqual:self.address1TF]) {//地址
        self.activityAddressField = self.address1TF;
        [self.view addSubview:self.addressPicke];
    } else if ([textField isEqual:self.sureSupportAddress]){
        self.activityAddressField = self.sureSupportAddress;
        [self.view addSubview:self.addressPicke];
    }else if ([textField isEqual:self.serviceTF]){
        if (self.serviceTitleArray) {
            self.onePicke.dataArray = self.serviceTitleArray;
            [self.view addSubview:self.onePicke];
        } else {
        JZBaseNetModel *baseModel = [JZBaseNetModel shareBaseNetModel];
            __weak typeof (self)weakSelf = self;
        [baseModel serviceItemList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                weakSelf.serviceArray = responseObj;
                weakSelf.serviceTitleArray = [NSMutableArray new];
                for (JZServiceItemModel *mode in responseObj) {
                    [weakSelf.serviceTitleArray addObject:mode.serviceName];
                }
                self.onePicke.dataArray = weakSelf.serviceTitleArray;
                [self.view addSubview:self.onePicke];
            } else{
                [JZTost showTost:responseObj];
            }
        }];
        }
    }else if ([textField isEqual:self.sureSupportTime]){
        [self.view addSubview:self.datePicker];
    }
}
#pragma mark datePickerDelegate
- (void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView{
    self.sureSupportTime.text = date;
    [pickerView removeFromSuperview];
    [self.sureSupportTime resignFirstResponder];
}

- (void)datePicerCancel:(JZDatePickeView *)pickerView{
    [pickerView removeFromSuperview];
    [self.sureSupportTime resignFirstResponder];
}
#pragma mark AddressPickerDelegate
- (void)addressPickerWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    self.activityAddressField.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    if ([self.activityAddressField isEqual:self.sureSupportAddress]) {
        self.dataModel.expectsuppor = self.activityAddressField.text;
    } else {
        self.dataModel.provice = province;
        self.dataModel.city = city;
        self.dataModel.area = area;
    }
    [self.activityAddressField resignFirstResponder];
    [self.addressPicke removeFromSuperview];
}
/** 取消代理方法*/
- (void)addressPickerCancleAction{
    [self.activityAddressField resignFirstResponder];
    [self.addressPicke removeFromSuperview];
}

#pragma mark  onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    NSLog(@"%@",date);
    self.serviceTF.text = date;
    JZServiceItemModel *item = self.serviceArray[index];
    self.dataModel.serviceid = item.itemID;
    [self.serviceTF resignFirstResponder];
    [self.onePicke removeFromSuperview];
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.serviceTF resignFirstResponder];
    [self.onePicke removeFromSuperview];
}

-(JZPickeView *)addressPicke {
    if (_addressPicke == nil) {
        self.addressPicke = [[JZPickeView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _addressPicke.delegate = self;
        _addressPicke.font = [UIFont systemFontOfSize:18];
    }
    return _addressPicke;
}

-(JZOnePickerView *)onePicke {
    if (_onePicke == nil) {
        self.onePicke = [[JZOnePickerView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _onePicke.delegate = self;
        _onePicke.font = [UIFont systemFontOfSize:17];
    }
    return _onePicke;
}
-(JZDatePickeView *)datePicker {
    if (_datePicker == nil) {
        self.datePicker = [[JZDatePickeView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}
-(JZRegisterModel *)dataModel {
    if (_dataModel == nil) {
        self.dataModel = [[JZRegisterModel alloc]init];
    }
    return _dataModel;
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
