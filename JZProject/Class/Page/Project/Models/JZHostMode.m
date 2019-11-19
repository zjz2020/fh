//
//  JZHostMode.m
//  JZProject
//
//  Created by zjz on 2019/7/3.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZHostMode.h"

@implementation JZHostMode
+ (JZHostMode *)shareHostModeWithData:(NSDictionary *)data{
    JZHostMode *model = [[JZHostMode alloc] init];
    for (NSString *key in data.allKeys) {
        if ([key isEqualToString:@"host"]) {
            model.host_host = data[key];
        }
        if ([key isEqualToString:@"hostid"]) {
            model.hostid = data[key];
        }
        if ([key isEqualToString:@"description"]) {
            model.host_description = data[key];
        }
    }
    
    return model;
    /*
     @property(nonatomic,copy)NSString *hostid;
     @property(nonatomic,copy)NSString *host_description;
     @property(nonatomic,copy)NSString *host_host;
     */
}
@end
