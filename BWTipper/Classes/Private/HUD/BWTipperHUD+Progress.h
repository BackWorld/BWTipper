//
//  BWTipperHUD+Progress.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD.h"

@interface BWTipperHUD (Progress)




+ (void)showLoadingWithProgressing: (void(^)(BWTipperHUDLoadingProgressHandler handler))progressHandler
                  backgroundDimmed: (BOOL)backgroundDimmed;

@end
