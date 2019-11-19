//
//  JZFirstViewController.m
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZFirstViewController.h"
#import "JZNotifictionCell.h"
#import "JZProjectMainVController.h"
#import "JZTheViewController.h"
#import "JZSearchView.h"
#import "JZCreatProjectVC.h"
#import "JZProjectVC.h"
#import "JZTabBarController.h"
#import "JZProjectNetModel.h"
#import "JZMainProjectModel.h"
#import "JZForgetPassWordVC.h"
#import "UIBarButtonItem+JZBarButtonItem.h"
#import "popView.h"
#import "PopTableListView.h"
#import "JZMineViewController.h"
#import "JZRegisterNetModel.h"
#import "JZShowManModel.h"
#import "JZPersonDetVC.h"
static NSString *NODE_CELL_ID = @"zhuanti_cell_id";
@interface JZFirstViewController ()<UITableViewDelegate,UITableViewDataSource,PopTableListViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JZSearchView *search;
@property(nonatomic,strong)JZProjectNetModel *netModel;
@property(nonatomic,strong)NSArray *dataList;
@property (nonatomic ,strong) PopTableListView *popListView;
@property(nonatomic,copy)NSString *searchStr;
@property(nonatomic,strong)JZRegisterNetModel *registNet;
@end

@implementation JZFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.barTintColor = TopColor;
    self.registNet = [JZRegisterNetModel shareRegistNetModel];
    self.searchStr = @"";
    [self makeButtonItem];
    [self creatTableView];
    [self makeData];
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
- (void)makeButtonItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBtnWithTitle:@"更多" target:self action:@selector(clickeLeftItem:)];
    if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"2"]) {
          self.navigationItem.rightBarButtonItem = [UIBarButtonItem creatBtnWithTitle:@"添加" target:self action:@selector(clickRightItem)];
    }
}
- (void)makeData {
    __weak typeof(self) weakSelf = self;
    [self.netModel queryProjectWithProjectStatus:@"0" content:self.searchStr backData:^(BOOL netOk, id  _Nonnull responseObj) {
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
- (void)creatTableView{
    self.search = [JZSearchView shareSearchBar];
    self.search.searchView.delegate = self;
    self.search.frame = CGRectMake(0, statusBarAndNavigationBarHeight, Width, 60);
    [self.search.searchBtn addTarget:self action:@selector(clickeSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat tableHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - customBottomBarHeight - 40;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60+statusBarAndNavigationBarHeight, Width, tableHeight) style:UITableViewStylePlain];
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
    } else if(index == 2) {//退出登录
        JZTheViewController *loginVC = [[JZTheViewController alloc] initWithNibName:@"JZTheViewController" bundle:[NSBundle mainBundle]];
        [loginVC loginStata:^(BOOL ok) {
            if (ok) {
                [UIApplication sharedApplication].keyWindow.rootViewController = [[JZTabBarController alloc]init];
            }
        }];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
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
    if (![[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"2"]) {
        return @[];
    }
    __weak typeof (self)weakSelf = self;
     JZMainProjectModel *model = self.dataList[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                              [weakSelf delectProjectWithIndex:indexPath.row];
                                              [tableView setEditing:NO animated:YES];
                                          }];
    
    // 创建action
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            [weakSelf editorProjectWithIndex:indexPath.row];
                                            [tableView setEditing:NO animated:YES];
                                        }];
    editAction.backgroundColor = [UIColor greenColor];
    if ([model.projectStatus isEqual:@0]) {
         return @[deleteAction, editAction];
    }
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
    JZMainProjectModel *model = self.dataList[indexPath.row];
    cell.leftTextLab.text = model.projectName;
    if ([model.projectStatus isEqual:@0]) {
         cell.pointView.hidden = YES;
        cell.rightText.hidden = NO;
        cell.rightText.text = [NSString stringWithFormat:@"未激活"];
         cell.leftWidth.constant = 80;
    } else if ([model.projectStatus isEqual:@1]) {
        cell.pointView.hidden = NO;
        cell.pointView.backgroundColor = [UIColor cyanColor];
        cell.rightText.hidden = YES;
        cell.leftWidth.constant = 0;
    } else if ([model.projectStatus isEqual:@2]) {
        cell.pointView.backgroundColor = [UIColor redColor];
        cell.rightText.hidden = NO;
        cell.rightText.text = @"审批拒绝";
        cell.leftWidth.constant = 80;
    } else {//项目关闭
        cell.rightText.hidden = NO;
        cell.rightText.text = @"项目关闭";
        cell.pointView.hidden = YES;
        cell.leftWidth.constant = 80;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JZMainProjectModel *model = self.dataList[indexPath.row];
    JZProjectMainVController *mainVc = [JZProjectMainVController shareMainProject];
    mainVc.projectId = model.projectId;
    mainVc.titleName = model.projectName;
    mainVc.hidesBottomBarWhenPushed = YES;
    self.hidesBottomBarWhenPushed = NO;
//    [self presentViewController:mainVc animated:YES completion:nil];
    [self.navigationController pushViewController:mainVc animated:YES];
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
//编辑项目
- (void)editorProjectWithIndex:(NSInteger)index{//hu
    JZMainProjectModel *model = self.dataList[index];
    JZCreatProjectVC *project = [[JZCreatProjectVC alloc] initWithNibName:@"JZCreatProjectVC" bundle:[NSBundle mainBundle]];
    project.isEdit = YES;
    project.projectId = model.projectId;
    project.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:project animated:YES];
}
//删除项目
- (void)delectProjectWithIndex:(NSInteger)index{
     JZMainProjectModel *model = self.dataList[index];
    __weak typeof(self) weakSelf = self;
    [self.projectNetModel delProjectWithProjectId:model.projectId backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [weakSelf makeData];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
    JZLog(@"删除项目%zd",index);
}
#pragma mark 懒加载
-(JZProjectNetModel *)netModel {
    if (_netModel == nil) {
        self.netModel = [JZProjectNetModel shareProjectNetModel];
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
        _popListView = [[PopTableListView alloc] initWithTitles:@[@"修改密码",@"关于我们",@"退出登录"] imgNames:@[@"",@"",@""]];
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
