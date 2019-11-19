//
//  JZAlartListVC.m
//  JZProject
//  事件警告
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZRecordVC.h"
#import "JZMaintenanceCell.h"
#import "JzHeaderView.h"
#import "JZAlartDetailVC.h"
#import "JZProjectModel.h"
#import "JZDatePickeView.h"
#import "JZActtionVC.h"
#define ALART_CELL_ID @"ALART_CELL_ID"
#define HEADER_ID @"HEADER_ID"
@interface JZRecordVC ()<UITableViewDelegate,datePickerDelegate,UITableViewDataSource,JZMaintenanceCellDeleget>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)UILabel *headerLabel;
@property(nonatomic,strong)NSArray *listData;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)JZDatePickeView *datePicker;
@property(nonatomic,strong)UIButton *calendarBtn;
@property(nonatomic,copy)NSString *selectTime;

@end

@implementation JZRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectTime = @"";
    [self makeDataWithRecord];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionAction) name:notification_record object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionAction) name:notification_eventwarringId object:nil];
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)creactUI{
    [self creatTopView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"JZMaintenanceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ALART_CELL_ID];
    [_tableView registerClass:[JZHeaderView class] forHeaderFooterViewReuseIdentifier:HEADER_ID];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(makeData)];
     CGFloat tableHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - 120;
    self.tableView.frame = CGRectMake(0, self.topView.y + self.topView.height, Width, tableHeight);
}
- (void)notifictionAction {
    self.indexPath = nil;
    [self makeDataWithRecord];
}
- (void)getNotificationEventwarringId:(NSNotification *)notification {
    if (!self.listData || self.listData.count == 0) {
        return;
    }
    for (int i = 0; i < self.listData.count; i ++) {
        JZRecordListModel *model = self.listData[i];
        if (model.recordList.count > 0) {
            for (int j = 0; j < model.recordList.count; j ++) {
                JZRecordModel *even = model.recordList[j];
                if ([even.faultid isEqualToString:@"id"]) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    self.indexPath = indexPath;
                    [self.tableView reloadData];
                    break;
                }
            }
        }
    }
}
- (void)makeDataWithRecord {
    __weak typeof(self) weakSelf = self;
    [self.projectNetModel queryEventRecordWithProjectId:self.projectId time:self.selectTime backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (!netOk) {
            [JZTost showTost:responseObj];
        } else {
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.listData = responseObj;
            [weakSelf.tableView reloadData];
        }
    }];
}
- (void)makeData {
    self.selectTime = @"";
    [self makeDataWithRecord];
}
- (void)creatTopView{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarAndNavigationBarHeight-statusBarHeight, Width, 60)];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 60)];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    _timeLabel.text = @"2018年";
    [_topView addSubview:_timeLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(Width - 60, 10, 40, 40);
    [btn setImage:[UIImage imageNamed:@"calendarIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickeCalendarBtn) forControlEvents:UIControlEventTouchUpInside];
    self.calendarBtn = btn;
    [_topView addSubview:self.calendarBtn];
    [self.view addSubview:_topView];
}
#pragma mark datePickerDelegate
- (void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView{
    JZLog(@"%@",date);
    NSString *selectDate = [date substringToIndex:8];
    self.timeLabel.text = selectDate;
    self.selectTime = [NSString stringWithFormat:@"%@-%@",[date substringToIndex:4],[date substringWithRange:NSMakeRange(5, 2)]];
    [self makeDataWithRecord];
    [pickerView removeFromSuperview];
}

- (void)datePicerCancel:(JZDatePickeView *)pickerView{
    [pickerView removeFromSuperview];
}
#pragma mark JZMaintenanceCellDeleget
- (void)clickeSureCompleteWithModel:(JZRecordModel *)recordModel title:(nonnull NSString *)title{//确认完成  维护完成
    JZActtionVC *actionVc = [JZActtionVC shareActionVC];
    actionVc.faultid = recordModel.faultid;
    if ([title isEqualToString:@"确认完成"]) {
        actionVc.Showtitle = @"确认完成";
        [self.navigationController pushViewController:actionVc animated:YES];
    } else if ([title isEqualToString:@"维护完成"]) {
        actionVc.Showtitle = @"维护完成";
        [self.navigationController pushViewController:actionVc animated:YES];
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JZRecordListModel *listModel = self.listData[section];
    return listModel.recordList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        JZRecordListModel *listModel = self.listData[indexPath.section];
        JZRecordModel *model = listModel.recordList[indexPath.row];
        NSArray *titleArray = [self showBtnWithFaultType:model.faultStatus];
        if (titleArray.count > 0) {
            return 480;
        }
        return 440;
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
        header.backgroundColor = [UIColor redColor];
        header.frame=CGRectMake(0, 0, Width, 40);
    }
     JZRecordListModel *listModel = self.listData[section];
     header.leftLabel.text = [NSString stringWithFormat:@"%@月",listModel.month];
    return header;
}
#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZMaintenanceCell *cell = [tableView dequeueReusableCellWithIdentifier:ALART_CELL_ID];
    cell.delegate = self;
    if (self.listData.count >= indexPath.section) {
        JZRecordListModel *listModel = self.listData[indexPath.section];
        JZRecordModel *model = listModel.recordList[indexPath.row];
        [cell showRecodeModel:model];
        if (self.indexPath && [self.indexPath isEqual:indexPath]) {
            NSArray *titleArray = [self showBtnWithFaultType:model.faultStatus];
            if (titleArray.count == 1) {
                [cell.sureBtn setTitle:titleArray[0] forState:UIControlStateNormal];
            } else {
                cell.sureBtn.hidden = YES;
            }
            cell.bottomView.hidden = NO;
            if (titleArray.count > 0) {
                cell.bottomViewHeight.constant = 420-40;
                cell.height = 480-40;
            } else {
                cell.bottomViewHeight.constant = 380-40;
                cell.height = 440-40;
            }
           
        } else {
            cell.bottomView.hidden = YES;
            cell.bottomViewHeight.constant = 0;
            cell.height = 60;
        }
    }
    return cell;
}
- (NSArray *)showBtnWithFaultType:(NSString *)type {
    if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"1"]) {//甲方  忽略自动报警  确认维护单  确认完成
      if ([type isEqualToString:@"5"]) {//确认完成
            return @[@"确认完成"];
        }
    } else if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"3"]){//维护人员 提交维护计划  提交处理结果
       if ([type isEqualToString:@"4"]){//维护人员维护完成
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
- (void)clickeCalendarBtn {
    [[UIApplication sharedApplication].keyWindow addSubview:self.datePicker];
}
- (void)clickeLeftItem {
    
}
- (void)clickRightItem {
    
}

#pragma mark 懒加载
-(UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
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
