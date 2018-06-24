//
//  BWTipper.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipper.h"

@implementation BWTipper

+ (void)load{
    [BWTipperConfigure defaultConfigure];
}

#pragma mark - HUD

+ (void)hudWithStyle:(BWTipperStyle)style {
    [self hudWithStyle:style message:nil];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message{
    [self hudWithStyle:style message:message backgroundDimmed:NO delay:1.5 completion:nil];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed delay:(NSTimeInterval)delay completion:(BWTipperCompletion)completion{
    [BWTipperHUD showWithStyle:style message:message backgroundDimmed:backgroundDimmed delay:delay completion:completion];
}

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion{
    [BWTipperHUD showWithImage:image message:message backgroundDimmed:backgroundDimmed delay:delay completion:completion];
}

#pragma mark - HUD Loading Default

+ (void)hudLoading{
    [self hudLoadingWithMessage:nil];
}

+ (void)hudLoadingWithMessage:(NSString *)message{
    [self hudLoadingWithMessage:message backgroundDimmed:NO timeout:0];
}

+ (void)hudLoadingWithMessage:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed timeout:(NSTimeInterval)timeout{
    [BWTipperHUD showLoadingWithMessage:message backgroundDimmed:backgroundDimmed timeout:timeout];
}

#pragma mark - HUD Loading Images
+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration{
    [self hudLoadingWithAnimatedImages:images duration:duration message:nil backgroundDimmed:NO timeout:0];
}

+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration
                             message: (NSString *)message
                    backgroundDimmed: (BOOL)backgroundDimmed
                             timeout: (NSTimeInterval)timeout{
    [BWTipperHUD showLoadingWithAnimatedImages:images duration:duration message:message backgroundDimmed:backgroundDimmed timeout:timeout];
}


#pragma mark - Common
+ (void)dismiss{
    [BWTipperHUD dismissWithAnimated:YES];
}


@end
