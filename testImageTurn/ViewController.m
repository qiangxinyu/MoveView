//
//  ViewController.m
//  testImageTurn
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ChangeTextView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#import "ChangeImageView.h"
@interface ViewController ()


@property (nonatomic,strong)ChangeImageView * changImageView;


@property (nonatomic,strong)ChangeTextView * changeTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
 
//    ChangeImageView * change = [[ChangeImageView alloc]initWithFrame:self.view.frame];
//    change.imageView.image = [UIImage imageNamed:@"4.jpg"];
//    [self.view addSubview:change];
    
    
    
    ChangeTextView * text = [[ChangeTextView alloc]initWithFrame:CGRectMake(100, 100, 230, 40)];
    text.label.text = @"奥斯卡的那都是男的if；随你动；爱的浓；阿森纳都IPO手机打破";
    [self.view addSubview:text];
    
    


    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
