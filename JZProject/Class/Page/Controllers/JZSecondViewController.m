//
//  JZSecondViewController.m
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZSecondViewController.h"
#import "JZProjectMainVController.h"
#import "JZNotifictionCell.h"
#import "JZNotificaModel.h"
#import "JZSearchView.h"
#import "JZNotifictionNewCell.h"
#import "JZRegisterNetModel.h"
#import "JZPersonDetVC.h"
static NSString *NODE_CELL_ID = @"zhuanti_cell_id";
@interface JZSecondViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *noticeList;
@property(nonatomic,copy)NSString *searchStr;
@property(nonatomic,strong)JZSearchView *search;
@property(nonatomic,strong)JZRegisterNetModel *registNet;
@end

@implementation JZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = TopColor;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self makeData];
    self.noticeList = [NSArray new];
    self.registNet = [JZRegisterNetModel shareRegistNetModel];
    // Do any additional setup after loading the view.
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
    [self makeData];
    NSDictionary *obj = notifiction.object;
    if ([obj[@"msgType"] isEqualToString:@"1"] || [obj[@"msgType"] isEqualToString:@"2"]) {//警告
        JZProjectMainVController *mainVc = [JZProjectMainVController shareMainProject];
        mainVc.eventwarringId = obj[@"eventwarringId"];
        mainVc.projectId = obj[@"projectId"];
        mainVc.eventwarringId = obj[@"eventwarringId"];
        mainVc.titleName = obj[@"projectName"];
        mainVc.faultStatus = obj[@"faultStatus"];
        mainVc.hidesBottomBarWhenPushed = YES;
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:mainVc animated:YES];
    } else if ([obj[@"msgType"] isEqualToString:@"3"]) {//人员管理
        if (!obj[@"userId"]) {
            [JZTost showTost:@"参数异常"];
            return;
        }
        [JZProgress showWithStatus:@"加载中"];
        [self.registNet userDetailUserid:obj[@"userId"] backData:^(BOOL netOk, id  _Nonnull responseObj) {
            [JZProgress dismiss];
            if (netOk) {
                JZShowManModel *man = responseObj;
                JZPersonDetVC *personDet = [[JZPersonDetVC alloc] init];
                personDet.model = man;
                personDet.netModel = self.registNet;
                personDet.showPass = [man.status isEqualToString:@"1"] ? NO : YES;
                personDet.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:personDet animated:YES];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    }
   
}
- (void)creactUI {
    self.search = [JZSearchView shareSearchBar];
    self.search.searchView.delegate = self;
    self.search.frame = CGRectMake(0, statusBarAndNavigationBarHeight, Width, 60);
    [self.search.searchBtn addTarget:self action:@selector(clickeSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat tableHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - customBottomBarHeight - 40;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.search.frame), Width, tableHeight) style:UITableViewStylePlain];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [_tableView registerNib:[UINib nibWithNibName:@"JZNotifictionNewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NODE_CELL_ID];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.search];
    [self.view addSubview:self.tableView];
}
- (void)makeData {
    __weak typeof(self) weakSelf = self;
    [self.projectNetModel queryMsgRecordWithContent:self.searchStr BackData:^(BOOL netOk, id  _Nonnull responseObj) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (netOk) {
            weakSelf.noticeList = responseObj;
            [weakSelf.tableView reloadData];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchStr = searchBar.text;
    [self makeData];
}
- (void)downLoad {
    self.searchStr = @"";
    self.search.searchView.text = @"";
    [self makeData];
}
#pragma mark clickeSearchBtn
- (void)clickeSearchBtn:(UIButton *)btn{
    [self.search.searchView endEditing:YES];
    self.searchStr = self.search.searchView.text;
    [self makeData];
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeList.count;
}
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return rect.size.height;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZNotificaModel *model = self.noticeList[indexPath.row];
    return [JZSecondViewController getLabelHeightWithText:model.msgcontext width:Width -30 font:15] + 90;
}
#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZNotifictionNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [JZNotifictionNewCell shareNotifictionCell];
    }
    JZNotificaModel *model = self.noticeList[indexPath.row];
    [cell showViewWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
      JZNotificaModel *model = self.noticeList[indexPath.row];
    NSString *faultStatus = @"1";
    if ([model.warringstatus isEqual:@4] || [model.type isEqual:@5] || [model.type isEqual:@6]){
        faultStatus = @"3";
    }
    if ([model.type isEqualToString:@"1"]) {//告警
        JZProjectMainVController *mainVc = [JZProjectMainVController shareMainProject];
        mainVc.titleName = model.projectname;
        mainVc.projectId = model.projectid;
        mainVc.faultStatus = faultStatus;
        mainVc.hidesBottomBarWhenPushed = YES;
        self.hidesBottomBarWhenPushed = NO;
        //    [self presentViewController:mainVc animated:YES completion:nil];
        [self.navigationController pushViewController:mainVc animated:YES];
    } else if ([model.type isEqualToString:@"2"]) {//项目管理
        JZProjectMainVController *mainVc = [JZProjectMainVController shareMainProject];
        mainVc.titleName = model.projectname;
        mainVc.projectId = model.projectid;
        mainVc.hidesBottomBarWhenPushed = YES;
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:mainVc animated:YES];
    } else {//人员管理
        if (!model.remark) {
            [JZTost showTost:@"参数异常"];
            return;
        }
        [JZProgress showWithStatus:@"加载中"];
        [self.registNet userDetailUserid:model.remark backData:^(BOOL netOk, id  _Nonnull responseObj) {
            [JZProgress dismiss];
            if (netOk) {
                JZShowManModel *man = responseObj;
                JZPersonDetVC *personDet = [[JZPersonDetVC alloc] init];
                personDet.model = man;
                personDet.netModel = self.registNet;
                personDet.showPass = [man.status isEqualToString:@"1"] ? NO : YES;
                personDet.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:personDet animated:YES];
            } else {
                [JZTost showTost:responseObj];
            }
        }];
    }
  
}


@end
