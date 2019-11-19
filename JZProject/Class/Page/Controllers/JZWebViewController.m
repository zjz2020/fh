//
//  JZWebViewController.m
//  JZProject
//
//  Created by zjz on 2019/11/16.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZWebViewController.h"
#import <WebKit/WebKit.h>
@interface JZWebViewController ()
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation JZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (void)creactUI {
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.height = self.view.height - 50;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    [self.view addSubview:self.webView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.frame= CGRectMake(0, self.webView.bottom, Width, 50);
    [btn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
}
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
