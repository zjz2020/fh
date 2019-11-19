//
//  JZPersonViewController.m
//  JZProject
//
//  Created by zjz on 2019/11/5.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZPersonViewController.h"
#import "JZNotifictionCell.h"
#import "JZProjectMainVController.h"
#import "JZTheViewController.h"
#import "JZSearchView.h"
#import "JZCreatProjectVC.h"
#import "JZProjectVC.h"
#import "JZTabBarController.h"
#import "JZShowManModel.h"
#import "JZForgetPassWordVC.h"
#import "UIBarButtonItem+JZBarButtonItem.h"
#import "popView.h"
#import "PopTableListView.h"
#import "JZMineViewController.h"
#import "JZRegisterNetModel.h"
#import "JZPersonDetVC.h"
#import "JZShowViewController.h"
static NSString *NODE_CELL_ID = @"zhuanti_cell_id";
@interface JZPersonViewController ()<UITableViewDelegate,UITableViewDataSource,PopTableListViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JZSearchView *search;
@property(nonatomic,strong)JZRegisterNetModel *netModel;
@property(nonatomic,strong)NSArray *dataList;
@property (nonatomic ,strong) PopTableListView *popListView;
@property(nonatomic,copy)NSString *searchStr;
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)NSString *auditState;
@end

@implementation JZPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.auditState  = @"0";
    self.navigationController.navigationBar.barTintColor = TopColor;
    self.searchStr = @"";
    [self makeButtonItem];
    [self creatTableView];
    [self makeData];
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
//    NSDictionary *obj = notifiction.object;
//    JZProjectMainVController *mainVc = [JZProjectMainVController shareMainProject];
//    mainVc.projectId = obj[@"projectId"];
//    mainVc.titleName = obj[@"projectName"];
//    mainVc.faultStatus = obj[@"faultStatus"];
//    mainVc.hidesBottomBarWhenPushed = YES;
//    self.hidesBottomBarWhenPushed = NO;
//    [self.navigationController pushViewController:mainVc animated:YES];
}
- (void)makeButtonItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBtnWithTitle:@"更多" target:self action:@selector(clickeLeftItem:)];
}
- (void)makeData {
    __weak typeof(self) weakSelf = self;
    [self.netModel userListWithUsername:self.searchStr roleids:@"" status:self.auditState backData:^(BOOL netOk, id  _Nonnull responseObj) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (netOk) {
            weakSelf.dataList = responseObj;
            [weakSelf.tableView reloadData];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
- (void)downLoad {
    self.searchStr = @"";
    self.search.searchView.text = @"";
    [self makeData];
}
- (void)clickeSegment:(UISegmentedControl *)sender {
    self.auditState = [NSString stringWithFormat:@"%zd",sender.selectedSegmentIndex];
    [self makeData];
}
- (void)creatTableView{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"未审核",@"已审核"]];
    self.segment.frame = CGRectMake(Width/2 - 50, statusBarAndNavigationBarHeight + 10, 120, 30);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(clickeSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    self.search = [JZSearchView shareSearchBar];
    self.search.searchView.delegate = self;
    self.search.frame = CGRectMake(0, statusBarAndNavigationBarHeight + 40, Width, 50);
    [self.search.searchBtn addTarget:self action:@selector(clickeSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat tableHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - customBottomBarHeight - 90;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100+statusBarAndNavigationBarHeight, Width, tableHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [_tableView registerNib:[UINib nibWithNibName:@"JZNotifictionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NODE_CELL_ID];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    //    _tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.search];
    [self.view addSubview:self.tableView];
}
#pragma mark PopTableListViewDelegate
- (void)clickeIndex:(NSInteger)index {
    [PopView hidenPopView];
    if (index == 0) {//修改密码
        JZForgetPassWordVC *password = [JZForgetPassWordVC shareForgetPassWordVcWithType:0];
        password.type = 1;
        password.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:password animated:YES];
    } else if(index == 3) {//退出登录
        JZTheViewController *loginVC = [[JZTheViewController alloc] initWithNibName:@"JZTheViewController" bundle:[NSBundle mainBundle]];
        [loginVC loginStata:^(BOOL ok) {
            if (ok) {
                [UIApplication sharedApplication].keyWindow.rootViewController = [[JZTabBarController alloc]init];
            }
        }];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
    } else if(index == 1) {//JZShowViewController
        JZShowViewController *show = [[JZShowViewController alloc] init];
        show.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:show animated:YES];
        //        JZMineViewController *mine = [[JZMineViewController alloc] initWithNibName:@"JZMineViewController" bundle:[NSBundle mainBundle]];
        //        [self.navigationController pushViewController:mine animated:YES];
    } else {
        JZMineViewController *mine = [[JZMineViewController alloc] initWithNibName:@"JZMineViewController" bundle:[NSBundle mainBundle]];
        mine.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mine animated:YES];
    }
}
#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchStr = searchBar.text;
    [self makeData];
}
#pragma mark UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segment.selectedSegmentIndex != 1) {
        return @[];
    }
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                               JZShowManModel *model = self.dataList[indexPath.row];
                                              [weakSelf delectProjectWithUid:[NSString stringWithFormat:@"%@",model.userid]];
                                              [tableView setEditing:NO animated:YES];
                                          }];
    return @[deleteAction];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZNotifictionCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    JZShowManModel *model = self.dataList[indexPath.row];
    cell.leftTextLab.text = model.realname;
    cell.rightText.hidden = NO;
    cell.rightText.text = model.rolename;
    cell.pointView.hidden = YES;
    cell.leftWidth.constant = 160;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JZShowManModel *model = self.dataList[indexPath.row];
    JZPersonDetVC *personDet = [[JZPersonDetVC alloc] init];
    personDet.model = model;
    personDet.netModel = self.netModel;
    personDet.showPass = self.segment.selectedSegmentIndex == 1 ? NO : YES;
    personDet.backData = ^(BOOL netOk, id  _Nonnull responseObj) {
        [self makeData];
    };
    personDet.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personDet animated:YES];
}
#pragma mark Actions
- (void)clickeSearchBtn:(UIButton *)btn {
    [self.search.searchView endEditing:YES];
    self.searchStr = self.search.searchView.text;
    [self makeData];
}
- (void)clickeLeftItem:(id)sender {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 60, 40, 40);
    PopView *popView = [PopView popUpContentView:self.popListView direct:PopViewDirection_PopUpBottom onView:btn];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}
- (void)clickRightItem {
    JZCreatProjectVC *project = [JZCreatProjectVC shareProject];
    project.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:project animated:YES];
}
//删除人员
- (void)delectProjectWithUid:(NSString *)uid{
    __weak typeof(self) weakSelf = self;
    [self.netModel deleteUserid:uid backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [weakSelf makeData];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
#pragma mark 懒加载
-(JZRegisterNetModel *)netModel {
    if (_netModel == nil) {
        self.netModel = [JZRegisterNetModel shareRegistNetModel];
    }
    return _netModel;
}
-(NSArray *)dataList {
    if (_dataList == nil) {
        self.dataList = [[NSArray alloc]init];
    }
    return _dataList;
}
- (PopTableListView *)popListView{
    if (_popListView == nil) {
        _popListView = [[PopTableListView alloc] initWithTitles:@[@"修改密码",@"平台统计",@"关于我们",@"退出登录"] imgNames:@[@"",@"",@""]];
        _popListView.backgroundColor = [UIColor darkGrayColor];
        _popListView.delegate = self;
        _popListView.layer.cornerRadius = 5;
    }
    return _popListView;
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
