//
//  ChangeTextView.m
//  testImageTurn
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChangeTextView.h"


@interface ChangeTextView () <UIGestureRecognizerDelegate>

@property (nonatomic,strong)UITapGestureRecognizer * tap;
@property (nonatomic,strong)UIPanGestureRecognizer * pan2;
@property (nonatomic,strong)UIPanGestureRecognizer * pan;



@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,assign)CGFloat  oldD;
@property (nonatomic,assign)CGFloat  tanC;


@property (nonatomic,assign)CGFloat  proportion;


@end

@implementation ChangeTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.label];
        [self addSubview:self.imageView];
        
        [self addGestureRecognizer:self.tap];
        [self addGestureRecognizer:self.pan];
        
        
        [self.imageView addGestureRecognizer:self.pan2];

        
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)viewTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"单击了一次");
}

- (void)viewPan1:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translatedPoint = [recognizer locationInView:self.superview];
    double x1 = self.center.x;
    double y1 = self.center.y;
    
    double x2 = translatedPoint.x;
    double y2 = translatedPoint.y;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self removeGestureRecognizer:self.pan];
            
            self.oldD = sqrt(pow(fabs(x2 - x1), 2) + pow(fabs(y2 - y1), 2));

            break;
        }
        case
        
        UIGestureRecognizerStateChanged:{
            double d = sqrt(pow(fabs(x2 - x1), 2) + pow(fabs(y2 - y1), 2));
            CGFloat proportion = d / self.oldD;
            
            
            self.transform = CGAffineTransformMakeScale(proportion, proportion);
            [self setNeedsDisplay];
            
            double tanC = atan2((y2 - y1) , (x2 - x1));
  
            self.transform = CGAffineTransformRotate(self.transform, tanC);
            
            [self setNeedsDisplay];

            
            break;
        }
        
            default:
        {
            [self addGestureRecognizer:self.pan];
        }
        
            
            
        
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

- (void)viewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.superview];
    self.center = CGPointMake(self.center.x + point.x, self.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self];
}


- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        
    }
    return _label;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:@"x2_btn_scale"];
    }
    return _imageView;
}

- (UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
        
    }
    return _tap;
}

- (UIPanGestureRecognizer *)pan2
{
    if (!_pan2) {
        _pan2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewPan1:)];
        _pan2.delegate = self;
    }
    return _pan2;
}



- (UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewPan:)];
        _pan.delegate = self;
    }
    return _pan;
}

@end
