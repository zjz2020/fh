//
//  JZMainProjectModel.m
//  JZProject
//
//  Created by zjz on 2019/7/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZMainProjectModel.h"

@implementation JZMainProjectModel
+ (JZMainProjectModel *)shareMainModel{
    return [[JZMainProjectModel alloc] init];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"projectname"]) {
        self.projectName = value;
    } else if ([key isEqualToString:@"projectstatus"]) {
        self.projectStatus = value;
    } else if ([key isEqualToString:@"projectid"]) {
        self.projectId = value;
    } else if([key isEqualToString:@"projectcreatetime"]){  // : @"2019-11-11T22:58:49.000+0800"
        NSString *newStr = [NSString stringWithFormat:@"%@",value];
        self.projectcreatetime =  [[[[newStr stringByReplacingOccurrencesOfString:@"T" withString:@"日 "] substringFromIndex:5] substringToIndex:15] stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    } else {
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
