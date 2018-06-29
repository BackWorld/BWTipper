//
//  BWTipperToast.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"

@interface BWTipperToast : BWTipperComponent

+ (void)showWithMessage: (NSString *)message delay: (NSTimeInterval)delay;

@end
