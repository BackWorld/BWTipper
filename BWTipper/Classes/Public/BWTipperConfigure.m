//
//  BWTipperConfigure.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperConfigure.h"
#import "BWTipperTool.h"

@implementation BWTipperConfigure

+ (instancetype)defaultConfigure{
    static dispatch_once_t onceToken;
    static id config = nil;
    dispatch_once(&onceToken, ^{
        config = [self new];
    });
    return config;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.theme = BWTipperThemeDark;
        self.cornerRoundOn = YES;
        self.shadowOn = NO;
        self.backgroundDimmedAlpha = 0.3;
    }
    return self;
}

#pragma mark - Public
- (UIColor *)themeRevertedColor{
    BOOL isDarkTheme = (self.theme == BWTipperThemeDark);
    return isDarkTheme ? UIColor.whiteColor : UIColor.blackColor;
}


#pragma mark - Setters

#pragma mark - Getters
- (NSArray *)defaultLoadingIcons{
    if (!_defaultLoadingIcons) {
        NSMutableArray *icons = [NSMutableArray new];
        for (int i=0; i<35; i++) {
            NSString *name = [NSString stringWithFormat:@"loading-%d.png", i];
            UIImage *image = [BWTipperTool bundleImage:name];
            image = [BWTipperTool image:image withTintColor:self.themeRevertedColor];
            [icons addObject:image];
        }
        _defaultLoadingIcons = [NSArray arrayWithArray:icons];
    }
    return _defaultLoadingIcons;
}

- (BWTipperImageAssset)styleIcons{
    if (!_styleIcons) {
        UIImage *success = [BWTipperTool bundleImage:@"success.png"];
        UIImage *error = [BWTipperTool bundleImage:@"error.png"];
        UIImage *info = [BWTipperTool bundleImage:@"info.png"];
        
        _styleIcons = @{BWTipperStyleIconImageKeySuccess: success,
                        BWTipperStyleIconImageKeyError: error,
                        BWTipperStyleIconImageKeyInfo: info
                        };
    }
    return _styleIcons;
}



@end
