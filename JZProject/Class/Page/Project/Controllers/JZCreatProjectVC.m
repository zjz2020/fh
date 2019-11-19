//
//  JZCreatProjectVC.m
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZCreatProjectVC.h"
#import "UIBarButtonItem+JZBarButtonItem.h"
#import "JZBaseNetModel.h"
#import "JZPickeView.h"
#import "JzOnePickerView.h"
#import "JZDatePickeView.h"
#import "JZServiceItemModel.h"
#import "JZProjectNetModel.h"
#import "ZYQAssetPickerController.h"
#import <SDWebImage/SDWebImage.h>
@interface JZCreatProjectVC ()<UITextFieldDelegate,onePickerDelegate,AddressPickerDelegate,datePickerDelegate,UIScrollViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *address1TF;
@property (weak, nonatomic) IBOutlet UITextField *address2TF;
///服务内容
@property (weak, nonatomic) IBOutlet UITextField *serviceContentTF;
///服务时间
@property (weak, nonatomic) IBOutlet UITextField *serviceTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *checkTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *serviceStartTF;
@property (weak, nonatomic) IBOutlet UITextField *serviceEndTF;
@property (weak, nonatomic) IBOutlet UIView *Person1View;
@property (weak, nonatomic) IBOutlet UIView *person2View;
@property (weak, nonatomic) IBOutlet UIView *person3View;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;
@property (weak, nonatomic) IBOutlet UIButton *projectBtn;
@property (weak, nonatomic) IBOutlet UIButton *searverBtn;
@property (weak, nonatomic) IBOutlet UIButton *aBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView3;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property(nonatomic,strong)JZPickeView *addressPicke;
@property(nonatomic,strong)JZOnePickerView *onePicke;
@property(nonatomic,strong)JZDatePickeView *datePicker;
@property(nonatomic,strong)UITextField *activityTF;
@property(nonatomic,strong)JZProjectModel *projectModel;
@property(nonatomic,assign)BOOL startTime;//开始  结束时间
@property(nonatomic,assign)NSInteger pickeType;//服务选择类型  1.服务内容  2.服务有效时间  3.固定巡检时间  4.项目负责人  5.维护人  6  甲方负责人
///数据处理
@property(nonatomic,strong)JZBaseNetModel *baseNet;
///服务内容
@property(nonatomic,strong)NSArray *serviceArray;
@property(nonatomic,strong)NSArray *serviceShowArray;
///服务有效时间
@property(nonatomic,strong)NSArray *serviceTimeArray;
@property(nonatomic,strong)NSArray *serviceTimeShowArray;
///固定巡检时间
@property(nonatomic,strong)NSArray *lookArray;
@property(nonatomic,strong)NSArray *lookShowArray;
///项目负责人信息
@property(nonatomic,strong)NSArray *projectManInfo;
@property(nonatomic,strong)NSArray *projectManShowInfo;
@property(nonatomic,strong)NSMutableArray *projectManIDs;
///维护人员信息
@property(nonatomic,strong)NSArray *maintainPersonsInfo;
@property(nonatomic,strong)NSArray *maintainPersonsShowInfo;
@property(nonatomic,strong)NSMutableArray *maintainPersonsIDS;
///甲方负责人信息
@property(nonatomic,strong)NSArray *aPersonsInfo;
@property(nonatomic,strong)NSArray *aPersonsShowInfo;
@property(nonatomic,strong)NSMutableArray *aPersonsIDs;
///服务有效时间 月
@property(nonatomic,copy)NSString *serviceTime;
@property(nonatomic,assign)BOOL markEdit;
@property(nonatomic,strong)UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property(nonatomic,strong)UIImage *selectImage;
@property(nonatomic,copy)NSString *imageUrlStr;
@end

@implementation JZCreatProjectVC
+ (JZCreatProjectVC *)shareProject{
    return [[JZCreatProjectVC alloc] initWithNibName:@"JZCreatProjectVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.projectBtn.hidden = YES;
    self.scrollView.frame = CGRectMake(0, 0, Width, Height);
    [self.scrollView setContentSize:CGSizeMake(Width, 940)];
    self.scrollView.delegate = self;
     self.contentViewHeight.constant = 940;
    self.serviceEndTF.enabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目创建";
    if (self.isEdit) {
        self.title = @"修改项目";
    }
    self.searchBtn.hidden = YES;
    self.projectModel = [JZProjectModel shareModel];
    self.projectModel.headid = [JZNetWorkHelp shareNetWork].userId;
    self.projectModel.headname = [JZNetWorkHelp shareNetWork].userName;
    self.markEdit = NO;
    if (self.isEdit) {
        self.nameTextF.userInteractionEnabled = NO;
        self.serviceStartTF.userInteractionEnabled = NO;
        __weak typeof(self) weakSelf = self;
        [self.projectNetModel queryProjectInfoWithProjectId:self.projectId backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                weakSelf.projectModel = responseObj;
                [weakSelf makeFirstEditView];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    }
    self.navigationController.navigationBar.barTintColor = TopColor;
    // Do any additional setup after loading the view from its nib.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)creactUI{
    self.scrollView.frame = CGRectMake(0, 0, Width, Height);
    [self.scrollView setContentSize:CGSizeMake(Width, 940)];
    self.contenView.width = Width;
    [self makeButtonItem];
    [self makeDatas];
    [self makeTextInputView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 89, self.scrollView1.height)];
    label.text = [JZNetWorkHelp shareNetWork].userName;
    [self.scrollView1 addSubview:label];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = GrayColor2.CGColor;
    self.textView.layer.borderWidth = 1;
    [self makeBtnLayerWithBtn:self.projectBtn];
     [self makeBtnLayerWithBtn:self.aBtn];
     [self makeBtnLayerWithBtn:self.searverBtn];
}
- (void)makeBtnLayerWithBtn:(UIButton *)btn{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = GrayColor2.CGColor;
}
- (void)makeDatas{
    self.projectManIDs = [NSMutableArray new];
    self.maintainPersonsIDS = [NSMutableArray new];
    self.aPersonsIDs = [NSMutableArray new];
    __block typeof(self) weakSelf = self;
    [self.baseNet serviceItemList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        weakSelf.serviceArray = responseObj;
        NSMutableArray *service = [NSMutableArray new];
        for (JZServiceItemModel *model in responseObj) {
            [service addObject:model.serviceName];
        }
        weakSelf.serviceShowArray = service;
    }];
    [self.baseNet serviceTimeList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        weakSelf.serviceTimeArray = responseObj;
        NSMutableArray *service = [NSMutableArray new];
        for (JZServiceTimeModel *model in responseObj) {
            [service addObject:model.timedesc];
        }
        weakSelf.serviceTimeShowArray = service;
    }];
    [self.baseNet looptaskList:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
        weakSelf.lookArray = responseObj;
        NSMutableArray *service = [NSMutableArray new];
        for (JZLooptaskItemModel *model in responseObj) {
            [service addObject:model.taskname];
        }
        weakSelf.lookShowArray = service;
    }];
}
- (void)makeFirstEditView {
    if (self.projectModel.fileurl) {
        self.searchBtn.hidden = NO;
    }
    self.nameTextF.text = self.projectModel.orgname;
    self.address1TF.text = [NSString stringWithFormat:@"%@%@%@",self.projectModel.province, self.projectModel.city, self.projectModel.county];
    self.address2TF.text = self.projectModel.address;
    self.serviceContentTF.text = self.projectModel.serviceditemetail;
    self.checkTimeTF.text = self.projectModel.taskname;
    self.serviceTimeTF.text = self.projectModel.effectiveDec;
    self.textView.text = self.projectModel.projectmemo;
    if (self.projectModel.servicestarttime) {//w服务开始时间
        self.serviceStartTF.text = [self changeStringToTime:self.projectModel.servicestarttime];
        self.projectModel.servicestarttime = [self changeStringToTime:self.projectModel.servicestarttime];
    }
    if (self.projectModel.serviceendtime) {//结束时间
        self.serviceEndTF.text = [self changeStringToTime:self.projectModel.serviceendtime];
        self.projectModel.serviceendtime = [self changeStringToTime:self.projectModel.serviceendtime];
    }
    
    self.maintainPersonsIDS = [NSMutableArray arrayWithArray:self.projectModel.servicePerson];
    self.aPersonsIDs = [NSMutableArray arrayWithArray:self.projectModel.partyasPerson];
    
    
    [self setPersonViewsWithView:self.scrollView2 dataArray:[self backNameWithDataArray:self.maintainPersonsIDS ids:self.maintainPersonsIDS isFirst:YES] personType:10];
    [self setPersonViewsWithView:self.scrollView3 dataArray:[self backNameWithDataArray:self.aPersonsIDs ids:self.aPersonsIDs isFirst:YES] personType:20];
}
- (void)makeTextInputView{
    self.address1TF.delegate = self;
    self.serviceContentTF.delegate = self;
    self.serviceStartTF.delegate = self;
    self.serviceEndTF.delegate = self;
    self.serviceTimeTF.delegate = self;
    self.checkTimeTF.delegate = self;
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
}
- (void)makeButtonItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBtnWithTitle:@"取消" target:self action:@selector(clickeLeftItem)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem creatBtnWithTitle:@"完成" target:self action:@selector(clickRightItem)];
    
}
- (void)setPersonViewsWithView:(UIScrollView *)scrollView dataArray:(NSArray *)dataArray personType:(NSInteger)type{//0 10 20
    CGFloat btnWidth = self.scrollView1.width/2;
//    scrollView.contentSize = CGSizeMake(btnWidth *dataArray.count, scrollView.height);
    for (UIButton *btn in scrollView.subviews) {
        [btn removeFromSuperview];
    }
    if (dataArray.count >= 3) {
        scrollView.contentSize = CGSizeMake(btnWidth *dataArray.count, scrollView.height);
        [scrollView setContentOffset:CGPointMake(btnWidth *(dataArray.count -2), 0)];
    } else {
         scrollView.contentSize = CGSizeMake(scrollView.width, scrollView.height);
    }
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        UIView *btn = [self creatBtnWithTag:i + type frame:CGRectMake(i *btnWidth, 0, btnWidth, 40) title:dataArray[i]];
        btn.centerY = scrollView.centerY;
        [scrollView addSubview:btn];
    }
}
- (void)keyboardWasShown:(NSNotification *)notification {
    if (!self.markEdit) {
        return;
    }
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = frame.size.height;
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + height)];
}
- (void)keyboardWillBeHiden:(NSNotification *)notification {
    if (!self.markEdit) {
        return;
    }
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = frame.size.height;
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y - height)];
}
- (UIView *)creatBtnWithTag:(NSInteger)tag frame:(CGRect)fram title:(NSString *)title{
    UIView *view = [[UIView alloc] initWithFrame:fram];
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = GrayColor2;
    label.font = [UIFont systemFontOfSize:15];
    [label sizeToFit];
    label.centerY = view.centerY;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:GrayColor2 forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [btn setImagePosition:LXMImagePositionRight spacing:5];
    btn.tag = tag;
    btn.frame = CGRectMake(label.x + label.width, 0, btn.width, fram.size.height);
     [btn sizeToFit];
     btn.centerY = view.centerY;
    [btn addTarget:self action:@selector(delectBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:label];
    [view addSubview:btn];
    return view;
}
- (void)delectBtn:(UIButton *)btn{
    [btn removeFromSuperview];
    if (btn.tag < 10) {
//        [self.projectManIDs removeObjectAtIndex:btn.tag];
//        [self removeAllSubViews:self.scrollView1];
//        [self setPersonViewsWithView:self.scrollView1 dataArray:[self backNameWithDataArray:self.projectManInfo ids:self.projectManIDs] personType:0];
    } else if (btn.tag < 20){
        [self.maintainPersonsIDS removeObjectAtIndex:btn.tag-10];
        [self removeAllSubViews:self.scrollView2];
        [self setPersonViewsWithView:self.scrollView2 dataArray:[self backNameWithDataArray:self.maintainPersonsInfo ids:self.maintainPersonsIDS isFirst:NO] personType:10];
    } else{
        [self.aPersonsIDs removeObjectAtIndex:btn.tag-20];
        [self removeAllSubViews:self.scrollView3];
        [self setPersonViewsWithView:self.scrollView3 dataArray:[self backNameWithDataArray:self.aPersonsInfo ids:self.aPersonsIDs isFirst:NO] personType:20];
    }
}
- (void)removeAllSubViews:(UIView *)view {
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}
#pragma mark btnAction
- (void)clickeLeftItem{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)seePictureBtnAction:(UIButton *)sender {
    if (self.isEdit) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.projectModel.fileurl] placeholderImage:[UIImage imageNamed:@"001"]];
    } else {
        self.imageView.image = self.selectImage;
    }
    self.imageView.hidden = NO;
}

- (IBAction)upPhotoAction:(UIButton *)sender {
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 1;
    picker.assetsFilter = ZYQAssetsFilterAllAssets;
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([(ZYQAsset*)evaluatedObject mediaType]==ZYQAssetMediaTypeVideo) {
            NSTimeInterval duration = [(ZYQAsset*)evaluatedObject duration];
            return duration >= 5;
        } else {
            return YES;
        }
        
        
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];

}
- (void)clickRightItem{
    self.projectModel.projectname = self.nameTextF.text;
    self.projectModel.orgname = self.nameTextF.text;
    self.projectModel.address = self.address2TF.text;
    self.projectModel.projectmemo = self.textView.text;
    if (self.imageUrlStr) {
         self.projectModel.fileurl = self.imageUrlStr;
    }
//    if (self.projectManIDs.count == 0) {
//        [JZTost showTost:@"请选择项目负责人"];
//        return;
//    }
    if (self.maintainPersonsIDS.count == 0) {
        [JZTost showTost:@"请选择维护人员"];
        return;
    }
    if (self.aPersonsIDs.count == 0) {
        [JZTost showTost:@"请选择甲方负责人"];
        return;
    }
//    NSString *projectIdS = [self backIdStringWithArray:self.projectManIDs];
//    NSString *maintainIDS = [self backIdStringWithArray:self.maintainPersonsIDS];
//    NSString *aaIds = [self backIdStringWithArray:self.aPersonsIDs];
    self.projectModel.servicePerson = self.maintainPersonsIDS;//维护人员
    self.projectModel.partyasPerson = self.aPersonsIDs;//甲方负责人
    [self.projectNetModel createProjectWithModel:self.projectModel isEdit:self.isEdit backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            if (self.isEdit) {
                 [JZTost showTost:@"编辑成功"];
            } else {
                 [JZTost showTost:@"创建成功"];
            }
            [self clickeLeftItem];
        } else {
            [JZTost showTost:responseObj];
        }
     }];
    JZLog(@"完成");
}
- (NSString *)backIdStringWithArray:(NSArray *)ids{
    NSMutableString *idString = [[NSMutableString alloc] init];
    for (NSString *ts in ids) {
        [idString appendString:ts];
    }
    return idString;
}
//显示选择人信息
- (void)showSelectManInfo:(NSArray *)showInfo type:(NSInteger)type{
    if (showInfo.count == 0) {
        [JZTost showTost:@"暂时没有可选人员"];
        return;
    }
    self.pickeType = type;
    self.onePicke.dataArray = showInfo;
    [self.view addSubview:self.onePicke];
}
//过滤已经选择的人
- (NSArray *)backUnselectManArrayWithArray:(NSArray *)manArray selectIds:(NSArray *)selectIds type:(NSInteger)type{
    NSMutableArray *marray = [NSMutableArray new];
    NSMutableArray *dataArray = [NSMutableArray new];
    for (JZManModel *man in manArray) {
        if (![selectIds containsObject:man]) {
            [marray addObject:man.userName];
            [dataArray addObject:man];
        }
    }
    if (type == 4) {
        self.projectManShowInfo = dataArray;
    } else if (type == 5) {
        self.maintainPersonsShowInfo = dataArray;
    } else if (type == 6) {
        self.aPersonsShowInfo = dataArray;
    }
    return marray;
}
///根据ID  返回人名
- (NSArray *)backNameWithDataArray:(NSArray *)dataArray ids:(NSArray *)ids isFirst:(BOOL)first{
    NSMutableArray *names = [NSMutableArray new];
    for (JZManModel *man in dataArray) {
        if (first) {
             [names addObject:man.userName];
        } else {
            if ([ids containsObject:man]) {
                [names addObject:man.userName];
            }
        }
    }
    return names;
}
- (IBAction)btn1:(UIButton *)sender {// 项目负责人  2.项目负责人  3.维护人  1  甲方负责人
    if (!self.projectManInfo) {
        __block typeof(self) weakSelf = self;
        [self.baseNet usersListRoleID:@"3" usersIdStr:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
            weakSelf.projectManInfo = responseObj;
            NSArray *showArray = [weakSelf backUnselectManArrayWithArray:weakSelf.projectManInfo selectIds:weakSelf.projectManIDs type:4];
            [weakSelf showSelectManInfo:showArray type:4];
        }];
    } else {
        NSArray *showArray = [self backUnselectManArrayWithArray:self.projectManInfo selectIds:self.projectManIDs type:4];
        [self showSelectManInfo:showArray type:4];
    }
}
- (IBAction)btn2Action:(UIButton *)sender {//维护人员
    if (self.activityTF) {
        self.activityTF = nil;
    }
    if (!self.maintainPersonsInfo) {
        __block typeof(self) weakSelf = self;
        [self.baseNet usersListRoleID:@"3" usersIdStr:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
            weakSelf.maintainPersonsInfo = responseObj;
            NSArray *showArray = [weakSelf backUnselectManArrayWithArray:weakSelf.maintainPersonsInfo selectIds:weakSelf.maintainPersonsIDS type:5];
            [weakSelf showSelectManInfo:showArray type:5];
        }];
    } else {
        NSArray *showArray = [self backUnselectManArrayWithArray:self.maintainPersonsInfo selectIds:self.maintainPersonsIDS type:5];
        [self showSelectManInfo:showArray type:5];
    }
}
- (IBAction)btn3Action:(UIButton *)sender {//甲方人员
    if (self.activityTF) {
        self.activityTF = nil;
    }
    if (!self.aPersonsInfo) {
         __block typeof(self) weakSelf = self;
        [self.baseNet usersListRoleID:@"1" usersIdStr:@"" backData:^(BOOL netOk, id  _Nonnull responseObj) {
            weakSelf.aPersonsInfo = responseObj;
            NSArray *showArray = [weakSelf backUnselectManArrayWithArray:weakSelf.aPersonsInfo selectIds:weakSelf.aPersonsIDs type:6];
            [weakSelf showSelectManInfo:showArray type:6];
        }];
    } else {
        NSArray *showArray = [self backUnselectManArrayWithArray:self.aPersonsInfo selectIds:self.aPersonsIDs type:6];
        [self showSelectManInfo:showArray type:6];
    }
}

-(void)dateChange:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    if (self.activityTF) {
        self.activityTF.text = dateStr;
        [self.activityTF resignFirstResponder];
    }
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (UIView *obj in self.contenView.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            if ([obj isKindOfClass:[UITextView class]]) {
//                [obj endEditing:YES];
            }
                
            for (id tf in obj.subviews) {
                if ([tf isKindOfClass:[UITextField class]]  || [tf isKindOfClass:[UITextView class]]) {
                    [tf endEditing:YES];
                }
            }
        }
    }
}
#pragma mark UITextInputDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.serviceEndTF]) {
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activityTF = textField;
    textField.inputView = [[UIView alloc] init];
    if ([textField isEqual:self.address1TF]) {//地点
        [self.view addSubview:self.addressPicke];
    }else if ([textField isEqual:self.serviceContentTF]){//服务内容
        self.pickeType = 1;
        self.onePicke.dataArray = self.serviceShowArray;
        [self.view addSubview:self.onePicke];
    }else if ([textField isEqual:self.serviceTimeTF]){//服务时间
        self.pickeType = 2;
        self.onePicke.dataArray = self.serviceTimeShowArray;
        [self.view addSubview:self.onePicke];
    }else if ([textField isEqual:self.checkTimeTF]){//检查时间
            self.pickeType = 3;
            self.onePicke.dataArray = self.lookShowArray;
            [self.view addSubview:self.onePicke];
    }else if ([textField isEqual:self.serviceStartTF]){//服务开始时间
        if (!self.serviceTime) {
            [textField endEditing:YES];
            [JZTost showTost:@"请选择服务有效时间"];
        } else {
            self.startTime = YES;
            [self.view addSubview:self.datePicker];
        }
    }else if ([textField isEqual:self.serviceEndTF]){//服务结束时间
        self.startTime = NO;
        [self.view addSubview:self.datePicker];
    }
}
#pragma mark datePickerDelegate
- (void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView{
    if (self.activityTF) {
        [self.activityTF resignFirstResponder];
        self.activityTF.text = date;
    }
    if (self.startTime) {
        self.projectModel.servicestarttime = date;
        self.serviceEndTF.text = [self backNewTimeWithTime1:date time2:self.serviceTime];
        self.projectModel.serviceendtime = [self backNewTimeWithTime1:date time2:self.serviceTime];
    } else {
        self.projectModel.serviceendtime = date;
    }
    [pickerView removeFromSuperview];
}
- (void)datePicerCancel:(JZDatePickeView *)pickerView{
    [self.activityTF resignFirstResponder];
    [pickerView removeFromSuperview];
}
#pragma mark AddressPickerDelegate
- (void)addressPickerWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    self.address1TF.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.projectModel.province = province;
    self.projectModel.city = city;
    self.projectModel.county = area;
    [self.address1TF resignFirstResponder];
    [self.addressPicke removeFromSuperview];
}
/** 取消代理方法*/
- (void)addressPickerCancleAction{
    [self.address1TF resignFirstResponder];
    [self.addressPicke removeFromSuperview];
}
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.markEdit = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.markEdit = NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
        
    }
    return YES;
}
#pragma mark ZYQAssetPickerControllerDelegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    if (assets.count > 0) {
         ZYQAsset *asset = assets[0];
        PHImageManager * imageManager = [PHImageManager defaultManager];
        __weak typeof(self) weakSelf = self;
        [imageManager requestImageDataForAsset:asset.originAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            UIImage *image = [UIImage imageWithData:imageData];
            self.selectImage = image;
            [weakSelf.projectNetModel uploadProjectFileWithData:UIImageJPEGRepresentation(image, 0.1) backData:^(BOOL netOk, id  _Nonnull responseObj) {
                self.searchBtn.hidden = NO;
                if (netOk) {
                    self.imageUrlStr = responseObj;
                } else {
                    [JZTost showTost:responseObj];
                }
            }];
            
        }];
    }
}

#pragma mark  onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    NSLog(@"%@",date);
    self.activityTF.text = date;
    [self.activityTF resignFirstResponder];
    [self.onePicke removeFromSuperview];
    switch (self.pickeType) {////1.服务内容  2.服务有效时间  3.固定巡检时间  4.项目负责人  5.维护人  6  甲方负责人
        case 1:{
            JZServiceItemModel *item = self.serviceArray[index];
            self.projectModel.serviceid = item.itemID;
        }
            break;
        case 2:{
            JZServiceTimeModel *time = self.serviceTimeArray[index];
             self.serviceTime = time.time;
            self.projectModel.effectivetime = time.itemId;
            self.projectModel.effectiveDec = time.time;
            if (self.serviceStartTF.text && self.serviceStartTF.text.length > 0) {
                 self.serviceEndTF.text = [self backNewTimeWithTime1:self.serviceStartTF.text time2:self.serviceTime];
                 self.projectModel.serviceendtime = [self backNewTimeWithTime1:self.serviceStartTF.text time2:self.serviceTime];
            }
        }
            break;
        case 3:{
            JZLooptaskItemModel *loop = self.lookArray[index];
            self.projectModel.taskid = loop.itemId;
        }
            break;
        case 4:{
            if (self.projectManShowInfo.count > index) {
                 JZManModel *man = self.projectManShowInfo[index];
                [self.projectManIDs addObject:man];
                [self setPersonViewsWithView:self.scrollView1 dataArray:[self backNameWithDataArray:self.projectManInfo ids:self.projectManIDs isFirst:NO] personType:0];
            }
        }
            break;
        case 5:{
            if (self.maintainPersonsShowInfo.count > index) {
                JZManModel *man = self.maintainPersonsShowInfo[index];
                [self.maintainPersonsIDS addObject:man];
                [self setPersonViewsWithView:self.scrollView2 dataArray:[self backNameWithDataArray:self.maintainPersonsInfo ids:self.maintainPersonsIDS isFirst:NO] personType:10];
            }
        }
            break;
        case 6:{
            if (self.aPersonsShowInfo.count > index) {
                JZManModel *man = self.aPersonsShowInfo[index];
                [self.aPersonsIDs addObject:man];
                [self setPersonViewsWithView:self.scrollView3 dataArray:[self backNameWithDataArray:self.aPersonsInfo ids:self.aPersonsIDs isFirst:NO] personType:20];
            }
        }
            break;
        default:
            break;
    }
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.activityTF resignFirstResponder];
    [self.onePicke removeFromSuperview];
}
- (NSString *)backNewTimeWithTime1:(NSString *)time1 time2:(NSString *)time2{
    NSString *yearStr = [time1 substringToIndex:4];
    NSRange range1 = [time1 rangeOfString:@"年"];
    NSRange range2 = [time1 rangeOfString:@"月"];
    NSRange range4;
    range4.location = range2.location + 1;
    range4.length = time1.length - range4.location;
    NSRange range3 ;
    range3.location = range1.location + 1;
    range3.length =  range2.location - range3.location;
    NSString *monthStr = [time1 substringWithRange:range3];
    NSInteger year = [yearStr integerValue];
    NSInteger month = [monthStr integerValue] + [time2 integerValue];
    NSInteger newYear;
    NSInteger newMonth;
    if (month > 12) {
         newYear = month/12 + year;
         newMonth = month%12;
        if (newMonth == 0) {
            newMonth = 12;
            newYear -= 1;
        }
    } else {
        newYear = year;
        newMonth = month;
    }
    return [NSString stringWithFormat:@"%zd年%zd月%@",newYear,newMonth,[time1 substringWithRange:range4]];
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
-(JZDatePickeView *)datePicker {
    if (_datePicker == nil) {
        self.datePicker = [[JZDatePickeView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}
-(JZBaseNetModel *)baseNet {
    if (_baseNet == nil) {
        self.baseNet = [[JZBaseNetModel alloc]init];
    }
    return _baseNet;
}
- (void)imageTouchActio {
    self.imageView.hidden = YES;
}
-(UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _imageView.userInteractionEnabled = YES;
        _imageView.hidden = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouchActio)];
        [_imageView addGestureRecognizer:tapG];
        [[UIApplication sharedApplication].keyWindow addSubview:_imageView];
    }
    return _imageView;
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
