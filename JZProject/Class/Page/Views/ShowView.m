//
//  ShowView.m
//  JZProject
//
//  Created by zjz on 2019/11/6.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView

+ (ShowView *)creatShowView {
    ShowView *showView = [[NSBundle mainBundle] loadNibNamed:@"ShowView" owner:self options:NULL].firstObject;
    showView.frame = CGRectMake(0, 0, Width, 210);
    return showView;
}
- (void)makeSizeToFit {
    [self.firstLeftL sizeToFit];
    [self.secLeftL sizeToFit];
    [self.thredLeftL sizeToFit];
    [self.forthLeftL sizeToFit];
    [self.fiveLeftL sizeToFit];
    [self.firstRightL sizeToFit];
    [self.secRightL sizeToFit];
    [self.thredRightL sizeToFit];
    [self.forthRightL sizeToFit];
    [self.fiveRightL sizeToFit];
    
//    [self textViewDidChange:self.firstLeftL];
//    [self textViewDidChange:self.firstRightL];
//    [self textViewDidChange:self.secLeftL];
//    [self textViewDidChange:self.secRightL];
//    [self textViewDidChange:self.thredLeftL];
//    [self textViewDidChange:self.thredRightL];
//    [self textViewDidChange:self.forthLeftL];
//    [self textViewDidChange:self.forthRightL];
//    [self textViewDidChange:self.fiveLeftL];
//    [self textViewDidChange:self.fiveRightL];
    self.firstRightL.x = self.firstLeftL.x + self.firstLeftL.width + 10;
    self.secRightL.x = self.secLeftL.x + self.secLeftL.width + 10;
    self.thredRightL.x = self.thredLeftL.x + self.thredLeftL.width + 10;
    self.forthRightL.x = self.forthLeftL.x + self.forthLeftL.width + 10;
    self.fiveRightL.x = self.fiveLeftL.x + self.fiveLeftL.width + 10;
}
-(void)textViewDidChange:(UILabel *)textView{
    NSLog(@"%@",NSStringFromCGRect(textView.frame));
    CGFloat width = [ShowView getLabelHeightWithText:textView.text height:21 fone:textView.font];
    textView.width = width;
    NSLog(@"==%f",width);
    textView.frame = CGRectMake(textView.x, textView.y, width, 21);
    NSLog(@"%@",NSStringFromCGRect(textView.frame));
}
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text height:(CGFloat)height fone: (UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size.width;
}
@end
