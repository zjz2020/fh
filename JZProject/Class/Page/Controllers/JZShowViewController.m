//
//  JZShowViewController.m
//  JZProject
//
//  Created by zjz on 2019/11/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZShowViewController.h"
#import "ShowView.h"
@interface JZShowViewController ()
@property(nonatomic,strong)ShowView *showView1;
@property(nonatomic,strong)ShowView *showView2;
@property(nonatomic,strong)ShowView *showView3;
@end

@implementation JZShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"平台统计";
    // Do any additional setup after loading the view from its nib.
}
- (void)creactUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(Width, 700);
    self.showView1 = [ShowView creatShowView];
    self.showView2 = [ShowView creatShowView];
    self.showView3 = [ShowView creatShowView];
    self.showView2.y = 220;
    self.showView3.y = 440;
    [scrollView addSubview:_showView1];
    [scrollView addSubview:_showView2];
    [scrollView addSubview:_showView3];
    [self.view addSubview:scrollView];
    __weak typeof(self)weakSelf = self;
    [self.baseNetMode platformStatisticsBackData:^(BOOL netOk, id  _Nonnull responseObj) {
        if (netOk) {
            [weakSelf showDataWithDic:responseObj];
        } else {
            [JZTost showTost:responseObj];
        }
    }];
}
- (void)showDataWithDic:(NSDictionary *)dic {
    self.showView1.firstRightL.text = [NSString stringWithFormat:@"%@",dic[@"usersTotals"]];
    self.showView1.secRightL.text = [NSString stringWithFormat:@"%@",dic[@"headersTotals"] ];
    self.showView1.thredRightL.text = [NSString stringWithFormat:@"%@",dic[@"partyasTotals"]];
    self.showView1.forthRightL.text = [NSString stringWithFormat:@"%@",dic[@"servicersTotals"]];
    self.showView1.fiveRightL.text = [NSString stringWithFormat:@"%@",dic[@"unpassTotals"]];
    
    self.showView2.firstLeftL.text = @"项目数量统计";
    self.showView2.secLeftL.text = @"未激活项目";
    self.showView2.thredLeftL.text = @"激活项目";
    self.showView2.forthLeftL.text = @"审核不通过";
    self.showView2.fiveLeftL.text = @"关闭项目";
    self.showView2.firstRightL.hidden = YES;
    self.showView2.secViewTop.constant = 0;
    self.showView2.secRightL.text = [NSString stringWithFormat:@"%@",dic[@"unactiveProjectsTotals"]];
    self.showView2.thredRightL.text = [NSString stringWithFormat:@"%@",dic[@"activeProjectsTotals"]];
    self.showView2.forthRightL.text = [NSString stringWithFormat:@"%@",dic[@"refuseProjectTotals"]];
    self.showView2.fiveRightL.text = [NSString stringWithFormat:@"%@",dic[@"closeProjectTotals"]];
    
    self.showView3.firstLeftL.text = @"故障统计";
    self.showView3.secLeftL.text = @"创建成功";
    self.showView3.thredLeftL.text = @"维护中";
    self.showView3.forthLeftL.text = @"维护完成";
    self.showView3.fiveLeftL.text = @"已修复";
    self.showView3.firstRightL.hidden = YES;
    self.showView3.secViewTop.constant = 0;
    self.showView3.secRightL.text = [NSString stringWithFormat:@"%@",dic[@"createFaultsTotals"]];
    self.showView3.thredRightL.text = [NSString stringWithFormat:@"%@",dic[@"defendFaultsTotals"]];
    self.showView3.forthRightL.text = [NSString stringWithFormat:@"%@",dic[@"finishFaultTotals"]];
    self.showView3.fiveRightL.text = [NSString stringWithFormat:@"%@",dic[@"repairedFaultTotals"]];
    [self.showView1 makeSizeToFit];
    [self.showView2 makeSizeToFit];
    [self.showView3 makeSizeToFit];
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
