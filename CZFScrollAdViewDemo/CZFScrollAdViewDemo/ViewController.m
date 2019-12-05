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

@interface ViewController ()<CZFScrollAdShowViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;  // 推荐使用(导航栏会变成灰色？)
    // local images
    NSArray *imagesArray1 = @[@"ad_001",
                            @"ad_002",
                             @"ad_003",
                             @"ad_default",
                             ];
    // web images
    NSArray *imagesArray2 = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575523868582&di=2d89ce42bce4267e095c90e296d79912&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Ff%2F54eecb3dd2e98.jpg",
                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575523901258&di=fd48046dff8b0df61550b2f3a4e55295&imgtype=0&src=http%3A%2F%2Fpic16.nipic.com%2F20110825%2F7341593_073108510000_2.jpg",
                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575523901258&di=36730cebdab153472e293276be1500f0&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201111%2F29%2F20111129211559_Vj5Qj.jpg",
                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575523901257&di=c6b899be6c6b623b36a49d23f310a522&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130512%2F8786105_134147897000_2.jpg",
                              ];
    
    CZFScrollAdShowView *adView = [[CZFScrollAdShowView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) images:imagesArray2 placeholderImage:@"ad_default" isAutoScroll:true];
    adView.delegate = self;
    [adView setPageControlPositionType:PageControlPositionTypeBottomCenter];
    [adView setAutoScrollImageTimeValue:1]; // auto time
    [adView setImageMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:adView];
}

#pragma mark - CZFScrollAdShowViewDelegate
#pragma mark
- (void)scrollAdShowView:(CZFScrollAdShowView *)adShoView didImageViewClick:(UIImageView *)imageView index:(NSInteger)imageIndex {
    [self showAlertView:[NSString stringWithFormat:@"%ld", imageIndex] message:nil];
}

- (void)showAlertView:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alertController animated:true completion:nil];
}


@end
