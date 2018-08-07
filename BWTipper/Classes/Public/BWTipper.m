//
//  BWTipper.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipper.h"
#import "BWTipperHUDHeaders.h"
#import "BWTipperToast.h"
#import "BWTipperSnackbar.h"

@implementation BWTipper

+ (void)load{
    [BWTipperConfigure defaultConfigure];
}

#pragma mark - HUD

+ (void)hudWithStyle:(BWTipperStyle)style {
    [self hudWithStyle:style message:nil];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message{
    [self hudWithStyle:style message:message backgroundDimmed:NO delay:0 completion:nil];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed delay:(NSTimeInterval)delay completion:(BWTipperCompletion)completion{
    [BWTipperHUD showWithStyle:style message:message backgroundDimmed:backgroundDimmed delay:delay completion:completion];
}

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion{
    [BWTipperHUD showWithImages:@[image] duration:0 delay:delay message:message backgroundDimmed:backgroundDimmed wrapperDisplayOn:YES];
}

#pragma mark HUD Loading Default

+ (void)hudLoading{
    [self hudLoadingWithMessage:nil];
}

+ (void)hudLoadingWithMessage:(NSString *)message{
    [self hudLoadingWithMessage:message backgroundDimmed:NO timeout:0];
}

+ (void)hudLoadingWithMessage:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed{
    [self hudLoadingWithMessage:message backgroundDimmed:backgroundDimmed timeout:0];
}

+ (void)hudLoadingWithMessage:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed timeout:(NSTimeInterval)timeout{
    [BWTipperHUD showLoadingWithMessage:message backgroundDimmed:backgroundDimmed timeout:timeout];
}

#pragma mark HUD Loading Images
+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration{
    [self hudLoadingWithAnimatedImages:images duration:duration message:nil backgroundDimmed:NO wrapperDisplayOn:YES timeout:CGFLOAT_MAX];
}

+ (void)hudLoadingWithAnimatedImages: (NSArray<UIImage *> *)images
                            duration: (NSTimeInterval)duration
                             message: (NSString *)message
                    backgroundDimmed: (BOOL)backgroundDimmed
                    wrapperDisplayOn: (BOOL)wrapperDisplayOn
                             timeout: (NSTimeInterval)timeout{
    [BWTipperHUD showWithImages:images duration:duration delay:timeout message:message backgroundDimmed:backgroundDimmed wrapperDisplayOn:wrapperDisplayOn];
}

#pragma mark HUD Loading Progress

+ (void)hudLoadingWithProgress: (CGFloat)progress
                   progressText: (NSString *)progressText
               backgroundDimmed: (BOOL)backgroundDimmed{
    [BWTipperHUD showLoadingWithProgress:progress progressText:progressText backgroundDimmed:backgroundDimmed];
}

#pragma mark - Toast
+ (void)toastWithMessage:(NSString *)message{
    [self toastWithMessage:message delay:0];
}

+ (void)toastWithMessage:(NSString *)message delay:(NSTimeInterval)delay{
    [BWTipperToast showWithMessage:message delay:delay];
}

#pragma mark - Snackbar

+ (void)snackbarWithStyle:(BWTipperStyle)style message:(NSString *)message{
    [self snackbarWithStyle:style message:message delay:0];
}

+ (void)snackbarWithStyle:(BWTipperStyle)style message:(NSString *)message delay:(NSTimeInterval)delay{
    [BWTipperSnackbar showWithStyle:style message:message action:nil actionHandler:nil delay:delay];
}

+ (void)snackbarWithStyle:(BWTipperStyle)style
                  message:(NSString *)message
                   action:(NSString *)action
            actionHandler:(BWTipperSnackbarActionHandler)actionHandler{
    [BWTipperSnackbar showWithStyle:style message:message action:action actionHandler:actionHandler delay:0];
}

+ (void)snackbarWithImage:(UIImage *)image
                  message:(NSString *)message
                   action:(NSString *)action
            actionHandler:(BWTipperSnackbarActionHandler)actionHandler{
    [BWTipperSnackbar showWithImage:image message:message action:action actionHandler:actionHandler delay:0];
}

#pragma mark - Common
+ (void)dismissHUD{
    [BWTipperComponent dismissComponentByClass:BWTipperHUD.class animated:YES];
}

+ (void)dismissSnackbar{
    [BWTipperComponent dismissComponentByClass:BWTipperSnackbar.class animated:YES];
}

@end
