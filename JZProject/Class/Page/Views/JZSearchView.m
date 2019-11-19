//
//  JZSearchView.m
//  JZProject
//
//  Created by zjz on 2019/6/27.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZSearchView.h"

@implementation JZSearchView

+ (JZSearchView *)shareSearchBar{
    JZSearchView *view = [[NSBundle mainBundle] loadNibNamed:@"JZSearchView" owner:nil options:nil].firstObject;
    view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    view.searchBtn.layer.masksToBounds = true;
    view.searchBtn.layer.cornerRadius = 3;
    view.frame = CGRectMake(0, 0, Width, 60);
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
