//
// CZFScrollAdShowView+test.h
// CZFScrollAdViewTests
// Notes：
//
// Created by 陈帆 on 2019/12/12.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <CZFScrollAdView/CZFScrollAdView.h>
#import "CZFScrollView.h"
#import "CZFPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZFScrollAdShowView (){
    CGFloat _currentOffsetX;
    BOOL _isAutoScroll;
    NSTimeInterval _scrollTimeValue;
}

@property(nonatomic, weak) CZFScrollView *scrollView;
@property(nonatomic, weak) CZFPageControl *pageControl;
@property(nonatomic, weak) UILabel *textLabel;
@property(nonatomic, copy) NSArray<NSString *> *imagesArray;
@property(nonatomic, copy) NSArray<NSString *> *textArray;
@property(nonatomic, strong) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
