//
//  BWTipperHUD+Style.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Style.h"
#import "BWTipperHUD+Images.h"

@implementation BWTipperHUD (Style)

+ (void)showWithStyle: (BWTipperStyle)style
              message: (NSString *)message
     backgroundDimmed: (BOOL)backgroundDimmed
                delay: (NSTimeInterval)delay
           completion: (BWTipperCompletion)completion
{
    UIImage *icon = [BWTipperConfigure.defaultConfigure iconWithStyle:style];
    [self showWithImages:@[icon] duration: 0 delay:delay message:message backgroundDimmed:backgroundDimmed wrapperDisplayOn:YES];
}

@end
