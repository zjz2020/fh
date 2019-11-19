//
//  JZBaseObject.m
//  JZProject
//
//  Created by zjz on 2019/6/30.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZBaseObject.h"

@implementation JZBaseObject
+(JZBaseObject *)shareBaseObj{
    static JZBaseObject *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[JZBaseObject alloc] init];
    });
    return obj;
}
@end
