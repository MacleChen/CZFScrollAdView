//
// UIImageView+CZFShow.m
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/5.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "UIImageView+CZFShow.h"
#import "CZFImageCaches.h"

@implementation UIImageView (CZFShow)

#pragma mark - public method
/**
 show web image

 @param url url
 */
- (void)showWebImageWithUrl:(NSString *)url {
    // check disk have the image
    UIImage *diskImage = [self getImageDiskCache:url];
    if (diskImage) {
        self.image = diskImage;
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        [self saveImageDiskCache:url image:image];
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
    // check disk have the image
    UIImage *diskImage = [self getImageDiskCache:url];
    if (diskImage) {
        self.image = diskImage;
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        [self saveImageDiskCache:url image:image];
    });
}

/**
 get image from disk

 @param imageName url path
 @return image
 */
- (UIImage *)getImageDiskCache:(NSString *)imageName {
    NSString *md5AbsolutePath = [CZFImageCaches getAbsoluteImageCachePath:imageName];
    
    // check file exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:md5AbsolutePath]) {
        return [UIImage imageWithContentsOfFile:md5AbsolutePath];
    }
    
    return nil;
}

/**
 save image to disk

 @param imageName file name or url
 @param saveImage save image object
 */
- (void)saveImageDiskCache:(NSString *)imageName image:(UIImage *)saveImage {
    NSString *adShowImageDiskPath = [CZFImageCaches getAbsoluteImageCachePath:imageName];
    
    // check file exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:adShowImageDiskPath]) {
        return;
    }
    
    NSData *imageData = UIImagePNGRepresentation(saveImage);
    BOOL result = [imageData writeToFile:adShowImageDiskPath atomically:true];
    if (!result) {
        NSLog(@"CZFScrollAdView: save iamge to disk error.");
    }
}

#pragma mark - static method


@end
