//
//  BWTipperHUD+Progress.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Progress.h"

@implementation BWTipperHUD (Progress)

+ (void)showLoadingWithProgressing:(void (^)(BWTipperHUDLoadingProgressHandler))progressHandler backgroundDimmed:(BOOL)backgroundDimmed{
    
    BWTipperHUD *hud = [self new];
    
    hud.delay = CGFLOAT_MAX;
    hud.userInteractionEnabled = backgroundDimmed;
    BWTipperHUDLoadingProgressHandler handler = ^(CGFloat progress, NSString *text){
        hud.message = text;
    };
    
    progressHandler(handler);
}



@end
