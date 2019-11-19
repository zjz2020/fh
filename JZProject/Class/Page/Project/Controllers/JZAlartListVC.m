//
//  JZAlartListVC.m
//  JZProject
//  事件警告
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZAlartListVC.h"
#import "JZNotifictionCell.h"
#import "JzHeaderView.h"
#import "JZAlartDetailVC.h"
#import "JZProjectModel.h"
#import "JZAlartViewCell.h"
#import "JZDatePickeView.h"
#import "JZActtionVC.h"
#define NODE_CELL_ID @"JZNotifictionCell_id"
#define ALART_CELL_ID @"ALART_CELL_ID"
#define HEADER_ID @"HEADER_ID"
@interface JZAlartListVC ()<UITableViewDelegate,datePickerDelegate,UITableViewDataSource,JZAlartViewCellDelegate>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)UILabel *headerLabel;
@property(nonatomic,strong)NSArray *listData;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UIButton *calendarBtn;
@property(nonatomic,strong)JZDatePickeView *datePicker;
@property(nonatomic,copy)NSString *searTime;

@end

@implementation JZAlartListVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.searTime = @"";
     [self makeData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionAction) name:notification_alart object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionAction) name:notification_eventwarringId object:nil];
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)notifictionAction {
    self.indexPath = nil;
    [self makeData];
}
- (void)getNotificationEventwarringId:(NSNotification *)notification {
    if (!self.listData || self.listData.count == 0) {
        return;
    }
    for (int i = 0; i < self.listData.count; i ++) {
        JZRecordListModel *model = self.listData[i];
        if (model.recordList.count > 0) {
            for (int j = 0; j < model.recordList.count; j ++) {
                JZEventModel *even = model.recordList[j];
                if ([even.eventId isEqualToString:@"id"]) {
                  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    self.indexPath = indexPath;
                    [self.tableView reloadData];
                    break;
                }
            }
        }
    }
}
- (void)creactUI{
    [self creatTopView];
    [self.view addSubview:self.tableView];
     _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(makeDataWithAlart)];
    [self.tableView registerNib:[UINib nibWithNibName:@"JZAlartViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ALART_CELL_ID];
    [_tableView registerClass:[JZHeaderView class] forHeaderFooterViewReuseIdentifier:HEADER_ID];
     CGFloat tableHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - 120;
    self.tableView.frame = CGRectMake(0, self.topView.y + self.topView.height, Width, tableHeight);
}
- (void)makeDataWithAlart{
    self.searTime = @"";
    [self makeData];
}
- (void)makeData {
    __weak typeof(self) weakSelf = self;
    [self.projectNetModel queryEventWarningWithProjectId:self.projectId time:self.searTime backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (!netOk) {
            [JZTost showTost:responseObj];
        } else {
            weakSelf.listData = responseObj;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
        }
    }];
}
- (void)creatTopView{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarAndNavigationBarHeight-statusBarHeight, Width, 60)];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 60)];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    _timeLabel.text = @"2019年";
    [_topView addSubview:_timeLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(Width - 60, 10, 40, 40);
    [btn setImage:[UIImage imageNamed:@"calendarIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickeCalendarBtn) forControlEvents:UIControlEventTouchUpInside];
    self.calendarBtn = btn;
    [_topView addSubview:self.calendarBtn];
    [self.view addSubview:_topView];
}
#pragma mark JZAlartViewCellDelegate
- (void)clickUpActionBtn:(JZEventModel *)model title:(nonnull NSString *)title{//故障申报
     NSString *conten = @"确定故障申报";
     __weak typeof(self) weakSelf = self;
     UIAlertController *alertC = [self alertWithTitle:@"注意" content:conten okTitle:@"确定" cancelTitle:@"取消" okAction:^{
         [self.faultNetModel createFaultDefendWithFaultid:model.eventId backData:^(BOOL netOk, id  _Nonnull responseObj) {
             if (netOk) {
                 [weakSelf makeDataWithAlart];
                 [JZTost showTost:@"确认成功"];
             } else {
                 [JZTost showTost:responseObj];
             }
         }];
    } cancelAction:^{
        
    }];
      [self presentViewController:alertC animated:YES completion:nil];
}

- (void)clickCancelActionBtn:(JZEventModel *)model title:(nonnull NSString *)title{
     self.indexPath = nil;
    NSString *conten = @"确定忽略此故障?";
     JZActtionVC *actionVc = [JZActtionVC shareActionVC];
    actionVc.faultid = model.eventId;
    __weak typeof(self) weakSelf = self;
    //忽略  确认计划  确认完成  提交计划  维护完成
    if ([title isEqualToString:@"忽略"]) {
        UIAlertController *alertC = [self alertWithTitle:@"注意" content:conten okTitle:@"确定" cancelTitle:@"取消" okAction:^{
            [self.faultNetModel faultCancelWithFaultid:model.eventId backData:^(BOOL netOk, id  _Nonnull responseObj) {
                if (netOk) {
                    [JZTost showTost:@"警告已忽略"];
                    [weakSelf makeDataWithAlart];
                } else {
                    [JZTost showTost:responseObj];
                }
            }];
        } cancelAction:^{
            
        }];
        [self presentViewController:alertC animated:YES completion:nil];
    } else if ([title isEqualToString:@"提交计划"]) {
        actionVc.Showtitle = @"提交计划";
        [self.navigationController pushViewController:actionVc animated:YES];
    } else if ([title isEqualToString:@"确认计划"]) {
        actionVc.Showtitle = @"确认计划";
        actionVc.planText = model.plan;
        [self.navigationController pushViewController:actionVc animated:YES];
    } else if ([title isEqualToString:@"维护完成"]) {
        actionVc.Showtitle = @"维护完成";
        [self.navigationController pushViewController:actionVc animated:YES];
    } else if ([title isEqualToString:@"确认完成"]) {
        actionVc.Showtitle = @"确认完成";
        [self.navigationController pushViewController:actionVc animated:YES];
    }
}
#pragma mark datePickerDelegate
- (void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView{
    NSString *selectDate = [date substringToIndex:8];
    self.timeLabel.text = selectDate;
    self.searTime = [NSString stringWithFormat:@"%@-%@",[date substringToIndex:4],[date substringWithRange:NSMakeRange(5, 2)]];;
    [self makeData];
    [pickerView removeFromSuperview];
}

- (void)datePicerCancel:(JZDatePickeView *)pickerView{
    [pickerView removeFromSuperview];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JZRecordListModel *model = self.listData[section];
    return model.recordList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        JZRecordListModel *model = self.listData[indexPath.section];
        JZEventModel *eventModel = model.recordList[indexPath.row];
        NSArray *btnTitle = [self showBtnWithFaultType:eventModel.status];
        if (btnTitle.count > 0) {
            return 300;
        } else {
            return 240;
        }
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JZHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADER_ID];
    if (!header) {
        header = [[JZHeaderView alloc] initWithReuseIdentifier:HEADER_ID];
        header.frame=CGRectMake(0, 0, Width, 40);
    }
    JZRecordListModel *model = self.listData[section];
    header.leftLabel.text = [NSString stringWithFormat:@"%@月",model.month];
    return header;
}
#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZAlartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ALART_CELL_ID];
    cell.delegate = self;
    JZRecordListModel *model = self.listData[indexPath.section];
    JZEventModel *eventModel = model.recordList[indexPath.row];
    [cell shareCellWithEvenModel:eventModel];
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        NSArray *btnTitle = [self showBtnWithFaultType:eventModel.status];
        if (btnTitle.count == 0) {
            cell.upBtn.hidden = YES;
            cell.cancelBtn.hidden = YES;
        } else if (btnTitle.count == 1) {
            cell.upBtn.hidden = YES;
            [cell.cancelBtn setTitle:btnTitle[0] forState:UIControlStateNormal];
        }
        cell.moreView.hidden = NO;
        if (btnTitle.count > 0) {
            cell.moreViewHeight.constant = 240;
            cell.height = 300;
        } else {
            cell.moreViewHeight.constant = 180;
            cell.height = 240;
        }
    } else {
        cell.moreView.hidden = YES;
        cell.moreViewHeight.constant = 0;
        cell.height = 60;
    }
    return cell;
}
- (NSArray *)showBtnWithFaultType:(NSString *)type {
    if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"1"]) {//甲方  忽略自动报警  确认维护单  确认完成
        if ([type isEqualToString:@"0"]) {//自动报警可以忽略
            return @[@"故障申报",@"忽略"];
        } else if ([type isEqualToString:@"3"]){//同意维护计划
             return @[@"确认计划"];
        } else if ([type isEqualToString:@"5"]) {//确认完成
             return @[@"确认完成"];
        }
    } else if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"3"]){//维护人员 提交维护计划  提交处理结果
        if ([type isEqualToString:@"1"]) {//提交维护计划
            return @[@"提交计划"];
        } else if ([type isEqualToString:@"4"]){//维护人员维护完成
             return @[@"维护完成"];
        }
    }
    return @[];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        self.indexPath = nil;
    } else {
        self.indexPath = indexPath;
    }
    [tableView reloadData];
}
#pragma mark Actions
- (void)clickeLeftItem {
    
}
- (void)clickRightItem {
    
}
- (void)clickeCalendarBtn {
    [[UIApplication sharedApplication].keyWindow addSubview:self.datePicker];
}
#pragma mark 懒加载
-(UITableView *)tableView {
    if (_tableView == nil) {
         self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = GrayColor1;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(UIView *)header {
    if (_header == nil) {
        self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 40)];
        [_header addSubview:self.headerLabel];
        _header.backgroundColor = [UIColor grayColor];
    }
    return _header;
}
-(UILabel *)headerLabel {
    if (_headerLabel == nil) {
        self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, Width, 40)];
    }
    return _headerLabel;
}
-(JZDatePickeView *)datePicker {
    if (_datePicker == nil) {
        self.datePicker = [[JZDatePickeView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _datePicker.isMonth = YES;
        _datePicker.delegate = self;
    }
    return _datePicker;
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
