//
//  JZOnePickerView.h
//  JZProject
//
//  Created by zjz on 2019/6/23.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JZOnePickerView;
@protocol onePickerDelegate <NSObject>
@optional
/** 选中*/
-(void)onePickerSelectData:(NSString *)date pickerView:(JZOnePickerView *)pickerView index:(NSInteger)index;
//取消
- (void)onePicerCancel:(JZOnePickerView *)pickerView;
@end
@interface JZOnePickerView : UIView
///传入数据
@property(nonatomic,strong)NSArray *dataArray;
///字体大小
@property(nonatomic,strong)UIFont *font;
@property (nonatomic, weak) id<onePickerDelegate> delegate;
///默认选中的值
- (void)onePickerSelectData:(NSString *)data;
@end

NS_ASSUME_NONNULL_END
