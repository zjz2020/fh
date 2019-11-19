//
//  UIView+Extension.h
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
/** UIView的最大X值 */
@property (assign, nonatomic) CGFloat maxX;
/** UIView的最大Y值 */
@property (assign, nonatomic) CGFloat maxY;
+ (instancetype)viewFromXib;
+ (instancetype)viewFirstXib;
@end


@interface CALayer (GGFrame)

@property (nonatomic) CGFloat gg_left;

@property (nonatomic) CGFloat gg_top;

@property (nonatomic) CGFloat gg_right;

@property (nonatomic) CGFloat gg_bottom;

@property (nonatomic) CGFloat gg_width;

@property (nonatomic) CGFloat gg_height;

@property (nonatomic) CGPoint gg_center;

@property (nonatomic) CGFloat gg_centerX;

@property (nonatomic) CGFloat gg_centerY;

@property (nonatomic) CGPoint gg_origin;

@property (nonatomic) CGSize gg_size;

@end
