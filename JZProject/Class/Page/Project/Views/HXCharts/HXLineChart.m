//
//  HXLineChart.m
//  移动运维
//
//  Created by 韩旭 on 2017/8/23.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "HXLineChart.h"
@interface HXLineChart()

@property(nonatomic,strong)NSArray* colors;
@property(nonatomic,assign)BOOL pathCurve;

@property (nonatomic, strong) CAShapeLayer *colorLayer;
@property (nonatomic, strong) CAShapeLayer *fillLayer;

@property (nonatomic, assign) CGFloat margin;
@property(nonatomic,assign)CGFloat scroll_x;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) int titleCount;
@property (nonatomic, assign) int valueCount;
@property (nonatomic, assign) CGFloat maxChar;
@property (nonatomic, assign) CGFloat minChar;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValueLength;
@property (nonatomic, assign) int minValueLength;

@property (nonatomic, strong) NSMutableArray *markLabelArray;
@property (nonatomic, strong) NSMutableArray *lineLayerArray;

@property (nonatomic, copy) NSString *direction;
@property (nonatomic, assign) CGFloat average;
@property (nonatomic, assign) int minYCount;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation HXLineChart

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self drawLine];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (titleArray.count > 5) {
        _lineWidth = 2 *_margin *titleArray.count;
        self.lineView.width = _lineWidth + _x;
        
    }
    if (titleArray.count == 0) {
        return;
    }
    
    _titleCount = (int)titleArray.count;
    
    CAShapeLayer *lineLayer= [self creatCAShapeLayer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < titleArray.count; i++) {//纵轴
        [linePath moveToPoint:CGPointMake(_x + 2*_margin * i, -20)];
        [linePath addLineToPoint:CGPointMake(_x + 2*_margin * i, _lineHeight)];
    }
    
    lineLayer.path = linePath.CGPath;
    [self.lineView.layer addSublayer:lineLayer];
    
    _titleHeight = _margin *1.5;
    _titleWidth = (_lineWidth / titleArray.count);
    
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_lineWidth - _margin * 2) / (titleArray.count - 1) * i - _titleWidth / 2, _lineHeight, _titleWidth, _titleHeight)];
        [self.scrollView addSubview:titleLabel];
        [self.markLabelArray addObject:titleLabel];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.text = titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            titleLabel.x = 0;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
}


- (void)setValue:(NSArray *)valueArray withYLineCount:(int)count{
    
    if (valueArray.count > 5) {
        _lineWidth = 2 *_margin *valueArray.count;
        self.scrollView.contentSize = CGSizeMake(_lineWidth + _x, self.scrollView.height);
        self.lineView.width = _lineWidth + _x;
        
    }
    
    
    if (valueArray.count == 0) {
        return;
    }
    
    _valueCount = count;

    ///最大值
    int maxValueAtArray = [[valueArray valueForKeyPath:@"@max.intValue"] intValue];
    int minValueAtArray = [[valueArray valueForKeyPath:@"@min.intValue"] intValue];
    
    if (maxValueAtArray == 0 && minValueAtArray == 0) {
//        return;
    }
    if (maxValueAtArray<=0) {
        maxValueAtArray = 0;
    } else{
    [self maxValue:maxValueAtArray];
    _maxValue = _maxChar + 1;
    for (int i = 0; i < _maxValueLength - 1; i++) {
        _maxValue = _maxValue * 10;
    }
        if (maxValueAtArray == 0) {
            maxValueAtArray = count;
        } else{
             _maxValue = maxValueAtArray + maxValueAtArray/count;
        }
       
}
    
    NSLog(@"-------%d",_maxValue);
    ///最小值
    if (minValueAtArray >= 0) {
        minValueAtArray = 0;
    } else{
        [self minValue:minValueAtArray];
        _minValue = _minChar - 1;
        for (int i = 0; i < _minValueLength - 1; i++) {
        _minValue = _minValue * 10;
        }
     
        if (_maxValue > abs(_minValue)) {
            _direction = @"top";
            _average = _maxValue / 5;
            _minYCount = 0;
            for (int i = 1; i < 6; i ++) {
                if (_average * i >= abs(minValueAtArray)) {
                    _minYCount = i;
                    break;
                }
            }
        } else if (_maxValue < abs(_minValue)){
            _direction = @"down";
            _average = abs(_minValue) / 5;
            _minYCount = 0;
            for (int i = 1; i < 6; i ++) {
                if (_average * i >= maxValueAtArray) {
                    _minYCount = i;
                    break;
                }
            }

        } else{
            _direction = @"middle";
            _average = _maxValue / 5;
            _minYCount = 5;
        }
        
        count = 5 + 1 + _minYCount;
    }
    
    NSLog(@"max:%d-----min:%d------%f",_maxValue,_minValue,_average);
    
    CAShapeLayer *lineLayer= [self creatCAShapeLayer];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 1; i < count - 1; i++) {//横轴
        [linePath moveToPoint:CGPointMake(_x , _lineHeight / (count - 1) * i)];
        [linePath addLineToPoint:CGPointMake(_x + _lineWidth,_lineHeight / (count - 1) * i)];
    }
    
    lineLayer.path = linePath.CGPath;
    [self.lineView.layer addSublayer:lineLayer];
    
    CGFloat valueHeight = 20;
    CGFloat valueWidth = _scroll_x - 10;
    
    for (int i = 0; i < count; i++) {
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * (_lineHeight / (count - 1)) - valueHeight / 2, valueWidth, valueHeight)];
        [self addSubview:valueLabel];
        [self.markLabelArray addObject:valueLabel];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.textAlignment = NSTextAlignmentRight;
        
        NSString *maxText = [NSString string];
        NSString *minText = [NSString string];
        NSString *floatText = [NSString string];
        NSString *intText = [NSString string];
        int intNum = 0;
        int value = 0;
        
        if (_minValue >=0) {
            maxText = [NSString stringWithFormat:@"%d",_maxValue];
            minText = [NSString stringWithFormat:@"%d",_minValue];
            floatText = [NSString stringWithFormat:@"%.1f",(float)_maxValue / (count - 1) * (count - 1 - i)];
            intText = [NSString stringWithFormat:@"%d",_maxValue / (count - 1) * (count - 1 - i)];
            value = _maxValue;
            intNum = (count - 1);
        } else{
            if ([_direction isEqualToString:@"top"]) {
                maxText = [NSString stringWithFormat:@"%d",_maxValue];
                minText = [NSString stringWithFormat:@"%d",-(int)_average * _minYCount];
                value = _maxValue;
                floatText = [NSString stringWithFormat:@"%f",_maxValue - i * _average];
                intText = [NSString stringWithFormat:@"%d",_maxValue - i * (int)_average];
            } else if([_direction isEqualToString:@"down"]){
                maxText = [NSString stringWithFormat:@"%d",(int)_average * _minYCount];
                minText = [NSString stringWithFormat:@"%d",_minValue];
                value = abs(_minValue);
                floatText = [NSString stringWithFormat:@"%f",_average * _minYCount - i * _average];
                intText = [NSString stringWithFormat:@"%d",(int)_average * _minYCount - i * (int)_average];
            } else{
                maxText = [NSString stringWithFormat:@"%d",_maxValue];
                minText = [NSString stringWithFormat:@"%d",_minValue];
                value = _maxValue;
                floatText = [NSString stringWithFormat:@"%f",_maxValue - i * _average];
                intText = [NSString stringWithFormat:@"%d",_maxValue - i * (int)_average];
            }
            intNum = 5;
        }
        
        if (i == 0) {
            valueLabel.text = maxText;
        } else if(i == count - 1){
            valueLabel.text = minText;
        } else{
            if (value < intNum) {
                valueLabel.text = floatText;
            } else{
                valueLabel.text = intText;
            }
        }
    }
    
    ///折线图
    CAShapeLayer *lineChartLayer = [CAShapeLayer layer];
    _colorLayer = lineChartLayer;
    lineChartLayer.fillColor= [UIColor clearColor].CGColor;
    lineChartLayer.strokeColor = [UIColor redColor].CGColor;
    lineChartLayer.lineWidth = 2;

    CAShapeLayer *fillChartLayer = [CAShapeLayer layer];
    _fillLayer = fillChartLayer;
    fillChartLayer.fillColor= fillChartLayer.strokeColor = [UIColor clearColor].CGColor;
    fillChartLayer.strokeColor = [UIColor clearColor].CGColor;
    fillChartLayer.lineWidth = 1;

    UIBezierPath *lPath = [UIBezierPath bezierPath];
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (maxValueAtArray == 0) {
         [path moveToPoint:CGPointMake(_x, _lineHeight/2)];
        [path addLineToPoint:CGPointMake(_lineWidth, _lineHeight/2)];
        [lPath moveToPoint:CGPointMake(_x, _lineHeight/2)];
        [lPath addLineToPoint:CGPointMake(_x, _lineHeight/2)];
    }
    if (_minValue >=0) {
        [path moveToPoint:CGPointMake(_x, _lineHeight - _lineHeight * ([valueArray[0] floatValue] / _maxValue))];
        [lPath moveToPoint:CGPointMake(_x, _lineHeight - _lineHeight * ([valueArray[0] floatValue] / _maxValue))];
        [lPath addLineToPoint:CGPointMake(_x, _lineHeight - _lineHeight * ([valueArray[0] floatValue] / _maxValue))];
        [path addLineToPoint:CGPointMake(_x, _lineHeight - _lineHeight * ([valueArray[0] floatValue] / _maxValue))];

    for (int i = 0; i < valueArray.count ; i++) {
        CGFloat x = _x + (_lineWidth - _margin * 2) / (_titleCount - 1) * i;
        CGFloat y = _lineHeight - _lineHeight * [valueArray[i] floatValue] / _maxValue;
        if (maxValueAtArray == 0) {
            y = _lineHeight/2;
            x = 2 *_margin *i;
        }
        CAShapeLayer *pointLayer = [self creatPointLayerWithPoint:CGPointMake(x, y)];
        [self.lineView.layer addSublayer:pointLayer];
        [lPath addLineToPoint:CGPointMake(x,y)];
        [path addLineToPoint:CGPointMake(x,y)];

        if (i == valueArray.count - 1) {
            [lPath addLineToPoint:CGPointMake(_lineWidth-_margin*2,_lineHeight - _lineHeight * [valueArray[i] floatValue] / _maxValue)];
            [path addLineToPoint:CGPointMake(_lineWidth-_margin*2,_lineHeight - _lineHeight * [valueArray[i] floatValue] / _maxValue)];
            [path addLineToPoint:CGPointMake(_lineWidth-_margin*2,_lineHeight)];
            [path addLineToPoint:CGPointMake(_x,_lineHeight)];
            [path moveToPoint:CGPointMake(_x, _lineHeight - _lineHeight * ([valueArray[0] floatValue] / _maxValue))];
        }
}
    } else{
        int largerValue = 0;
        
        if ([_direction isEqualToString:@"down"]) {
            largerValue = _minValue;
        } else {
            largerValue = _maxValue;
        }
        CGFloat numerator;
        CGFloat denominator = abs(largerValue) + _average * _minYCount;
        
            if ([_direction isEqualToString:@"top"]) {
            numerator = denominator - _average * _minYCount - [valueArray[0] floatValue];
            } else{
            numerator = _average * _minYCount - [valueArray[0] floatValue];
            }
        
        [path moveToPoint:CGPointMake(_x, _lineHeight * (numerator / denominator))];
        
        [lPath moveToPoint:CGPointMake(_x,_lineHeight * (numerator / denominator))];
        [lPath addLineToPoint:CGPointMake(_x + _margin,_lineHeight * (numerator / denominator))];

        [path addLineToPoint:CGPointMake(_x + _margin,_lineHeight * (numerator / denominator))];
        
            for (int i = 1; i < valueArray.count ; i++) {

                    if ([_direction isEqualToString:@"top"]) {
                        numerator = denominator - _average * _minYCount - [valueArray[i] floatValue];
                    } else{
                        numerator = _average * _minYCount - [valueArray[i] floatValue];
                    }

                [lPath addLineToPoint:CGPointMake(_x + _margin + (_lineWidth - _margin * 2) / (_titleCount - 1) * i,_lineHeight * (numerator / denominator))];

                [path addLineToPoint:CGPointMake(_x + _margin + (_lineWidth - _margin * 2) / (_titleCount - 1) * i,_lineHeight * (numerator / denominator))];

                if (i == valueArray.count - 1) {
                    [lPath addLineToPoint:CGPointMake(_width,_lineHeight * (numerator / denominator))];
                    [path addLineToPoint:CGPointMake(_width,_lineHeight * (numerator / denominator))];
                    [path addLineToPoint:CGPointMake(_width,_lineHeight)];
                    [path addLineToPoint:CGPointMake(_x,_lineHeight)];
                    [path moveToPoint:CGPointMake(_x, _lineHeight * (numerator / denominator))];
                }
            }
    }

    lineChartLayer.path = lPath.CGPath;
    [self.lineView.layer addSublayer:lineChartLayer];
    fillChartLayer.path = path.CGPath;


    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [lineChartLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lineView.layer addSublayer:fillChartLayer];
    });
}


-(void)drawLine{
    CAShapeLayer *lineLayer= [self creatCAShapeLayer];
    [self.lineLayerArray addObject:lineLayer];

    _margin = 20.0;
    _x = 0;
    _scroll_x = 40;
    _height = self.frame.size.height;
    _width = self.frame.size.width;
    _lineWidth = _width - _scroll_x;
    _lineHeight = _height-_scroll_x;

    //滚动视图
    self.scrollView.frame = CGRectMake(_scroll_x, 0, _lineWidth, _lineHeight +1.5*_margin);
    _scrollView.contentSize = CGSizeMake(_lineWidth, _lineHeight);
    self.lineView = [[UIView alloc] initWithFrame:self.scrollView.bounds];
    [_scrollView addSubview:_lineView];
    [self addSubview:_scrollView];
    //参照线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0,0)];
    [linePath addLineToPoint:CGPointMake(10000000,0)];
    [linePath moveToPoint:CGPointMake(10000000,_lineHeight)];
    [linePath addLineToPoint:CGPointMake(0,_lineHeight)];
    lineLayer.path = linePath.CGPath;
    [self.lineView.layer addSublayer:lineLayer];
}

- (CAShapeLayer *)creatCAShapeLayer{
    CAShapeLayer *lineLayer= [CAShapeLayer layer];
    [self.lineLayerArray addObject:lineLayer];
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 1.0f;
    lineLayer.strokeColor = [UIColor grayColor].CGColor;
    
    return lineLayer;
}
- (CAShapeLayer *)creatPointLayerWithPoint:(CGPoint)point{
    CGFloat rad = 3;
    CGPoint pointA =CGPointMake(point.x,point.y -rad);
    CGPoint pointB =CGPointMake(point.x + rad,point.y);
    CGPoint pointC =CGPointMake(point.x,point.y + rad);
    CGPoint pointD =CGPointMake(point.x - rad,point.y);
    CGFloat offset =rad *2/3.6;
    CGPoint pointA1 =CGPointMake(pointA.x+ offset, pointA.y);
    CGPoint pointA2 =CGPointMake(pointB.x, pointA.y+offset);
    CGPoint pointB1 =CGPointMake(pointB.x, pointB.y+ offset);
    CGPoint pointB2 =CGPointMake(pointC.x+ offset, pointC.y);
    CGPoint pointC1 =CGPointMake(pointC.x- offset, pointC.y);
    CGPoint pointC2 =CGPointMake(pointD.x, pointD.y+offset);
    CGPoint pointD1 =CGPointMake(pointD.x, pointD.y- offset);
    CGPoint pointD2 =CGPointMake(pointD.x+ offset, pointA.y);
    UIBezierPath *circlePath= [UIBezierPath bezierPath];
    [circlePath moveToPoint:pointA];
    [circlePath addCurveToPoint:pointB controlPoint1:pointA1 controlPoint2:pointA2];
    [circlePath addCurveToPoint:pointC controlPoint1:pointB1 controlPoint2:pointB2];
    [circlePath addCurveToPoint:pointD controlPoint1:pointC1 controlPoint2:pointC2];
    [circlePath addCurveToPoint:pointA controlPoint1:pointD1 controlPoint2:pointD2];
    CAShapeLayer * circleLayer= [CAShapeLayer layer];
    circleLayer.lineWidth=10;
    circleLayer.fillColor= [UIColor redColor].CGColor;
    circleLayer.path=circlePath.CGPath;
    [self.layer addSublayer:circleLayer];
    return circleLayer;
}
- (void)maxValue:(int)value{
    _maxValueLength ++;
    
    if (value < 10) {
        _maxChar = value;
        return;
    }
    
    int v = value / 10;
    [self maxValue:v];
}

- (void)minValue:(int)value{
    _minValueLength ++;
    
    if (value > - 10) {
        _minChar = value;
        return;
    }
    
    int v = value / 10;
    [self minValue:v];
}


- (void)maxValueCompareMinValue:(int)value{
    if (value - value / (value + fabs(_minChar)) == 0) {
        _maxValue = value;
        return;
    }
    _maxChar ++;
    _maxValue = _maxChar;
    for (int i = 0; i < _maxValueLength - 1; i++) {
        _maxValue = _maxValue * 10;
    }
    [self maxValueCompareMinValue:_maxValue];
}


- (void)setMarkTextFont:(UIFont *)markTextFont{
    for (UILabel *label in _markLabelArray) {
        label.font = markTextFont;
    }
}

- (void)setMarkTextColor:(UIColor *)markTextColor{
    for (UILabel *label in _markLabelArray) {
        label.textColor = markTextColor;
    }
}

- (void)setLineColor:(UIColor *)lineColor{
    _colorLayer.strokeColor = lineColor.CGColor;
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillLayer.fillColor = fillColor.CGColor;
}

-(void)setBackgroundLineColor:(UIColor *)backgroundLineColor{
    for (CAShapeLayer *layer in _lineLayerArray) {
        layer.strokeColor = backgroundLineColor.CGColor;
    }
}

- (NSMutableArray *)markLabelArray{
    if (!_markLabelArray) {
        _markLabelArray = [NSMutableArray array];
    }
    return _markLabelArray;
}

- (NSMutableArray *)lineLayerArray{
    if (!_lineLayerArray) {
        _lineLayerArray = [NSMutableArray array];
    }
    return _lineLayerArray;
}
-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

@end
