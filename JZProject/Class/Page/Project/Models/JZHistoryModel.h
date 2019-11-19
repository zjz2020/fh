//
//  JZHistoryModel.h
//  JZProject
//  zb  historymodel
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZHistoryModel : NSObject
@property(nonatomic,copy)NSString *clock;
@property(nonatomic,copy)NSString *dclock;
@property(nonatomic,copy)NSString *itemid;
@property(nonatomic,copy)NSString *ns;
@property(nonatomic,copy)NSString *value;
+(JZHistoryModel *)shareHistoryModeWithData:(NSDictionary *)data;
+ (NSString *)changeTimeIntervalToString:(NSString *)timeInterval isDetail:(BOOL)isDetail;
@end

NS_ASSUME_NONNULL_END
