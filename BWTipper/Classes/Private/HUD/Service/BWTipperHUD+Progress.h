//
//  BWTipperHUD+Progress.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD.h"

@interface BWTipperHUD (Progress)


+ (void)showLoadingWithProgress: (CGFloat)progress
                   progressText: (NSString *)progressText
               backgroundDimmed: (BOOL)backgroundDimmed;

@end
