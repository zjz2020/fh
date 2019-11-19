//
//  UIBarButtonItem+JZBarButtonItem.h
//  JZProject
//
//  Created by zjz on 2019/6/28.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (JZBarButtonItem)
+ (UIBarButtonItem *)creatBtnWithTitle:(NSString *)title target:(nonnull id)target action:(nonnull SEL)action;
+ (UIBarButtonItem *)creatBtnWithImage:(UIImage *)image target:(nonnull id)target action:(nonnull SEL)action;
@end

NS_ASSUME_NONNULL_END
