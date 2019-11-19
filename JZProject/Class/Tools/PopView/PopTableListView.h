//
//  PopTableListView.h
//  PopView
//
//  Created by 李林 on 2018/2/28.
//  Copyright © 2018年 李林. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopTableListViewDelegate<NSObject>
@optional
/** 选择按钮*/
- (void)clickeIndex:(NSInteger)index;
@end
@interface PopTableListView : UIView
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames;
@property(nonatomic,weak)id<PopTableListViewDelegate> delegate;
@end
