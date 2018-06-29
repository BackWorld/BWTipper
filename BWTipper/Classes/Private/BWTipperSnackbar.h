//
//  BWTipperSnackbar.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"


@interface BWTipperSnackbar : BWTipperComponent

+ (void)showWithStyle: (BWTipperStyle)style
              message: (NSString *)message
               action: (NSString *)action
        actionHandler: (BWTipperSnackbarActionHandler)actionHandler
                delay: (NSTimeInterval)delay;

+ (void)showWithImage: (UIImage *)image
              message: (NSString *)message
               action: (NSString *)action
        actionHandler: (BWTipperSnackbarActionHandler)actionHandler
                delay: (NSTimeInterval)delay;


@end
