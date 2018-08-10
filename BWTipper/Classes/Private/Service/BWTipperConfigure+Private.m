//
//  BWTipperConfigure+Private.m
//  BWTipper
//
//  Created by koolearn on 2018/6/29.
//

#import "BWTipperConfigure+Private.h"
#import "BWTipperTool.h"

@implementation BWTipperConfigure (Private)

- (UIImage *)iconWithStyle:(BWTipperStyle)style{
    UIImage *image = nil;
    switch (style) {
        case BWTipperStyleSuccess:
            image = self.styleIcons[BWTipperStyleIconImageKeySuccess];
            break;
        case BWTipperStyleError:
            image = self.styleIcons[BWTipperStyleIconImageKeyError];
            break;
        case BWTipperStyleInfo:
            image = self.styleIcons[BWTipperStyleIconImageKeyInfo];
            break;
    }
    return [BWTipperTool image:image withTintColor:self.themeRevertedColor];
}

- (BOOL)isLightTheme{
    return (self.theme == BWTipperThemeLight);
}

- (UIColor *)themeColor{
    BOOL isDarkTheme = (self.theme == BWTipperThemeDark);
    return isDarkTheme ? UIColor.blackColor : UIColor.whiteColor;
}


@end
