//
// CZFImageCaches+test.h
// CZFScrollAdViewTests
// Notes：
//
// Created by 陈帆 on 2019/12/13.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "CZFImageCaches.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZFImageCaches (test)

/**
 creat file name with md5
 
 @param key normal file name
 @return md5 file name
 */
+ (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
