//
//  JZPersonDetVC.m
//  JZProject
//
//  Created by zjz on 2019/11/9.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZPersonDetVC.h"
#import "ShowView.h"
@interface JZPersonDetVC ()
@property(nonatomic,strong)ShowView *showView1;
@property(nonatomic,strong)ShowView *showView2;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation JZPersonDetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    // Do any additional setup after loading the view from its nib.
}
- (void)creactUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(Width, 700);
    self.scrollView = scrollView;
    self.showView1 = [ShowView creatShowView];
    self.showView2 = [ShowView creatShowView];
    self.showView2.y = 220;
    [scrollView addSubview:_showView1];
    [scrollView addSubview:_showView2];
    [self.view addSubview:scrollView];
    [self showDataWithModel:self.model];
}
- (void)clickBtnAction{
    if (self.showPass) {//通过操作
        [self.netModel passUserid:self.model.userid backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                self.backData(YES, @{});
                [self.navigationController popViewControllerAnimated:YES];
            } else{
                [JZTost showTost:responseObj];
            }
        }];
    } else {//删除操作
        [self.netModel deleteUserid:self.model.userid backData:^(BOOL netOk, id  _Nonnull responseObj) {
            if (netOk) {
                [self.navigationController popViewControllerAnimated:YES];
            } else{
                [JZTost showTost:responseObj];
            }
        }];
    }
}
- (void)showDataWithModel:(JZShowManModel *)model {
    self.showView1.firstLeftL.text = @"角色:";
    self.showView1.secLeftL.text = @"详细地址:";
    self.showView1.thredLeftL.text = @"联系人:";
    self.showView1.forthLeftL.text = @"联系方式:";
    NSString *testTitle = @"甲方负责人";
    switch ([model.status intValue]) {
        case 2:
            testTitle = @"项目负责人";
            break;
        case 3:
            testTitle = @"维护人员";
            break;
        case 4:
            testTitle = @"系统管理员";
            break;
        case 5:
            testTitle = @"注册工程师";
            break;
        default:
            break;
    }
    self.showView1.firstRightL.text = model.rolename ? model.rolename : testTitle;
    self.showView1.secRightL.text = [NSString stringWithFormat:@"%@%@%@%@",model.provice ? model.provice : @"",model.city?model.city:@"",model.area?model.area:@"",model.address?model.address:@""];
    self.showView1.thredRightL.text = [NSString stringWithFormat:@"%@",model.realname];
    self.showView1.forthRightL.text = [NSString stringWithFormat:@"%@",model.mobile];
    if (![model.roleid isEqualToString:@"1"]) {//工程师
        self.showView1.fiveLeftL.text = @"性别";
        self.showView1.fiveRightL.text = [NSString stringWithFormat:@"%@",model.sex?model.sex:@""];
        self.showView2.firstLeftL.text = @"毕业院校:";
        self.showView2.secLeftL.text = @"工作经验:";
        self.showView2.thredLeftL.text = @"个人技能:";
        self.showView2.forthLeftL.text = @"意向:";
        self.showView2.fiveLeftL.text = @"个人证书:";
        self.showView2.firstRightL.text = [NSString stringWithFormat:@"%@",model.university ? model.university : @""];
        self.showView2.secRightL.text = [NSString stringWithFormat:@"%@年",model.experience ? model.experience : @""];
        self.showView2.thredRightL.text = [NSString stringWithFormat:@"%@",model.skill ? model.skill : @""];
        self.showView2.forthRightL.text = [NSString stringWithFormat:@"%@",model.intention ? model.intention : @""];
        self.showView2.fiveRightL.text = [NSString stringWithFormat:@"%@",model.certificate ? model.certificate : @""];

    } else {
        self.showView1.fiveLeftL.text = @"单位名称:";//1
        self.showView1.fiveRightL.text = [NSString stringWithFormat:@"%@",model.companyname ? model.companyname : @""];
       
        self.showView2.firstLeftL.text = @"服务需求:";
        self.showView2.secLeftL.text = @"希望技术支持地点:";
        self.showView2.firstRightL.text = [NSString stringWithFormat:@"%@",model.certificate ? model.certificate : @""];
         self.showView2.secRightL.text = [NSString stringWithFormat:@"%@",model.expectsupport ? model.expectsupport : @""];
        self.showView2.thredView.hidden = YES;
        self.showView2.fourthView.hidden = YES;
        self.showView2.firveView.hidden = YES;
        self.showView2.height = 100;
        self.scrollView.contentSize = CGSizeMake(Width, 550);
    }
    [self.showView1 makeSizeToFit];
    [self.showView2 makeSizeToFit];
    CGFloat bottomTop = self.showView2.bottom;
    if (model.remark && model.remark.length > 0) {
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(10, self.showView2.bottom, Width - 20, 40)];
        add.text = @"补充说明";
        UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(10, add.bottom, Width - 20, 60)];
        textV.editable = NO;
        textV.text = model.remark;
        [self textViewDidChange:textV];
        bottomTop = textV.bottom;
        [self.scrollView addSubview:add];
        [self.scrollView addSubview:textV];
    }
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, bottomTop + 20, Width - 40, 40);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:[NSString stringWithFormat:@"%@",self.showPass ? @"审核通过" : @"删除"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
}
-(void)textViewDidChange:(UITextView *)textView{
    float textViewHeight =  [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
    CGRect frame = textView.frame;
    frame.size.height = textViewHeight;
    textView.frame = frame;
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

