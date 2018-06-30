//
//  BWTipperHUD+Images.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Images.h"
#import "BWTipperConfigure.h"

@implementation BWTipperHUD (Images)

#pragma mark - Public
+ (void)showWithImages: (NSArray<UIImage *> *)images
              duration: (NSTimeInterval)duration
                 delay: (NSTimeInterval)delay
               message: (NSString *)message
      backgroundDimmed: (BOOL)backgroundDimmed
      wrapperDisplayOn: (BOOL)wrapperDisplayOn
{
    
    BWTipperHUD *hud = [self new];
    
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.delay = delay;
    hud.imagesAnimationDuration = duration;
    hud.images = images;
    
    if (!wrapperDisplayOn) {
        [hud clearWrapperViewBackgroundColor];
    }
    
    [hud show];
}

#pragma mark - Private



@end
