//
//  AppDelegate+JZShowMain.m
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "AppDelegate+JZShowMain.h"
#import "JZTabBarController.h"
#import "JZTheViewController.h"
@implementation AppDelegate (JZShowMain)
- (void)showKeyWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self showMainTabBarController];
}
- (void)showMainTabBarController{
    JZTheViewController *loginVC = [[JZTheViewController alloc] initWithNibName:@"JZTheViewController" bundle:[NSBundle mainBundle]];
    [loginVC loginStata:^(BOOL ok) {
         self.window.rootViewController = [[JZTabBarController alloc]init];
    }];
    self.window.rootViewController = loginVC;
   
}
@end
