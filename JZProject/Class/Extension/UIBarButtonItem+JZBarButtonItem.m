//
//  UIBarButtonItem+JZBarButtonItem.m
//  JZProject
//
//  Created by zjz on 2019/6/28.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "UIBarButtonItem+JZBarButtonItem.h"

@implementation UIBarButtonItem (JZBarButtonItem)
+ (UIBarButtonItem *)creatBtnWithTitle:(NSString *)title target:(nonnull id)target action:(nonnull SEL)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
+ (UIBarButtonItem *)creatBtnWithImage:(UIImage *)image target:(nonnull id)target action:(nonnull SEL)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
@end
