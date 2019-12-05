//
// UIImageView+CZFShow.m
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/5.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "UIImageView+CZFShow.h"

@implementation UIImageView (CZFShow)

/**
 show web image

 @param url url
 */
- (void)showWebImageWithUrl:(NSString *)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

/**
 show web image

 @param url url
 @param placeImage placeimage (local image path)
 */
- (void)showWebImageWithUrl:(NSString *)url placeholderImage:(NSString *)placeImage {
    if (placeImage != nil) {
        self.image = [UIImage imageNamed:placeImage];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

@end
