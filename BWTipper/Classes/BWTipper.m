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

#pragma mark HUD Loading Default

+ (void)hudLoading{
    [self hudLoadingWithMessage:nil];
}

+ (void)hudLoadingWithMessage:(NSString *)message{
    [self hudLoadingWithMessage:message backgroundDimmed:NO timeout:0];
}

+ (void)hudLoadingWithMessage:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed timeout:(NSTimeInterval)timeout{
    [BWTipperHUD showLoadingWithMessage:message backgroundDimmed:backgroundDimmed timeout:timeout];
}

#pragma mark HUD Loading Images
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


#pragma mark - Toast
+ (void)toastWithMessage:(NSString *)message{
    [self toastWithMessage:message delay:0];
}

+ (void)toastWithMessage:(NSString *)message delay:(NSTimeInterval)delay{
    [BWTipperToast showWithMessage:message delay:delay];
}

#pragma mark - Snackbar
+ (void)snackbarWithStyle:(BWTipperStyle)style message:(NSString *)message delay:(NSTimeInterval)delay{
    [self snackbarWithStyle:style message:message action:nil actionHandler:nil delay:delay];
}

+ (void)snackbarWithStyle:(BWTipperStyle)style
                  message:(NSString *)message
                   action:(NSString *)action
            actionHandler:(BWTipperSnackbarActionHandler)actionHandler
                    delay:(NSTimeInterval)delay{
    [BWTipperSnackbar showWithStyle:style message:message action:action actionHandler:actionHandler delay:delay];
}


#pragma mark - Common
+ (void)dismiss{
    [BWTipperHUD dismissComponentByClass:BWTipperHUD.class animated:YES];
}


@end
