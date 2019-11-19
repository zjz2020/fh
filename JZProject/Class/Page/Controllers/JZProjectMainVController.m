//
//  JZProjectMainVController.m
//  JZProject
//  项目详情 --警告 ---维护记录
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProjectMainVController.h"
#import "JZProjectVC.h"
#import "JZRunViewController.h"
#import "JZAlartListVC.h"
#import "JZRecordVC.h"
#import "UIBarButtonItem+JZBarButtonItem.h"
#import "JZAlartDetailVC.h"
@interface JZProjectMainVController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *projectInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *runBtn;
@property (weak, nonatomic) IBOutlet UIButton *notifictionBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,strong)UIView *view1;
@property(nonatomic,strong)UIView *view2;
@property(nonatomic,strong)UIView *view3;
@property(nonatomic,strong)UIView *view4;
@property(nonatomic,strong)UIBarButtonItem *alertRightBar;
@property(nonatomic,strong)UIBarButtonItem *searchBar;
@property(nonatomic,strong)UIBarButtonItem *refreshBar;
@property(nonatomic,assign)NSInteger nowShowPage;
@end

@implementation JZProjectMainVController
+ (JZProjectMainVController *)shareMainProject{
    return [[JZProjectMainVController alloc] initWithNibName:@"JZProjectMainVController" bundle:[NSBundle mainBundle]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nowShowPage = 0;
    self.title = self.titleName;
   
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotification:) name:@"notification" object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)didNotification:(NSNotification *)notifiction{
    NSDictionary *obj = notifiction.object;
    self.projectId = obj[@"projectId"];
    self.eventwarringId = obj[@"eventwarringId"];
    self.titleName = obj[@"projectName"];
    self.faultStatus = obj[@"faultStatus"];
    [self notifictionScroll:self.faultStatus eventwarringId:self.eventwarringId];
}
- (void)creactUI {
    [self mackBtnBackgroundWhite];
    self.projectInfoBtn.backgroundColor = [UIColor whiteColor];
    [self creactScrollView];
    [self loadSubBViews];
}
- (void)creactScrollView{
    CGFloat height = (Height - customBottomBarHeight -statusBarHeight - tabbarSafeBottomMargin);
    self.scrollView.frame = CGRectMake(0, statusBarHeight, Width, height);
    _scrollView.delegate = self;
    self.bottomView.size = CGSizeMake(Width, 60);
    self.bottomView.top = self.scrollView.height + statusBarHeight;
    self.scrollView.contentSize = CGSizeMake(Width *4, self.scrollView.height);
    self.scrollView.delegate = self;
    self.view1 = [self backViewWithFram:CGRectMake(0, 0, Width, self.scrollView.height) backgroundColor:TopColor];
    [self.scrollView addSubview:self.view1];
    [self notifictionScroll:self.faultStatus eventwarringId:self.eventwarringId];
}
- (void)notifictionScroll:(NSString *)faultStatus eventwarringId:(NSString *)eventwarringId{
    if (faultStatus) {
        if ([self.faultStatus isEqual:@"1"] || [self.faultStatus isEqual:@"2"]) {
            [self.scrollView setContentOffset:CGPointMake(Width *2,0)];
            [self makeViewScroTo:2];
        } else {
            [self.scrollView setContentOffset:CGPointMake(Width *3,0)];
            [self makeViewScroTo:3];
        }
    }
}
- (void)loadSubBViews{
    JZProjectVC *projectVc = [JZProjectVC shareProjectVc];
    projectVc.projectId = self.projectId;
    [projectVc setSelfViewHeight:self.scrollView.height];
    [self addChildViewController:projectVc];
    [self.view1 addSubview:projectVc.view];
}

- (UIView *)backViewWithFram:(CGRect)fram backgroundColor:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:fram];
    view.backgroundColor = color;
    return view;
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [self makeViewScroTo:0];
    }else if (scrollView.contentOffset.x == Width){
        [self makeViewScroTo:1];
    }else if (scrollView.contentOffset.x == 2*Width){
        [self makeViewScroTo:2];
    }else if (scrollView.contentOffset.x == 3*Width){
        [self makeViewScroTo:3];
    }
}
- (void)makeViewScroTo:(NSInteger)page {
    self.nowShowPage = page;
    [self mackBtnBackgroundWhite];
    switch (page) {
        case 0:{
//            self.title = self.titleName;
             self.projectInfoBtn.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 1:{
//             self.title = @"运行维护";
            self.navigationItem.rightBarButtonItem = self.refreshBar;
             self.runBtn.backgroundColor = [UIColor whiteColor];
            if (!self.view2) {
                self.view2 = [self backViewWithFram:CGRectMake(Width, 0, Width, self.scrollView.height) backgroundColor:[UIColor whiteColor]];
                 [self.scrollView addSubview:self.view2];
                JZRunViewController *runControll = [[JZRunViewController alloc] init];
                [runControll setSelfViewHeight:self.scrollView.height];
                [self addChildViewController:runControll];
                [self.view2 addSubview:runControll.view];
            }
        }
            break;
        case 2:{
//             self.title = @"事件警告";
            self.navigationItem.rightBarButtonItem = self.alertRightBar;
             self.notifictionBtn.backgroundColor = [UIColor whiteColor];
            if (!self.view3) {
                self.view3 = [self backViewWithFram:CGRectMake(Width *2, 0, Width, self.scrollView.height) backgroundColor:[UIColor whiteColor]];
                [self.scrollView addSubview:self.view3];
                JZAlartListVC *alartVc = [[JZAlartListVC alloc] init];
                alartVc.alartType = 0;
                alartVc.projectId = self.projectId;
                [self addChildViewController:alartVc];
                [self.view3 addSubview:alartVc.view];
            }
        }
            break;
        case 3:{
//            self.title = @"维护记录";
             self.navigationItem.rightBarButtonItem = self.searchBar;
            self.recordBtn.backgroundColor = [UIColor whiteColor];
            if (!self.view4) {
                self.view4 = [self backViewWithFram:CGRectMake(Width *3, 0, Width, self.scrollView.height) backgroundColor:[UIColor whiteColor]];
                [self.scrollView addSubview:self.view4];
                JZRecordVC *recordVc = [[JZRecordVC alloc] init];
                recordVc.projectId = self.projectId;
                [self addChildViewController:recordVc];
                [self.view4 addSubview:recordVc.view];
            }
        }
            break;
        default:
            break;
    }
}
- (void)mackBtnBackgroundWhite{
    self.projectInfoBtn.backgroundColor = TopColor;
    self.runBtn.backgroundColor = TopColor;
    self.notifictionBtn.backgroundColor = TopColor;
    self.recordBtn.backgroundColor = TopColor;
}
#pragma mark btnAction
- (void)clickeRightBtnAction:(UIBarButtonItem *)btn{
    if (self.nowShowPage == 0 || self.nowShowPage == 1) {//刷新
        
    } else if (self.nowShowPage == 2) {//跳转到故障申报页面
        JZAlartDetailVC *alartDetail = [JZAlartDetailVC shareAlartDetail];
        alartDetail.projectId = self.projectId;
        alartDetail.isCreat = YES;
        [self.navigationController pushViewController:alartDetail animated:YES];
    } else if (self.nowShowPage == 3) {//维护记录
        [JZTost showTost:@"该功能尚未开放.."];
    }
}
- (IBAction)projectInfoAction:(UIButton *)sender {
    [self makeViewScroTo:0];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}
- (IBAction)runBtnAction:(UIButton *)sender {
     [self.scrollView setContentOffset:CGPointMake(Width, 0)];
    [self makeViewScroTo:1];
}
- (IBAction)notificationAction:(UIButton *)sender {
     [self.scrollView setContentOffset:CGPointMake(Width *2,0)];
    [self makeViewScroTo:2];
}
- (IBAction)recordBtnAction:(UIButton *)sender {
     [self.scrollView setContentOffset:CGPointMake(Width *3, 0)];
    [self makeViewScroTo:3];
}
-(UIBarButtonItem *)searchBar {
    if (_searchBar == nil) {
        self.searchBar = [UIBarButtonItem creatBtnWithTitle:@"技术查询" target:self action:@selector(clickeRightBtnAction:)];
        _searchBar.tag = 104;
    }
    return _searchBar;
}
-(UIBarButtonItem *)alertRightBar {
    if (_alertRightBar == nil) {
        self.alertRightBar = [UIBarButtonItem creatBtnWithTitle:@"故障申报" target:self action:@selector(clickeRightBtnAction:)];
        _alertRightBar.tag = 103;
    }
    return _alertRightBar;
}
-(UIBarButtonItem *)refreshBar {
    if (_refreshBar == nil) {
        self.refreshBar = [UIBarButtonItem creatBtnWithImage:[UIImage imageNamed:@"refresh"] target:self action:@selector(clickeRightBtnAction:)];
        _refreshBar.tag = 102;
    }
    return _refreshBar;
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
