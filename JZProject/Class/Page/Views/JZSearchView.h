//
//  JZSearchView.h
//  JZProject
//
//  Created by zjz on 2019/6/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZSearchView : UIView
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
+ (JZSearchView *)shareSearchBar;
@end

NS_ASSUME_NONNULL_END
