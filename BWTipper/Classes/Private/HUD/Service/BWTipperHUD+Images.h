//
//  BWTipperHUD+Images.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD.h"

@interface BWTipperHUD (Images)

+ (void)showWithImages: (NSArray<UIImage *> *)images
              duration: (NSTimeInterval)duration
                 delay: (NSTimeInterval)delay
               message: (NSString *)message
      backgroundDimmed: (BOOL)backgroundDimmed
      wrapperDisplayOn: (BOOL)wrapperDisplayOn;

@end
