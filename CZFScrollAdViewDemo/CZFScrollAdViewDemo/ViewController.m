//
// ViewController.m
// CZFScrollAdViewDemo
// Notes：
//
// Created by 陈帆 on 2019/12/4.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "ViewController.h"
#import <CZFScrollAdView/CZFScrollAdView.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;  // 推荐使用(导航栏会变成灰色？)
    [CZFScrollAdShowView showMyAge];
    
    UIView *redView = [CZFScrollAdShowView getRedView];
    redView.frame = CGRectMake(0, 300, 100, 100);
    
    NSArray *imagesArray = @[@"ad_001",
                            @"ad_002",
                             @"ad_003",
                             @"ad_default",
                             ];
    
    CZFScrollAdShowView *adView = [[CZFScrollAdShowView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) images:imagesArray placeholderImage:@"ad_default"];
    [adView setPageControlPositionType:PageControlPositionTypeBottomRight];
    [self.view addSubview:redView];
    [self.view addSubview:adView];
}


@end
