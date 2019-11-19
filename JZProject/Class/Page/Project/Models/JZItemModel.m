//
//  JZItemModel.m
//  JZProject
//  zbitem model
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZItemModel.h"

@implementation JZItemModel
+ (JZItemModel *)shareItemModeWithData:(NSDictionary *)data{
    JZItemModel *model = [[JZItemModel alloc] init];
    for (NSString *key in data.allKeys) {
        if ([key isEqualToString:@"hostid"]) {
            model.hostId = data[key];
        }
        if ([key isEqualToString:@"itemid"]) {
            model.itemId = data[key];
        }
        if ([key isEqualToString:@"description"]) {
            model.itemDescription = data[key];
        }
        if ([key isEqualToString:@"history"]) {
            model.history = data[key];
        }
        if ([key isEqualToString:@"name"]) {
            model.itemName = data[key];
        }
    }
    return model;
}
@end
