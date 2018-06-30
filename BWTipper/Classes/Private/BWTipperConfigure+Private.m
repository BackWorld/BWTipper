//
//  BWTipperConfigure+Private.m
//  BWTipper
//
//  Created by koolearn on 2018/6/29.
//

#import "BWTipperConfigure+Private.h"
#import "BWTipperTool.h"

@implementation BWTipperConfigure (Private)

- (NSArray<UIImage *> *)loadingIcons{
    NSMutableArray *icons = [NSMutableArray new];
    for (int i=0; i<35; i++) {
        NSString *name = [NSString stringWithFormat:@"loading-%d.png", i];
        UIImage *image = [BWTipperTool bundleImage:name];
        image = [BWTipperTool image:image withTintColor:self.themeRevertedColor];
        [icons addObject:image];
    }
    return icons;
}

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

- (UIColor *)themeRevertedColor{
    BOOL isDarkTheme = (self.theme == BWTipperThemeDark);
    return isDarkTheme ? UIColor.whiteColor : UIColor.blackColor;
}

- (UIColor *)themeColor{
    BOOL isDarkTheme = (self.theme == BWTipperThemeDark);
    return isDarkTheme ? UIColor.blackColor : UIColor.whiteColor;
}


@end
