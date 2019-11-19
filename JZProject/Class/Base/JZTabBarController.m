//
//  JZTabBarController.m
//  JZProject
//
//  Created by zjz on 2019/6/21.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZTabBarController.h"
#import "JZFirstViewController.h"
#import "JZSecondViewController.h"
#import "JZBaseNavigationController.h"
#import "JZTheViewController.h"
#import "JZPersonViewController.h"
#import "JZSuperProjectVC.h"
@interface JZTabBarController ()

@end

@implementation JZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    JZTheViewController *first = [[JZTheViewController alloc] initWithNibName:@"JZTheViewController" bundle:[NSBundle mainBundle]];
    JZFirstViewController *first = [[JZFirstViewController alloc] init];
    JZSecondViewController *second = [[JZSecondViewController alloc] init];
    JZPersonViewController *person = [[JZPersonViewController alloc] init];
    JZSuperProjectVC *superProject = [[JZSuperProjectVC alloc] init];
    if ([[JZNetWorkHelp shareNetWork].roleId isEqualToString:@"4"]) {
          [self setupChildViewController:@"项目" viewController:superProject image:@"menu_activity_normal" selectedImage:@"menu_activity_selected"];
         [self setupChildViewController:@"人员管理" viewController:person image:@"menu_activity_normal" selectedImage:@"menu_activity_selected"];
    } else {
         [self setupChildViewController:@"项目" viewController:first image:@"menu_activity_normal" selectedImage:@"menu_activity_selected"];
    }
   
    
     [self setupChildViewController:@"通知" viewController:second image:@"menu_home_normal" selectedImage:@"menu_home_selected"];
    // Do any additional setup after loading the view.
}
- (void)setupChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item.title = title;
    controller.tabBarItem = item;
    controller.title = title;
    JZBaseNavigationController *naController = [[JZBaseNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:naController];
}

@end
