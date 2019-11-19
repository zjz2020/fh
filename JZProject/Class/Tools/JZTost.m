//
//  JZTost.m
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZTost.h"

@implementation JZTost
+ (void)showTost:(NSString *)tost{
    [[UIApplication sharedApplication].keyWindow makeToast:tost duration:2.0 position:CSToastPositionCenter style:nil];
}
+ (void)showTost:(NSString *)tost view:(UIView *)view{
    [view makeToast:tost];
}
+ (void)showTost:(NSString *)tost duration:(NSTimeInterval)duration view:(UIView *)view{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    [view makeToast:tost duration:duration position:CSToastPositionCenter style:style];
}
+ (void)hiddenTost:(UIView *)view{
    [view hideAllToasts];
}
@end
