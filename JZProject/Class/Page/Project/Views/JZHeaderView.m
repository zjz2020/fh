//
//  JZHeaderView.m
//  JZProject
//
//  Created by zjz on 2019/6/26.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZHeaderView.h"

@implementation JZHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creactUI];
    }
    self.backgroundColor = [UIColor cyanColor];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        [self creactUI];
    }
    return self;
}
- (void)creactUI{
    self.frame = CGRectMake(0, 0, Width, 40);
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, self.height)];
    self.leftLabel.textColor = [UIColor blackColor];
    [self addSubview:_leftLabel];
}
@end
