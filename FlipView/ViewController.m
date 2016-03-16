//
//  ViewController.m
//  FlipView
//
//  Created by LiuGang on 16/3/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"
#import "YCFlipView.h"

const static CGFloat userPhotoBorderWidth = (2.5);

@interface ViewController ()
@property (nonatomic, strong) YCFlipView* topBottomFlipView;
@property (nonatomic, strong) YCFlipView* leftRightFlipView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 50)];
    label.text = @"点击图片翻转";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIImage* frontImage = [UIImage imageNamed:@"Manchester United"];
    UIImage* backImage = [UIImage imageNamed:@"Manchester City"];
    
    CGRect rect = CGRectMake(0, 0, frontImage.size.width + 20, frontImage.size.width + 20);
    self.leftRightFlipView = [[YCFlipView alloc]initWithFrame:rect frontImage:frontImage backImage:backImage];
    self.leftRightFlipView.direction = YCFlipDirectionLeftRight;
    self.leftRightFlipView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.leftRightFlipView.layer.masksToBounds = YES;
    self.leftRightFlipView.layer.cornerRadius = frontImage.size.width/2;
    self.leftRightFlipView.insets = UIEdgeInsetsMake(userPhotoBorderWidth, userPhotoBorderWidth, userPhotoBorderWidth, userPhotoBorderWidth);
    [self.view addSubview:self.leftRightFlipView];
    self.leftRightFlipView.center = CGPointMake(CGRectGetMidX(self.view.bounds)-100, CGRectGetMidY(self.view.bounds));
    
    frontImage = [UIImage imageNamed:@"Arsenal"];
    backImage = [UIImage imageNamed:@"Chelsea"];
    self.topBottomFlipView = [[YCFlipView alloc]initWithFrame:rect frontImage:frontImage backImage:backImage];
    self.topBottomFlipView.direction = YCFlipDirectionUpdown;
    self.topBottomFlipView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.topBottomFlipView.layer.masksToBounds = YES;
    self.topBottomFlipView.layer.cornerRadius = frontImage.size.width/2;
    self.topBottomFlipView.insets = UIEdgeInsetsMake(userPhotoBorderWidth, userPhotoBorderWidth, userPhotoBorderWidth, userPhotoBorderWidth);
    [self.view addSubview:self.topBottomFlipView];
    self.topBottomFlipView.center = CGPointMake(CGRectGetMidX(self.view.bounds)+100, CGRectGetMidY(self.view.bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
