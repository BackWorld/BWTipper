//
//  BWTipperHUD+Style.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD.h"

@interface BWTipperHUD (Style)

+ (void)showWithStyle: (BWTipperStyle)style
              message: (NSString *)message
     backgroundDimmed: (BOOL)backgroundDimmed
                delay: (NSTimeInterval)delay
           completion: (BWTipperCompletion)completion;


@end
