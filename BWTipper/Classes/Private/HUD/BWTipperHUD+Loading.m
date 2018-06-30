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
{
    [self showWithImages:BWTipperConfigure.defaultConfigure.loadingIcons duration:1.5  delay:CGFLOAT_MAX message:message backgroundDimmed:backgroundDimmed wrapperDisplayOn:YES];
}




@end
