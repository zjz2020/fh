//
//  JZTheViewController.h
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseViewController.h"
typedef void(^login) (BOOL ok);
NS_ASSUME_NONNULL_BEGIN

@interface JZTheViewController : JZBaseViewController
- (void)loginStata:(login)callback;
@end

NS_ASSUME_NONNULL_END
