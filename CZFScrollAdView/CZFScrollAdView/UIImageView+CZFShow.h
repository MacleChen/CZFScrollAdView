//
// UIImageView+CZFShow.h
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/5.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CZFShow)

/**
 show web image
 
 @param url url
 @param placeImage placeimage (local image path)
 */
- (void)showWebImageWithUrl:(NSString *)url placeholderImage:(NSString *)placeImage;

/**
 show web image
 
 @param url url
 */
- (void)showWebImageWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
