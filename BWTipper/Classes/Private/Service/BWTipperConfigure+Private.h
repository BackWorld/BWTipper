//
//  BWTipperConfigure+Private.h
//  BWTipper
//
//  Created by koolearn on 2018/6/29.
//

#import "BWTipperTool.h"
#import "BWTipperConfigure.h"

@interface BWTipperConfigure (Private)

- (UIImage *)iconWithStyle:(BWTipperStyle)style;

- (UIColor *)themeColor;

- (UIColor *)themeRevertedColor;

- (BOOL)isLightTheme;

@end
