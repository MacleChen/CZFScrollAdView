//
// CZFScrollAdViewDemoTests.m
// CZFScrollAdViewDemoTests
// Notes：
//
// Created by 陈帆 on 2019/12/4.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface CZFScrollAdViewDemoTests : XCTestCase

@property (nonatomic, strong) ViewController *testVC;

@end

@implementation CZFScrollAdViewDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testVC = [[ViewController alloc] init];
}

- (void)testDataDeal {
    
    // 测试金钱转换方法
    XCTAssertEqualObjects([self.testVC calculateYuanToFen:@"12"], @"1200");
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testVC = nil;
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
