//
//  JZHostMode.h
//  JZProject
//  zbHost
//  Created by zjz on 2019/7/3.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZHostMode : NSObject
@property(nonatomic,copy)NSString *hostid;
@property(nonatomic,copy)NSString *host_description;
@property(nonatomic,copy)NSString *host_host;
+(JZHostMode *)shareHostModeWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
