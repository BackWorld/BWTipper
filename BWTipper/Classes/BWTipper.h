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

+ (void)hudWithStyle: (BWTipperStyle)style
             message: (NSString *)message;

+ (void)hudWithStyle: (BWTipperStyle)style
              message: (NSString *)message
     backgroundDimmed: (BOOL)backgroundDimmed
                delay: (NSTimeInterval)delay
           completion: (BWTipperCompletion)completion;

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message;

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion;


+ (void)hudLoadingWithMessage: (NSString *)message
                      timeout: (NSTimeInterval)timeout;

+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration
                             message: (NSString *)message
                             timeout: (NSTimeInterval)timeout;

+ (void)hudTest;

#pragma mark - Toast


#pragma mark - Snackbar

#pragma mark - Public
+ (void)dismiss;

@end
