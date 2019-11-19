//
//  JZDatePickeView.h
//  JZProject
//
//  Created by zjz on 2019/7/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JZDatePickeView;
@protocol datePickerDelegate <NSObject>
@optional
/** 选中*/
-(void)datePickerSelectData:(NSString *)date pickerView:(JZDatePickeView *)pickerView;
//取消
- (void)datePicerCancel:(JZDatePickeView *)pickerView;
@end
@interface JZDatePickeView : UIView
@property (nonatomic, weak) id<datePickerDelegate> delegate;
@property(nonatomic,assign)BOOL isMonth;
@end

NS_ASSUME_NONNULL_END
