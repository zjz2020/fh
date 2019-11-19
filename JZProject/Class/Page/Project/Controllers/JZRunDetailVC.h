//
//  JZRunDetailVC.h
//  JZProject
//
//  Created by zjz on 2019/6/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface JZRunDetailVC : JZBaseViewController
+ (JZRunDetailVC *)shareRunDetail;
@property(nonatomic,assign)CGFloat contentHeight;
@property(nonatomic,copy)NSString *hostId;
@end

NS_ASSUME_NONNULL_END
