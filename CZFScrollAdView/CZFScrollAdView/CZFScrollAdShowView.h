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
 scroll image type
 
 - ScrollAdViewFullWidth: scroll image full width
 - ScrollAdViewHasGap: scroll image has gap
 - ScrollAdViewTypeAnimationOne: scroll iamge special animate one
 - ScrollAdViewTypeAnimationTwo: scroll iamge special animate two
 */
typedef NS_ENUM(NSInteger, ScrollAdViewType) {
    ScrollAdViewFullWidth,
    ScrollAdViewHasGap,
    ScrollAdViewTypeAnimationOne,
    ScrollAdViewTypeAnimationTwo
};


/**
 scroll bottom pageControl position type
 
 - PageControlPositionTypeBottomLeft: bottom left
 - PageControlPositionTypeBottomRight: bottom right
 - PageControlPositionTypeBottomCenter: bottom center
 */
typedef NS_ENUM(NSInteger, PageControlPositionType) {
    PageControlPositionTypeBottomLeft,
    PageControlPositionTypeBottomRight,
    PageControlPositionTypeBottomCenter
};

@class CZFScrollAdShowView;

@protocol CZFScrollAdShowViewDelegate <NSObject>

@optional

/**
 image view click

 @param adShoView self
 @param imageView iamgeView
 @param imageIndex index
 */
- (void)scrollAdShowView:(CZFScrollAdShowView *)adShoView didImageViewClick:(UIImageView *)imageView
                   index:(NSInteger)imageIndex;

@end

@interface CZFScrollAdShowView : UIView

/**
 content mode
 */
@property(nonatomic, readwrite, assign) UIViewContentMode imageMode;

/**
 auto scroll image
 * default: 3s
 */
@property(nonatomic, readwrite, assign) NSInteger autoScrollImageTimeValue;

/**
 set page control postion type
 */
@property(nonatomic, readwrite, assign) PageControlPositionType PageControlPositionType;

/**
 delegate
 */
@property(nonatomic, weak) id<CZFScrollAdShowViewDelegate> delegate;

/**
 get scroll image view
 
 @param frame :layout or position frame
 @param imagesArray :images array, local images or web iamges
 @param placeholderImage :default placeholder image
 @param isAuto :auto scroll image
 @return view :instance
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<NSString *> *)imagesArray
             placeholderImage:(NSString *)placeholderImage isAutoScroll:(BOOL)isAuto;

/**
 auto scroll image is suspend
 */
- (void)suspendScrollImage;

/**
 auto scroll image is resume
 */
- (void)resumeScrollImage;

/**
 remove iamges from disk
 */
- (void)removeImagesFromDisk;

/**
 set bottom text array
 
 @param textArray textArray
 */
- (void)setScrollViewBottomText:(NSArray *)textArray;

@end

NS_ASSUME_NONNULL_END
