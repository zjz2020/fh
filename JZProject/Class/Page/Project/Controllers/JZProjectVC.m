//
//  JZProjectVC.m
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProjectVC.h"
#import "JZProjectManView.h"
#import "JZNetWorkHelp.h"
#import "JZProjectModel.h"
#import <SDWebImage/SDWebImage.h>
@interface JZProjectVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *lowScrollView;
@property (weak, nonatomic) IBOutlet UIView *lowView;
@property (weak, nonatomic) IBOutlet UILabel *companyTF;
@property (weak, nonatomic) IBOutlet UILabel *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *serviceTF;
@property (weak, nonatomic) IBOutlet UILabel *timeTF;
@property (weak, nonatomic) IBOutlet UILabel *stateTF;
@property (weak, nonatomic) IBOutlet UILabel *runTimeL;
@property (weak, nonatomic) IBOutlet UILabel *startTimeL;
@property (weak, nonatomic) IBOutlet UILabel *endTimeL;
@property (weak, nonatomic) IBOutlet UIView *manView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manviewHeight;
@property (weak, nonatomic) IBOutlet UITextView *ramarkTv;
@property(nonatomic,strong)JZProjectModel *model;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation JZProjectVC
+ (JZProjectVC *)shareProjectVc{
    return [[JZProjectVC alloc] initWithNibName:@"JZProjectVC" bundle:[NSBundle mainBundle]];
}
- (void)setSelfViewHeight:(CGFloat)height{
    self.view.height = height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBtn.hidden = YES;
    self.ramarkTv.layer.masksToBounds = YES;
    self.ramarkTv.layer.cornerRadius = 5;
    self.ramarkTv.layer.borderColor = GrayColor2.CGColor;
    self.ramarkTv.layer.borderWidth = 1;
    [self makeData];
    self.view.frame = CGRectMake(0, 0, Width, Height + 60);
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)searchBtnAction:(UIButton *)sender {
    self.imageView.hidden = NO;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.fileurl] placeholderImage:[UIImage imageNamed:@"001"]];
}
- (void)makeData {
    __weak typeof(self) weakSelf = self;
    [self.projectNetModel queryProjectInfoWithProjectId:self.projectId backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            weakSelf.model = responseObj;
            [weakSelf refreshUIWithModel:responseObj];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
    [self.projectNetModel queryZbAccountWithProjectId:self.projectId backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
             NSString *url = [NSString stringWithFormat:@"%@%@",[JZNetWorkHelp shareNetWork].zbip,@"/users/login"];
            [weakSelf.netHelp zbLoginNetWithParameter:@{} urlStr:url backData:^(BOOL netOk, id  _Nonnull responseObj) {
                
            }];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
- (void)refreshUIWithModel:(JZProjectModel *)model {
    if (model.fileurl) {
        self.searchBtn.hidden = NO;
    } else {
        self.searchBtn.hidden = YES;
    }
    self.companyTF.text = model.projectname;
    self.addressTF.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.county,model.address];
    self.serviceTF.text = model.serviceditemetail;
    self.timeTF.text = [NSString stringWithFormat:@"%@月",model.effectivetime];
    self.runTimeL.text = model.taskname;
    self.stateTF.text = model.auditstatus;
//    self.ramarkTv.text = model.
    if (model.servicestarttime) {
        self.model.servicestarttime = [self changeStringToTime:model.servicestarttime];
        self.startTimeL.text = self.model.servicestarttime;
    }
    if (model.serviceendtime) {
        self.endTimeL.text = [self changeStringToTime:model.serviceendtime];
        self.model.serviceendtime = [self changeStringToTime:model.serviceendtime];
    }
    [self creactUIWithModel:model];
}
- (void)creactUIWithModel:(JZProjectModel *)projectModel{
    NSInteger count = 1 + projectModel.partyasPerson.count + projectModel.servicePerson.count;
     self.manviewHeight.constant = count *30;
    CGFloat height = (Height - statusBarAndNavigationBarHeight - customBottomBarHeight + self.manviewHeight.constant);
    self.lowScrollView.contentSize = CGSizeMake(Width,height);
    JZManModel *firstModel = [JZManModel shareModel];
    firstModel.userName = projectModel.headname;
    firstModel.mobile = projectModel.headmobile;
    UIView *v1 = [self backViewWithModel:firstModel showTitle:YES title:@"项目负责人"];
    [self.manView addSubview:v1];
    for (NSInteger i = 0; i < projectModel.servicePerson.count; i ++) {
        JZManModel *manModel = projectModel.servicePerson[i];
        if (i == 0) {
             UIView *partyView = [self backViewWithModel:manModel showTitle:YES title:@"维护人员"];
            partyView.y = 30;
            [self.manView addSubview:partyView];
        } else {
             UIView *partyView = [self backViewWithModel:manModel showTitle:NO title:@""];
            partyView.y = (i +1) *30;
            [self.manView addSubview:partyView];
        }
    }
    for (NSInteger i = 0; i < projectModel.partyasPerson.count; i ++) {
        JZManModel *manModel = projectModel.partyasPerson[i];
        if (i == 0) {
            UIView *partyView = [self backViewWithModel:manModel showTitle:YES title:@"甲方负责人"];
            partyView.y = 30 *(1 + projectModel.servicePerson.count);
            [self.manView addSubview:partyView];
        } else {
            UIView *partyView = [self backViewWithModel:manModel showTitle:NO title:@""];
            partyView.y = (i +projectModel.servicePerson.count +1) *30;
            [self.manView addSubview:partyView];
        }
    }
}
- (UIView *)backViewWithModel:(JZManModel *)model showTitle:(BOOL)show title:(NSString *)title{
     UIView *manView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.manView.width, 30)];
    JZProjectManView *manView1 = [JZProjectManView shareManView];
    if (!show) {
        manView1.label1.hidden = YES;
    } else {
        manView1.leftTitleL.text = title;
    }
    if (model) {
        manView1.label2.text = model.userName;
        manView1.phoneLabel.text = model.mobile;
    }
    manView1.frame =CGRectMake(0, 0, self.manView.width, 30);
    [manView addSubview:manView1];
    return manView;
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
