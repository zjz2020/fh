//
//  JZAlartDetailVC.m
//  JZProject
//
//  Created by zjz on 2019/7/20.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZAlartDetailVC.h"
#import "JZServiceItemModel.h"
#import "JzOnePickerView.h"
#import "JZHostMode.h"
#import "UIBarButtonItem+JZBarButtonItem.h"
@interface JZAlartDetailVC ()<UITextViewDelegate,UITextFieldDelegate,onePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UITextField *ipTextF;
@property (weak, nonatomic) IBOutlet UITextView *topTextView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property(nonatomic,strong)NSArray *faultTypeList;
@property(nonatomic,strong)NSArray *faultTypeModelList;
@property(nonatomic,strong)JZOnePickerView *onePicke;
@property(nonatomic,strong)NSMutableDictionary *parameterDic;
@property(nonatomic,strong)NSMutableArray *hostArray;
@property(nonatomic,strong)UITextField *activeTF;
@property (weak, nonatomic) IBOutlet UITextField *errorTextF;

@end

@implementation JZAlartDetailVC
+ (JZAlartDetailVC *)shareAlartDetail {
    return [[JZAlartDetailVC alloc] initWithNibName:@"JZAlartDetailVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.faultTypeList = @[];
    self.errorTextF.hidden = YES;
    self.parameterDic = [NSMutableDictionary new];
    // Do any additional setup after loading the view from its nib.
}
- (void)creactUI {
    self.topTextView.returnKeyType = UIReturnKeyDone;
    self.topTextView.delegate = self;
    self.title = self.isCreat ? @"故障申报": @"事件警告";
    self.navigationController.navigationBar.barTintColor = TopColor;
     self.ipTextF.delegate = self;
    [self addBarButton];
//    [self makeData];
    [self getHostList];
}
- (void)makeData {
    self.textFiled.delegate = self;
   
    if (self.isCreat) {
        self.ipTextF.placeholder = @"请选择故障设备";
        self.ipTextF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self getFaultTypes];
    } else {
    self.textFiled.text = self.eventModel.eventhost;
    self.ipTextF.text = self.eventModel.eventip;
    self.topTextView.text = self.eventModel.eventdetail;
    }
}
- (void)getHostList{
    //获取主机
    __block typeof(self) weakSelf = self;
    [self.netHelp zbGetHostNetWithParameter:@{} urlStr:[JZNetWorkHelp shareNetWork].zbip backData:^(BOOL netOk, id  _Nonnull responseObj) {
        weakSelf.hostArray = [NSMutableArray new];
        NSArray *array = responseObj[@"result"];
        for (NSDictionary *dic in array) {
//            [weakSelf.hostArray addObject:[JZHostMode shareHostModeWithData:dic]];
            [weakSelf.hostArray addObject:dic[@"host"]];
        }
    }];
}
- (void)getFaultTypes {
    __weak typeof(self) weakSelf = self;
    [self.baseNetMode faultTypeList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            weakSelf.faultTypeModelList = responseObj;
            NSMutableArray *mArray = [NSMutableArray new];
            for (JZServiceItemModel *model in responseObj) {
                [mArray addObject:model.serviceName];
            }
            self.faultTypeList = mArray;
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
#pragma mark  onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    if ([self.activeTF isEqual:self.textFiled]) {
        JZServiceItemModel *model = self.faultTypeModelList[index];
        self.parameterDic[@"faulttype"] = [NSString stringWithFormat:@"%@",model.itemID];
        self.textFiled.text = model.serviceName;
    } else if ([self.activeTF isEqual:self.ipTextF]) {
        self.ipTextF.text = self.hostArray[index];
         self.parameterDic[@"equipment"] = [NSString stringWithFormat:@"%@",self.hostArray[index]];
    }
     [self.onePicke removeFromSuperview];
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.textFiled resignFirstResponder];
    [self.onePicke removeFromSuperview];
}
- (void)addBarButton{
    UIBarButtonItem *barBtn = [UIBarButtonItem creatBtnWithTitle:@"返回" target:self action:@selector(backAction)];
    [barBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = barBtn;
}
- (void)backAction {
      [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commitBtnAction:(UIButton *)sender {
//    if (![self.parameterDic.allKeys containsObject:@"faulttype"]) {
//        [JZTost showTost:@"请选择故障类型"];
//        return;
//    }
     self.parameterDic[@"projectId"] = self.projectId;
    self.parameterDic[@"faultdesc"] = self.topTextView.text;
    self.parameterDic[@"declarer"] = [JZNetWorkHelp shareNetWork].userId;
    [self.faultNetModel faultCreateWithDic:self.parameterDic backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_alart object:nil];
             [self.navigationController popViewControllerAnimated:YES];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.isCreat ? YES : NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeTF = textField;
    textField.inputView = [[UIView alloc] init];
    if ([textField isEqual:self.textFiled]) {
        if (self.faultTypeList.count == 0) {
            [JZTost showTost:@"正在加载数据.."];
            [self getFaultTypes];
        } else {
            self.onePicke.dataArray = self.faultTypeList;
             [[UIApplication sharedApplication].keyWindow addSubview:self.onePicke];
        }
       
    } else if ([textField isEqual:self.ipTextF]) {//设备选择
        if (self.hostArray) {
            self.onePicke.dataArray = self.hostArray;
            [[UIApplication sharedApplication].keyWindow addSubview:self.onePicke];
        } else {
             [JZTost showTost:@"正在加载数据.."];
            [self.ipTextF endEditing:YES];
            [self getHostList];
        }
    }
}
#pragma mark UITextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
     return self.isCreat ? YES : NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
        
    }
    return YES;
}
-(JZOnePickerView *)onePicke {
    if (_onePicke == nil) {
        self.onePicke = [[JZOnePickerView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _onePicke.delegate = self;
        _onePicke.font = [UIFont systemFontOfSize:17];
    }
    return _onePicke;
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
