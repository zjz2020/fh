//
//  JZItemModel.h
//  JZProject
//  zbItem
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZItemModel : NSObject
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *itemDescription;
@property(nonatomic,copy)NSString *hostId;
@property(nonatomic,copy)NSString *history;
@property(nonatomic,copy)NSString *itemName;
+(JZItemModel *)shareItemModeWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
