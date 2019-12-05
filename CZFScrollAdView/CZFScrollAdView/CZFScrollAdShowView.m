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

@interface CZFScrollAdShowView() <UIScrollViewDelegate> {
    CGFloat _currentOffsetX;
}

@property(nonatomic, weak) CZFScrollView *scrollView;
@property(nonatomic, weak) CZFPageControl *pageControl;

@end

@implementation CZFScrollAdShowView

// test
+ (void)showMyAge {
    NSLog(@"15");
}

+ (UIView *)getRedView {
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    
    return redView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 获取轮播图片View

 @param frame 布局frame
 @param imagesArray 图片数组，可以是本地，也可以是web链接，但不能是混着链接
 @param placeholderImage 展位图片，本地地址
 @return view对象
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<NSString *> *)imagesArray
             placeholderImage:(NSString *)placeholderImage {
    self = [super initWithFrame:frame];
    if (self) {
        // init
        _currentOffsetX = 0;
        
        // scrollview
        CZFScrollView *scrollView = [[CZFScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView = scrollView;
        self.scrollView.pagingEnabled = true;
        self.scrollView.showsVerticalScrollIndicator = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor grayColor];
        [self setScrollImages:imagesArray];
        
        // page control
        CZFPageControl *pageControl = [[CZFPageControl alloc] init];
        self.pageControl = pageControl;
        pageControl.numberOfPages = imagesArray.count;
        pageControl.currentPage = 0;
        // 默认底部中心
        pageControl.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y + CGRectGetHeight(self.scrollView.frame)/2 - 20);
        
        [self addSubview:scrollView];
        [self addSubview:pageControl];
        [self bringSubviewToFront:pageControl];
    }
    
    return self;
}

#pragma mark private
- (void)setScrollImages:(NSArray<NSString *> *)imgsArray {
    CGRect imageViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame));
    // 在scrollview中的第一个imageView中添加最后一个图片
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    NSString *lastImageUrl = imgsArray.lastObject;
    if ([lastImageUrl hasPrefix:@"http"]) {
        // web image
    } else {
        // local image
        firstImageView.image = [UIImage imageNamed:lastImageUrl];
    }
    [self.scrollView addSubview:firstImageView];
    
    // 将所有图片都添加到scrollview
    for (int i = 0; i < imgsArray.count; i++) {
        NSString *imageUrl = imgsArray[i];
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*(i+1), CGRectGetMinY(imageViewFrame), CGRectGetWidth(imageViewFrame), CGRectGetHeight(imageViewFrame))];
        showImageView.tag = i;
        if ([imageUrl hasPrefix:@"http"]) {
            // web image
        } else {
            // local image
            showImageView.image = [UIImage imageNamed:imageUrl];
        }
        [self.scrollView addSubview:showImageView];
    }
    // 在scrollview的最后添加显示第一张的图片
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake((imgsArray.count + 1) * CGRectGetWidth(self.scrollView.frame), CGRectGetMinY(imageViewFrame), CGRectGetWidth(imageViewFrame), CGRectGetHeight(imageViewFrame))];
    NSString *firstImageUrl = imgsArray.firstObject;
    if ([firstImageUrl hasPrefix:@"http"]) {
        // web image
    } else {
        // local image
        lastImageView.image = [UIImage imageNamed:firstImageUrl];
    }
    [self.scrollView addSubview:lastImageView];
    
    // 设置偏移量
    self.scrollView.contentSize = CGSizeMake((imgsArray.count + 2) * CGRectGetWidth(self.scrollView.frame), 20);
    
    // 跳过第一张图片
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
}

#pragma mark - Delegate
# pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 滑到第一位，改变scrollview的偏移位置
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(self.pageControl.numberOfPages * CGRectGetWidth(self.scrollView.frame), 0);
        self.pageControl.currentPage = self.pageControl.numberOfPages;
        /// 当UIScrollView滑动到最后一位停止时，将UIScrollView的偏移位置改变
    } else if (scrollView.contentOffset.x == (self.pageControl.numberOfPages + 1)* CGRectGetWidth(self.scrollView.frame)) {
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame) - 1;
    }
    scrollView.scrollEnabled = true;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.scrollEnabled = false;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > _currentOffsetX) {
        // 向左滑动
    } else {
        // 向右滑动
    }
    _currentOffsetX = scrollView.contentOffset.x;
}

#pragma mark public function
/**
 设置pageControl的位置类型

 @param pageType 类型
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


@end
