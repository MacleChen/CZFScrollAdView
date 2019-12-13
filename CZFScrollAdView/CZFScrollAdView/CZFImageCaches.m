//
// CZFImageCaches.m
// CZFScrollAdView
// Notes：
//
// Created by 陈帆 on 2019/12/6.
// Copyright © 2019 陈帆. All rights reserved.
//

#import "CZFImageCaches.h"
#import <CommonCrypto/CommonCrypto.h>

#define MAX_FILE_EXTENSION_LENGTH 300
#define APP_INFO_DICT  [[NSBundle mainBundle] infoDictionary]

@implementation CZFImageCaches

/**
 get absolute iamge cache path
 
 @param imageName file name
 @return absolute path
 */
+ (NSString *)getAbsoluteImageCachePath:(NSString *)imageName {
    NSString *appPackageName = [APP_INFO_DICT objectForKey:@"CFBundleIdentifier"];
    
    NSString *md5ImageName = [self cachedFileNameForKey:imageName];
    NSString *adShowImageDiskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) firstObject];
    NSString *adShowImageDiskDir = [adShowImageDiskPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/CZFAdShowImages/", appPackageName]];
    adShowImageDiskPath = [adShowImageDiskDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", md5ImageName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:adShowImageDiskDir]) {
        NSError *error;
        [fileManager createDirectoryAtPath:adShowImageDiskDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"create directory error:%@", error.description);
        }
    }
    
    return adShowImageDiskPath;
}

/**
 remove image file from disk
 
 @param imageName file name or url
 */
+ (void)removeImageFromDisk:(NSString *)imageName {
    NSString *md5AbsolutePath = [self getAbsoluteImageCachePath:imageName];
    
    // check file exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:md5AbsolutePath]) {
        [fileManager removeItemAtPath:md5AbsolutePath error:nil];
    }
}

/**
 creat file name with md5

 @param key normal file name
 @return md5 file name
 */
+ (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSURL *keyURL = [NSURL URLWithString:key];
    NSString *ext = keyURL ? keyURL.pathExtension : key.pathExtension;
    // File system has file name length limit, we need to check if ext is too long, we don't add it to the filename
    if (ext.length > MAX_FILE_EXTENSION_LENGTH) {
        ext = nil;
    }
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];
    return filename;
}

@end
