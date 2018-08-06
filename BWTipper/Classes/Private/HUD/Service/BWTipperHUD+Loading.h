//
//  BWTipperHUD+Loading.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD.h"

@interface BWTipperHUD (Loading)


+ (void)showLoadingWithMessage: (NSString *)message
              backgroundDimmed: (BOOL)backgroundDimmed;


@end
