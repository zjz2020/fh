//
//  JZMineViewController.m
//  JZProject
//  关于孕期
//  Created by zjz on 2019/9/10.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZMineViewController.h"

@interface JZMineViewController ()
@property (weak, nonatomic) IBOutlet UIView *lowView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *systemNoL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UIView *lowView2;

@end

@implementation JZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于云桥";
    self.lowView.backgroundColor = GrayColor1;
    self.lowView2.backgroundColor = GrayColor1;
    // Do any additional setup after loading the view from its nib.
}
- (void)creactUI {
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 60;
    self.nameL.text = [JZNetWorkHelp shareNetWork].userName;
    self.phoneL.text = [JZNetWorkHelp shareNetWork].phone;
    self.systemNoL.text = [NSString stringWithFormat:@"%@%@",@"云桥",[self getLocalVersion]];
}
- (NSString*) getLocalVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //当前版本号
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return currentVersion;
}
//{
//    NSString *currentVersion = [self getLocalVersion];
//    NSArray *currentArray = [currentVersion componentsSeparatedByString:@"."];
//    NSArray *appStroArray = [version componentsSeparatedByString:@"."];
//    BOOL refresh = NO;
//    NSInteger num = currentArray.count >= appStroArray.count ? appStroArray.count : currentArray.count;
//    for (NSInteger i = 0; i < num; i ++) {
//        if ([appStroArray[i] integerValue] > [currentArray[i] integerValue]) {
//            refresh = YES;
//            break;
//        }else if ([appStroArray[i] integerValue] < [currentArray[i] integerValue]){
//            refresh = NO;
//            break;
//        }
//    }
//    //  NSDictionary *result = @{@"ver" : currentVersion};
//
//
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:note preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (force) {
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];
//        }
//        //    NSLog(@"点击了按钮1，进入按钮1的事件");
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadUrl] options:@{} completionHandler:nil];
//    }];
//    UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        //    callback(@[@(1),@"fsf"]);
//    }];
//
//    //把action添加到actionSheet里
//    [actionSheet addAction:ok];
//    if (!force) {//
//        [actionSheet addAction:cacel];
//    }
//
//    //相当于之前的[actionSheet show];
//    if (refresh) {
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];
//    } else {
//        callback(@[@"0",@"当前为最新版本"]);
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
