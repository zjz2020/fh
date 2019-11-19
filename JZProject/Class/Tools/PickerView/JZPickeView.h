//
//  JZPickeView.h
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressPickerDelegate<NSObject>
@optional
/** 代理方法返回省市区*/
- (void)addressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area;
/** 取消代理方法*/
- (void)addressPickerCancleAction;
@end
@interface JZPickeView : UIView
/** 省 */
@property (nonatomic, copy) NSString *province;
/** 市 */
@property (nonatomic, copy) NSString *city;
/** 区 */
@property (nonatomic, copy) NSString *area;
@property (nonatomic, weak) id<AddressPickerDelegate> delegate;
///默认选中地址
- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;
@end

NS_ASSUME_NONNULL_END
