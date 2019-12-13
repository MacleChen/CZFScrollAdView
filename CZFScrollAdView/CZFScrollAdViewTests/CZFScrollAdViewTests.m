//
// CZFScrollAdViewTests.m
// CZFScrollAdViewTests
// Notes：
//
// Created by 陈帆 on 2019/12/4.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CZFScrollAdShowView.h"
#import "CZFScrollAdShowView+test.h"
#import "CZFImageCaches+test.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CZFScrollAdViewTests : XCTestCase

@property(nonatomic, strong) CZFScrollAdShowView *adShowView;

@end

@interface CZFScrollAdViewTests() <CZFScrollAdShowViewDelegate>

@end

@implementation CZFScrollAdViewTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
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
    
    NSArray *textArray = @[@"欢乐的小树林哈哈哈",
                           @"凶猛的大老虎",
                           @"温柔的大熊猫",
                           @"细心认真的小松鼠"];
    
    self.adShowView = [[CZFScrollAdShowView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) images:imagesArray2 placeholderImage:@"ad_default" isAutoScroll:true];
    self.adShowView.delegate = self;
    [self.adShowView setScrollViewBottomText:textArray];
    [self.adShowView setPageControlPositionType:PageControlPositionTypeBottomRight];
    [self.adShowView setAutoScrollImageTimeValue:2]; // auto time
    [self.adShowView setImageMode:UIViewContentModeScaleAspectFill];
}

#pragma mark - 测试对外公有的方法和属性
#pragma mark 测试adView Frame
- (void)testEqualSomeValue {
    XCTAssertEqual(self.adShowView.frame.origin.x, 0);
    XCTAssertEqual(self.adShowView.frame.origin.y, 64);
    XCTAssertEqual(self.adShowView.frame.size.width, SCREEN_WIDTH);
    XCTAssertEqual(self.adShowView.frame.size.height, 200);
    XCTAssertEqual(self.adShowView.imagesArray.count, 4);
    XCTAssertEqual(self.adShowView.textArray.count, 4);
    XCTAssertEqual(self.adShowView.autoScrollImageTimeValue, 2);
    XCTAssertEqual(self.adShowView.imageMode, UIViewContentModeScaleAspectFill);
}

#pragma mark 测试空值
- (void)testNilSomeObject {
    XCTAssertNotNil(self.adShowView);
    XCTAssertNotNil(self.adShowView.delegate);
    XCTAssertNotNil([CZFImageCaches cachedFileNameForKey:@"https://www.baidu.com"]);
}

#pragma mark 测试对象是否相等
- (void)testEqualObject {
    XCTAssertEqualObjects(self.adShowView.delegate, self);
}

#pragma mark - CZFScrollAdShowViewDelegate 代理方法的测试
#pragma mark didImageViewClick
- (void)scrollAdShowView:(CZFScrollAdShowView *)adShoView didImageViewClick:(UIImageView *)imageView index:(NSInteger)imageIndex {
    // 判断 索引值和点击索引是否相等
    XCTAssertEqual(imageIndex, self.adShowView.pageControl.currentPage);
}

#pragma mark - 测试私有方法和属性（使用分类或扩展）


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
