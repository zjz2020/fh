//
//  JZRunViewController.m
//  JZProject
//
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZRunViewController.h"
#import "JZNotifictionCell.h"
#import "JZRunDetailVC.h"
#import "JzOnePickerView.h"
#import "JZHostMode.h"
static NSString *NODE_CELL_ID = @"JZRunViewController_id";
@interface JZRunViewController ()<UITableViewDelegate,UITableViewDataSource,onePickerDelegate>
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UITableView *tableViw;
@property(nonatomic,strong)JZOnePickerView *listPickerView;
@property(nonatomic,strong)NSMutableArray *hostArray;

@end

@implementation JZRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hostArray = [NSMutableArray new];
    __block typeof(self) weakSelf = self;
    [self.netHelp zbGetHostNetWithParameter:@{} urlStr:[JZNetWorkHelp shareNetWork].zbip backData:^(BOOL netOk, id  _Nonnull responseObj) {
        JZLog(@"%@",responseObj);
        NSArray *array = responseObj[@"result"];
        for (NSDictionary *dic in array) {
            [weakSelf.hostArray addObject:[JZHostMode shareHostModeWithData:dic]];
        }
        [weakSelf.tableViw reloadData];
        
        
    }];
    // Do any additional setup after loading the view.
}

- (void)creactUI{
    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeBtn.frame = CGRectMake(20, statusBarAndNavigationBarHeight-statusBarHeight, 200, 50);
    [_typeBtn setTitle:@"设备监控列表" forState:UIControlStateNormal];
    [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [_typeBtn sizeToFit];
    [_typeBtn addTarget:self action:@selector(selectDevicesType:) forControlEvents:UIControlEventTouchUpInside];
    JZLog(@"%f",CGRectGetMaxY(self.typeBtn.frame));
//    CGFloat tabelHeight = Height - customBottomBarHeight - statusBarAndNavigationBarHeight + 15 - 50 - tabbarSafeBottomMargin;
     CGFloat tabelHeight = Height - statusBarAndNavigationBarHeight - tabbarSafeBottomMargin - 60 -50;
    self.tableViw.height = tabelHeight;
    [self.view addSubview:_typeBtn];
    
    [self.view addSubview:_typeBtn];
    [self.view addSubview:self.tableViw];
}
- (void)setSelfViewHeight:(CGFloat)height{
//    JZLog(@"setSelfViewHeight--%f",height);
//    self.tableViw.height = height - 50;
}
- (void)selectDevicesType:(UIButton *)btn{
    JZLog(@"选择类型");
    NSMutableArray *typeArray = [NSMutableArray new];
    for (JZHostMode *model in self.hostArray) {
        [typeArray addObject:model.host_host];
    }
    self.listPickerView.dataArray = typeArray;
    [self.widnow addSubview:self.listPickerView];
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hostArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZNotifictionCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [JZNotifictionCell creatCellWithXIBWithReuseIdentifier:NODE_CELL_ID];
    }
    JZHostMode *model = self.hostArray[indexPath.row];
    cell.leftTextLab.text = model.host_host;
    cell.pointView.hidden = YES;
    cell.rightText.hidden = YES;
    cell.leftWidth.constant = 0;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JZHostMode *model = self.hostArray[indexPath.row];
    JZRunDetailVC *runDetail  = [JZRunDetailVC shareRunDetail];
    runDetail.hostId = model.hostid;
    [self.navigationController pushViewController:runDetail animated:YES];
}

#pragma mark onePickerDelegate
/** 选中*/
-(void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    NSLog(@"%@",date);
    [_typeBtn setTitle:date forState:UIControlStateNormal];
    [_typeBtn sizeToFit];
    [self.listPickerView removeFromSuperview];
}
//取消
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
     [self.listPickerView removeFromSuperview];
}

#pragma mark 懒加载
-(UITableView *)tableViw {
    if (_tableViw == nil) {
        self.tableViw = [[UITableView alloc]initWithFrame:CGRectMake(20, self.typeBtn.bottom, Width - 40, Height/2) style:UITableViewStylePlain];
        _tableViw.delegate = self;
        _tableViw.dataSource = self;
        _tableViw.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableViw;
}
-(JZOnePickerView *)listPickerView {
    if (_listPickerView == nil) {
        self.listPickerView = [[JZOnePickerView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _listPickerView.delegate = self;
        _listPickerView.dataArray = @[@"张三",@"李四",@"王五"];
        _listPickerView.font = [UIFont systemFontOfSize:17];
    }
    return _listPickerView;
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
