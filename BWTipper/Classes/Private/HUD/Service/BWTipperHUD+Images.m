//
//  BWTipperHUD+Images.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Images.h"

@implementation BWTipperHUD (Images)

#pragma mark - Public
+ (void)showWithImages: (NSArray<UIImage *> *)images
              duration: (NSTimeInterval)duration
                 delay: (NSTimeInterval)delay
               message: (NSString *)message
      backgroundDimmed: (BOOL)backgroundDimmed
      wrapperDisplayOn: (BOOL)wrapperDisplayOn
            completion: (BWTipperCompletion)completion
{
    
    BWTipperHUD *hud = [self new];
    
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.delay = delay;
    hud.imagesAnimationDuration = duration;
    hud.images = images;
    hud.completion = completion;
    
    if (!wrapperDisplayOn) {
        [hud clearWrapperViewBackgroundColor];
    }
    
    [hud show];
}



@end
