//
//  ChangeImageView.m
//  testImageTurn
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChangeImageView.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface ChangeImageView () <UIGestureRecognizerDelegate>


 
@property (nonatomic,strong)UITapGestureRecognizer * tap;
@property (nonatomic,strong)UIRotationGestureRecognizer * rotation;
@property (nonatomic,strong)UIPinchGestureRecognizer * pinch;
@property (nonatomic,strong)UIPanGestureRecognizer * pan;
@end

@implementation ChangeImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self addGestureRecognizer:self.tap];
        [self addGestureRecognizer:self.rotation];
        [self addGestureRecognizer:self.pinch];
        [self addGestureRecognizer:self.pan];
        
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

- (void)viewRotation:(UIRotationGestureRecognizer *)rotation
{
    if (rotation.state == UIGestureRecognizerStateBegan || rotation.state == UIGestureRecognizerStateChanged) {
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
        [rotation setRotation:0];
    }
}

- (void)viewPinch:(UIPinchGestureRecognizer *)pintch
{
    if (pintch.state == UIGestureRecognizerStateBegan || pintch.state == UIGestureRecognizerStateChanged) {
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pintch.scale, pintch.scale);
        pintch.scale = 1;
    }
}

- (void)viewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    self.imageView.center = CGPointMake(self.imageView.center.x + point.x, self.imageView.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self];
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImage * image = [UIImage imageNamed:@"4.jpg"];
        
        CGFloat height = image.size.height;
        CGFloat width  = image.size.width;
        
        if (width/height > kScreenWidth/kScreenHeight) {
            width  = kScreenWidth * height/width;
            height = kScreenHeight;
        }else
        {
            height = kScreenHeight * width/height;
            width  = kScreenWidth;
        }
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        _imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:_imageView];
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

- (UIRotationGestureRecognizer *)rotation
{
    if (!_rotation) {
        _rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(viewRotation:)];
        _rotation.delegate = self;
    }
    return _rotation;
}

- (UIPinchGestureRecognizer *)pinch
{
    if (!_pinch) {
        _pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(viewPinch:)];
        _pinch.delegate = self;
    }
    return _pinch;
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
