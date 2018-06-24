//
//  BWTipperHUD.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"


@interface BWTipperHUD : BWTipperComponent

+ (void)showWithStyle: (BWTipperStyle)style
              message: (NSString *)message
     backgroundDimmed: (BOOL)backgroundDimmed
                delay: (NSTimeInterval)delay
           completion: (BWTipperCompletion)completion;


+ (void)showWithImage: (UIImage *)image
              message: (NSString *)message
     backgroundDimmed: (BOOL)backgroundDimmed
                delay: (NSTimeInterval)delay
           completion: (BWTipperCompletion)completion;


+ (void)showLoadingWithMessage: (NSString *)message
                       timeout: (NSTimeInterval)timeout;

+ (void)showLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                              message: (NSString *)message
                             duration: (NSTimeInterval)duration
                              timeout: (NSTimeInterval)timeout;

@end
