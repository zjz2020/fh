//
//  JZForgetPassWordVC.h
//  JZProject
//
//  Created by zjz on 2019/7/24.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZForgetPassWordVC : JZBaseViewController
+ (JZForgetPassWordVC *)shareForgetPassWordVcWithType:(NSInteger)type;
/// 类型  0.忘记密码   1.z修改密码
@property(nonatomic,assign)NSInteger type;
@end

NS_ASSUME_NONNULL_END
