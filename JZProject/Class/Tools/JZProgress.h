//
//  JZProgress.h
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JZProgress : NSObject
+ (void)show;
+ (void)showWithStatus:(NSString*)string;
+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress status:(NSString*)status;
+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
@end

NS_ASSUME_NONNULL_END
