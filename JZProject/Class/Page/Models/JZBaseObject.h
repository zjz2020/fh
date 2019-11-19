//
//  JZBaseObject.h
//  JZProject
//
//  Created by zjz on 2019/6/30.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZBaseObject : NSObject
+(JZBaseObject *)shareBaseObj;
@property(nonatomic,copy)NSString *token;
@end

NS_ASSUME_NONNULL_END
