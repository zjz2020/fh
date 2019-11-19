//
//  JZProjectManView.m
//  JZProject
//
//  Created by zjz on 2019/6/29.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZProjectManView.h"

@implementation JZProjectManView
+ (JZProjectManView *)shareManView{
    JZProjectManView *manView = [[NSBundle mainBundle] loadNibNamed:@"JZProjectManView" owner:self options:nil].firstObject;
    return manView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
