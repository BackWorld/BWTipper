//
//  BWTipper.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <Foundation/Foundation.h>
#import "BWTipperConfigure.h"

@interface BWTipper : NSObject


#pragma mark - HUD

+ (void)hudWithStyle:(BWTipperStyle)style;

+ (void)hudWithStyle:(BWTipperStyle)style
             message:(NSString *)message;

+ (void)hudWithStyle: (BWTipperStyle)style
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion;

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion;


#pragma mark HUD Loading

+ (void)hudLoading;

+ (void)hudLoadingWithMessage:(NSString *)message;

+ (void)hudLoadingWithMessage:(NSString *)message
             backgroundDimmed:(BOOL)backgroundDimmed
                      timeout:(NSTimeInterval)timeout;

#pragma mark HUD Loading Images
+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration;

+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration
                             message: (NSString *)message
                    backgroundDimmed: (BOOL)backgroundDimmed
                             timeout: (NSTimeInterval)timeout;

#pragma mark - Toast


#pragma mark - Snackbar

#pragma mark - Common

/**
 移除
 */
+ (void)dismiss;

@end
