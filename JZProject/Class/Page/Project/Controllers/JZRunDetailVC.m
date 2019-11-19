//
//  JZRunDetailVC.m
//  JZProject
//
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZRunDetailVC.h"
#import "JzOnePickerView.h"
#import "JZItemModel.h"
#import "JZHistoryModel.h"
#import "JZTost.h"
#import "HXLineChart.h"
@interface JZRunDetailVC ()<onePickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property(nonatomic,strong)JZOnePickerView *onePicke;
@property (weak, nonatomic) IBOutlet UILabel *deviceType;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *cpuLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
//itemid
@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,strong)NSMutableArray *histrArray;
@property(nonatomic,strong)NSMutableArray *xArray;
@property(nonatomic,strong)NSMutableArray *yArray;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,strong)HXLineChart *lineChart;
@end

@implementation JZRunDetailVC
+ (JZRunDetailVC *)shareRunDetail{
    return [[JZRunDetailVC alloc] initWithNibName:@"JZRunDetailVC" bundle:[NSBundle mainBundle]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.histrArray = [NSMutableArray new];
    self.xArray = [NSMutableArray new];
    self.yArray = [NSMutableArray new];
    self.title = @"运行维护";
    [self makeData];
    self.bottomView.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}
- (void)makeData{
    NSDictionary *dic =  @{
        @"output": @"extend",
        @"hostids": self.hostId,
        @"search": @{},
        @"sortfield": @"name"
    };
      __block typeof(self) weakSelf = self;
    [self.netHelp zbGetItemNetWithParameter:dic urlStr:[JZNetWorkHelp shareNetWork].zbip backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            NSMutableArray *testArray = [NSMutableArray new];
            for (NSDictionary *dic in responseObj[@"result"]) {
                JZItemModel *item = [JZItemModel shareItemModeWithData:dic];
                [testArray addObject:item];
            }
            weakSelf.itemArray = testArray;
        }
     
    }];
}

#pragma mark 折线图
- (NSString *)stockWeekDataJsonPath
{
    return [[NSBundle mainBundle] pathForResource:@"week_k_data_60087" ofType:@"json"];
}

- (void)refreshChar{
    [self.lineChart removeFromSuperview];
    [self.xArray removeAllObjects];
    [self.yArray removeAllObjects];
    for (NSInteger i = 0; i < self.histrArray.count; i ++) {
        JZHistoryModel *model = self.histrArray[i];
         [self.yArray addObject:model.value];
        if (i == 0 || self.histrArray.count -1 == i) {
             [self.xArray addObject:model.dclock];
        } else{
            [self.xArray addObject:model.clock];
        }
    }
//    [self.xArray reverseObjectEnumerator];
//    [self.yArray reverseObjectEnumerator];
    HXLineChart *line = [[HXLineChart alloc] initWithFrame:self.showView.bounds];
    self.lineChart = line;
    line.fillColor = [UIColor clearColor];
    line.lineColor = [UIColor redColor];
    //    line.fillColor = [UIColor cyanColor];
    line.backgroundLineColor = [UIColor grayColor];
    line.markTextColor = [UIColor blackColor];
      line.markTextColor = [UIColor blackColor];
    [self.lineChart setTitleArray:self.xArray];
    [self.lineChart setValue:self.yArray withYLineCount:5];
      line.markTextColor = [UIColor blackColor];
    [self.showView addSubview:self.lineChart];
}
#pragma mark btnActon

- (IBAction)btnAction:(UIButton *)sender {
    if (self.itemArray && self.itemArray.count > 0) {
        NSMutableArray *test = [NSMutableArray new];
        for (JZItemModel *model in self.itemArray) {
            [test addObject:model.itemName];
        }
        self.onePicke.dataArray = test;
        [self.view addSubview:self.onePicke];
    }else{
        [JZTost showTost:@"正在获取数据,请稍后重试" view:self.view];
        [self makeData];
    }
}
#pragma mark  onePickerDelegate
- (void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index{
    JZItemModel *item = self.itemArray[index];
    NSDictionary *dic = @{
        @"output": @"extend",
        @"history": @0,
        @"itemids": item.itemId,
        @"sortfield": @"clock",
        @"sortorder": @"DESC",
        @"limit": @60
    };
    [self.histrArray removeAllObjects];
    __block typeof(self) weakSelf = self;
    [self.netHelp zbGetHistoryNetWithParameter:dic urlStr:[JZNetWorkHelp shareNetWork].zbip backData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            for (NSDictionary *dic in responseObj[@"result"]) {
                JZHistoryModel *model = [JZHistoryModel shareHistoryModeWithData:dic];
                [self.histrArray addObject:model];
            }
            [weakSelf refreshChar];
            JZLog(@"%@",responseObj);
        }
    }];
    self.textInput.text = date;
    [self.onePicke removeFromSuperview];
}
- (void)onePicerCancel:(JZOnePickerView *)pickerView{
    [self.onePicke removeFromSuperview];
}
-(JZOnePickerView *)onePicke {
    if (_onePicke == nil) {
        self.onePicke = [[JZOnePickerView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _onePicke.delegate = self;
        _onePicke.font = [UIFont systemFontOfSize:17];
    }
    return _onePicke;
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
