//
// CZFScrollAdShowView.h
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/4.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 轮播图片的样式
 
 - ScrollAdViewFullWidth: 轮播图片和宽度相等
 - ScrollAdViewHasGap: 轮播图片右间距
 - ScrollAdViewTypeAnimationOne: 轮播图片特殊动画1
 - ScrollAdViewTypeAnimationTwo: 轮播图片特殊动画2
 */
typedef NS_ENUM(NSInteger, ScrollAdViewType) {
    ScrollAdViewFullWidth,
    ScrollAdViewHasGap,
    ScrollAdViewTypeAnimationOne,
    ScrollAdViewTypeAnimationTwo
};


/**
 轮播分页时，按钮的位置
 
 - PageControlPositionTypeBottomLeft: 底部靠左
 - PageControlPositionTypeBottomRight: 底部靠右
 - PageControlPositionTypeBottomCenter: 底部中心
 */
typedef NS_ENUM(NSInteger, PageControlPositionType) {
    PageControlPositionTypeBottomLeft,
    PageControlPositionTypeBottomRight,
    PageControlPositionTypeBottomCenter
};

@interface CZFScrollAdShowView : UIView

+ (void)showMyAge;

+ (UIView *)getRedView;

/**
 获取轮播图片View
 
 @param frame 布局frame
 @param imagesArray 图片数组，可以是本地，也可以是web链接，但不能是混着链接
 @param placeholderImage 展位图片，本地地址
 @return view对象
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<NSString *> *)imagesArray
             placeholderImage:(NSString *)placeholderImage;

/**
 设置pageControl的位置类型
 
 @param pageType 类型
 */
- (void)setPageControlPositionType:(PageControlPositionType)pageType;

@end

NS_ASSUME_NONNULL_END
