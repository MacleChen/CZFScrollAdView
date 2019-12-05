//
// CZFScrollAdShowView.m
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/4.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "CZFScrollAdShowView.h"
#import "CZFScrollView.h"
#import "CZFPageControl.h"
#import "UIView+Extension.h"
#import "UIImageView+CZFShow.h"

@interface CZFScrollAdShowView() <UIScrollViewDelegate> {
    CGFloat _currentOffsetX;
    BOOL _isAutoScroll;
    NSTimeInterval _scrollTimeValue;
}

@property(nonatomic, weak) CZFScrollView *scrollView;
@property(nonatomic, weak) CZFPageControl *pageControl;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation CZFScrollAdShowView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark public function
/**
 get scroll image view

 @param frame :layout or position frame
 @param imagesArray :images array, local images or web iamges
 @param placeholderImage :default placeholder image
 @param isAuto :auto scroll image
 @return view :instance
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<NSString *> *)imagesArray
             placeholderImage:(NSString *)placeholderImage isAutoScroll:(BOOL)isAuto {
    self = [super initWithFrame:frame];
    if (self) {
        // init
        _currentOffsetX = 0;
        _scrollTimeValue = 3;
        
        // scrollview
        CZFScrollView *scrollView = [[CZFScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView = scrollView;
        self.scrollView.pagingEnabled = true;
        self.scrollView.showsVerticalScrollIndicator = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor grayColor];
        [self setScrollImages:imagesArray placeImage:placeholderImage];
        
        // page control
        CZFPageControl *pageControl = [[CZFPageControl alloc] init];
        self.pageControl = pageControl;
        pageControl.numberOfPages = imagesArray.count;
        pageControl.currentPage = 0;
        // default bottom center
        pageControl.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y + CGRectGetHeight(self.scrollView.frame)/2 - 20);
        
        [self addSubview:scrollView];
        [self addSubview:pageControl];
        [self bringSubviewToFront:pageControl];
        
        // auto scroll image view
        if (isAuto) {
            [self setAutoScrollImageTimeValue:_scrollTimeValue];
        }
    }
    
    return self;
}

/**
 set iamge mode

 @param imageMode imageMode
 */
- (void)setImageMode:(UIViewContentMode)imageMode {
    for (UIImageView *imageView in self.scrollView.subviews) {
        imageView.contentMode = imageMode;
        imageView.clipsToBounds = true; // clips bound out image section
    }
}

/**
 set auto scroll time value

 @param autoScrollImageTimeValue time Value
 */
- (void)setAutoScrollImageTimeValue:(NSInteger)autoScrollImageTimeValue {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _scrollTimeValue = autoScrollImageTimeValue;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_scrollTimeValue
                                                  target:self
                                                selector:@selector(timerRunLoop:)
                                                userInfo:nil
                                                 repeats:true];
    // in case stop auto scroll image  when to scroll tableview or collection
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 set pageControl type

 @param pageType page type
 */
- (void)setPageControlPositionType:(PageControlPositionType)pageType {
    CGFloat pageControlWidth = 15 * self.pageControl.numberOfPages;
    switch (pageType) {
        case PageControlPositionTypeBottomLeft:
            self.pageControl.center = CGPointMake(pageControlWidth/2 + 20, self.pageControl.center.y);
            break;
        case PageControlPositionTypeBottomRight:
            self.pageControl.center = CGPointMake(CGRectGetWidth(self.scrollView.frame) - pageControlWidth/2 - 20, self.pageControl.center.y);
            break;
        case PageControlPositionTypeBottomCenter:
            self.pageControl.center = CGPointMake(self.scrollView.center.x, self.pageControl.center.y);
            break;
    }
}

#pragma mark private
- (void)setScrollImages:(NSArray<NSString *> *)imgsArray placeImage:(NSString *)localImage {
    CGRect imageViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame));
    // scrollview is the first imageView add the last image url
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [firstImageView setUserInteractionEnabled:true];
    firstImageView.tag = imgsArray.count - 1;
    [firstImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollImageViewClick:)]];
    NSString *lastImageUrl = imgsArray.lastObject;
    if ([lastImageUrl hasPrefix:@"http"]) {
        // web image
        [firstImageView showWebImageWithUrl:lastImageUrl placeholderImage:localImage];
    } else {
        // local image
        firstImageView.image = [UIImage imageNamed:lastImageUrl];
    }
    [self.scrollView addSubview:firstImageView];
    
    // Add all of images to scrollview
    for (int i = 0; i < imgsArray.count; i++) {
        NSString *imageUrl = imgsArray[i];
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*(i+1), CGRectGetMinY(imageViewFrame), CGRectGetWidth(imageViewFrame), CGRectGetHeight(imageViewFrame))];
        [showImageView setUserInteractionEnabled:true];
        showImageView.tag = i;
        [showImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollImageViewClick:)]];
        if ([imageUrl hasPrefix:@"http"]) {
            // web image
            [showImageView showWebImageWithUrl:imageUrl placeholderImage:localImage];
        } else {
            // local image
            showImageView.image = [UIImage imageNamed:imageUrl];
        }
        [self.scrollView addSubview:showImageView];
    }
    // Add the last position imageview to scrollview that the first image url
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake((imgsArray.count + 1) * CGRectGetWidth(self.scrollView.frame), CGRectGetMinY(imageViewFrame), CGRectGetWidth(imageViewFrame), CGRectGetHeight(imageViewFrame))];
    [lastImageView setUserInteractionEnabled:true];
    lastImageView.tag = 0;
    [lastImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollImageViewClick:)]];
    NSString *firstImageUrl = imgsArray.firstObject;
    if ([firstImageUrl hasPrefix:@"http"]) {
        // web image
        [lastImageView showWebImageWithUrl:firstImageUrl placeholderImage:localImage];
    } else {
        // local image
        lastImageView.image = [UIImage imageNamed:firstImageUrl];
    }
    [self.scrollView addSubview:lastImageView];
    
    // set content size
    self.scrollView.contentSize = CGSizeMake((imgsArray.count + 2) * CGRectGetWidth(self.scrollView.frame), 20);
    
    // begin second postion calculate
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
}

- (void)timerRunLoop:(NSTimer *)timer {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    if (offsetX == 0) {
        offsetX = self.pageControl.numberOfPages * CGRectGetWidth(self.scrollView.frame);
        self.pageControl.currentPage = self.pageControl.numberOfPages;
    } else if (offsetX == (self.pageControl.numberOfPages) * CGRectGetWidth(self.scrollView.frame)) {
        // Change scroll view offset that scroll is stop the last postion
        offsetX = 0;
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:false];
    } else {
        self.pageControl.currentPage = offsetX / CGRectGetWidth(self.scrollView.frame);
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX + CGRectGetWidth(self.scrollView.frame), 0) animated:true];
}

- (void)scrollImageViewClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"image click index:%ld", gesture.view.tag);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(scrollAdShowView:didImageViewClick:index:)]) {
        [self.delegate scrollAdShowView:self didImageViewClick:(UIImageView *)gesture.view index:gesture.view.tag];
    }
}

#pragma mark - Delegate
# pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // Change scroll view offset that scroll the first postion
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(self.pageControl.numberOfPages * CGRectGetWidth(self.scrollView.frame), 0);
        self.pageControl.currentPage = self.pageControl.numberOfPages;
    } else if (scrollView.contentOffset.x == (self.pageControl.numberOfPages + 1)* CGRectGetWidth(self.scrollView.frame)) {
        // Change scroll view offset that scroll is stop the last postion
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame) - 1;
    }
    scrollView.scrollEnabled = true;
    [self setAutoScrollImageTimeValue:_scrollTimeValue];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.scrollEnabled = false;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > _currentOffsetX) {
        // to left scroll
    } else {
        // to right scroll
    }
    _currentOffsetX = scrollView.contentOffset.x;
}

@end
