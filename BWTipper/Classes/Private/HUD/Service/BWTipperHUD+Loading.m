//
//  BWTipperHUD+Loading.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Loading.h"
#import "BWTipperHUD+Images.h"

@implementation BWTipperHUD (Loading)


+ (void)showLoadingWithMessage: (NSString *)message
              backgroundDimmed: (BOOL)backgroundDimmed
                       timeout: (NSTimeInterval)timeout
{
    timeout = (timeout > 0 ? timeout : CGFLOAT_MAX);
    [self showWithImages:BWTipperConfigure.defaultConfigure.loadingIcons duration:1.5  delay:timeout message:message backgroundDimmed:backgroundDimmed wrapperDisplayOn:YES completion:nil];
}




@end
