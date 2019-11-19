//
//  JZTost.h
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Toast.h>
NS_ASSUME_NONNULL_BEGIN

@interface JZTost : NSObject
+ (void)showTost:(NSString *)tost;
+ (void)showTost:(NSString *)tost view:(UIView *)view;
+ (void)showTost:(NSString *)tost duration:(NSTimeInterval)duration view:(UIView *)view;
+ (void)hiddenTost:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
