//
//  BWTipperConfigure+Private.h
//  BWTipper
//
//  Created by koolearn on 2018/6/29.
//

#import <BWTipper/BWTipper.h>

@interface BWTipperConfigure (Private)

- (UIImage *)iconWithStyle:(BWTipperStyle)style;

- (UIColor *)themeRevertedColor;

- (UIColor *)themeColor;

- (BOOL)isLightTheme;

@end
