//
//  JZEngineerRegistVC.m
//  JZProject
//
//  Created by zjz on 2019/6/30.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZEngineerRegistVC.h"
#import "JZBaseNetModel.h"
#import "JZPickeView.h"
#import "JzOnePickerView.h"
#import "JZRegisterNetModel.h"
#import "JZRegisterModel.h"
#import "JZServiceItemModel.h"
@interface JZEngineerRegistVC ()<UIScrollViewDelegate,AddressPickerDelegate,onePickerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *lowView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
///联系人
@property (weak, nonatomic) IBOutlet UITextField *contact;
///联系方式
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTF;
///毕业院校
@property (weak, nonatomic) IBOutlet UITextField *universityTF;
///所在地
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
///工作经验
@property (weak, nonatomic) IBOutlet UITextField *workExperienceTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
///个人技能
@property (weak, nonatomic) IBOutlet UITextField *personSkillTF;
///意向
@property (weak, nonatomic) IBOutlet UITextField *intentionTF;
@property (weak, nonatomic) IBOutlet UITextField *certificateTF;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

///一些选项 view
///地址选择view
@property(nonatomic,strong)JZPickeView *addressPicke;
@property(nonatomic,strong)JZOnePickerView *onePicke;
@property(nonatomic,strong)NSArray *workYears;
@property(nonatomic,strong)NSArray *sexArray;
@property(nonatomic,strong)NSArray *skillArray;
@property(nonatomic,strong)NSArray *intentionArray;
@property(nonatomic,strong)NSArray *skillModelArray;
@property(nonatomic,strong)NSArray *intentionModelArray;
//当前活跃的textFile
@property(nonatomic,strong)UITextField *activityField;
@property(nonatomic,strong)JZRegisterModel *dataModel;
@property(nonatomic,strong)JZRegisterNetModel *registNetModel;

@end

@implementation JZEngineerRegistVC
+ (JZEngineerRegistVC *)shareEngineer{
    return [[JZEngineerRegistVC alloc] initWithNibName:@"JZEngineerRegistVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(Width, 900);
    self.scrollView.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.skillArray = [NSMutableArray new];
    self.intentionArray = [NSMutableArray new];
    [self makeTextInputView];
    [self makeDatas];
    // Do any additional setup after loading the view from its nib.
}
- (void)creactUI {
    [self makeBtnCornerRadius:self.checkBtn];
    [self makeBtnCornerRadius:self.codeBtn];
    [self makeBtnCornerRadius:self.upBtn];
    [self makeBtnCornerRadius:self.cancelBtn];
    [self makeBtnCornerRadius:self.remarkTextView];
}
- (void)makeBtnCornerRadius:(UIView *)btn {
    btn.layer.masksToBounds = true;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = GrayColor2.CGColor;
}
- (void)makeDatas{
    self.sexArray = @[@"男",@"女"];
    self.skillModelArray = @[];
    self.intentionModelArray = @[];
    __weak typeof(self) weakSelf = self;
    [[JZBaseNetModel shareBaseNetModel] personalskillsList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            weakSelf.skillModelArray = responseObj;
            NSMutableArray *maray = [NSMutableArray new];
            for (JZServiceItemModel *model in responseObj) {
                [maray addObject:model.serviceName];
            }
            weakSelf.skillArray = maray;
        } else {
            [JZTost showTost:responseObj];
        }
    }];
    [[JZBaseNetModel shareBaseNetModel] personalintentionList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *maray = [NSMutableArray new];
            weakSelf.intentionModelArray = responseObj;
            for (JZServiceItemModel *model in responseObj) {
                [maray addObject:model.serviceName];
            }
            weakSelf.intentionArray = maray;
        } else {
            [JZTost showTost:responseObj];
        }
        }];
}
- (void)makeTextInputView{
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.contactPhoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.workExperienceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.addressTF.delegate = self;
    self.sexTF.delegate = self;
    self.personSkillTF.delegate = self;
    self.intentionTF.delegate = self;
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (UIView *obj in self.scrollView.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id tf in obj.subviews) {
                if ([tf isKindOfClass:[UITextField class]]  || [tf isKindOfClass:[UITextView class]]) {
                    [tf endEditing:YES];
                }
            }
        }
    }
}
#pragma mark btnAction
//检查手机是否注册
- (IBAction)checkPhoneBtnAction:(UIButton *)sender {
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
//验证码
- (IBAction)codeBtnAction:(id)sender {
    [self.registNetModel sendSMSWithPhone:self.phoneTF.text backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [JZTost showTost:@"获取验证码成功"];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
//提交
- (IBAction)sureBtnAction:(id)sender {
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
  
    self.dataModel.roleId = @"5";
    self.dataModel.userPhone = self.phoneTF.text;
    self.dataModel.verifyCode = self.codeTF.text;
    self.dataModel.passWord   = self.passwordTF.text;
    self.dataModel.contacts   = self.contact.text;
    self.dataModel.userName = self.contact.text;
    self.dataModel.contactstel = self.contactPhoneTF.text;
    self.dataModel.university = self.universityTF.text;
    self.dataModel.experience = self.workExperienceTF.text;
    self.dataModel.sex = self.sexTF.text;
    self.dataModel.certificate = self.certificateTF.text;
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
//取消
- (IBAction)cancalAction:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UITextInputDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.inputView = [[UIView alloc] init];
    self.activityField = textField;
    if ([textField isEqual:self.addressTF]) {
        [self.view addSubview:self.addressPicke];
    }else if ([textField isEqual:self.sexTF]){
         self.onePicke.dataArray = self.sexArray;
         [self.view addSubview:self.onePicke];
    }else if ([textField isEqual:self.personSkillTF] && self.skillArray.count > 0){
         self.onePicke.dataArray = self.skillArray;
         [self.view addSubview:self.onePicke];
    }else if ([textField isEqual:self.intentionTF] && self.intentionArray.count > 0){
         self.onePicke.dataArray = self.intentionArray;
         [self.view addSubview:self.onePicke];
    }
}
#pragma mark AddressPickerDelegate
- (void)addressPickerWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.dataModel.provice = province;
    self.dataModel.city = city;
    self.dataModel.area = area;
    [self.addressTF resignFirstResponder];
     [self.addressPicke removeFromSuperview];
}
/** 取消代理方法*/
- (void)addressPickerCancleAction{
    [self.addressTF resignFirstResponder];
    [self.addressPicke removeFromSuperview];
}

#pragma mark  onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    NSLog(@"%@",date);
    if ([self.activityField isEqual:self.personSkillTF]) {//个人技能
        JZServiceItemModel *model = self.skillModelArray[index];
        self.dataModel.skill = model.itemID;
        self.personSkillTF.text = model.serviceName;
    } else if ([self.activityField isEqual:self.intentionTF]) {//个人意向
        JZServiceItemModel *model = self.intentionModelArray[index];
        self.dataModel.intention = model.itemID;
        self.intentionTF.text = model.serviceName;
    } else {
         self.activityField.text = date;
    }
    [self.activityField resignFirstResponder];
    [self.onePicke removeFromSuperview];
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.activityField resignFirstResponder];
    [self.onePicke removeFromSuperview];
}
#pragma mark 懒加载
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
-(JZRegisterModel *)dataModel {
    if (_dataModel == nil) {
        self.dataModel = [[JZRegisterModel alloc]init];
    }
    return _dataModel;
}
-(JZRegisterNetModel *)registNetModel {
    if (_registNetModel == nil) {
        self.registNetModel = [JZRegisterNetModel shareRegistNetModel];
    }
    return _registNetModel;
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
