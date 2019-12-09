//
// CZFImageCaches.h
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/6.
// Copyright © 2019 陈帆. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZFImageCaches : NSObject

/**
 get absolute iamge cache path
 
 @param imageName file name
 @return absolute path
 */
+ (NSString *)getAbsoluteImageCachePath:(NSString *)imageName;

/**
 remove image file from disk
 
 @param imageName file name or url
 */
+ (void)removeImageFromDisk:(NSString *)imageName;

/**
 creat file name with md5
 
 @param key normal file name
 @return md5 file name
 */
+ (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
