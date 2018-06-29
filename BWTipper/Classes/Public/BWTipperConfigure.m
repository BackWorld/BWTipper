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
        self.shadowOn = YES;
    }
    return self;
}

#pragma mark - Public

#pragma mark - Setters

#pragma mark - Getters
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
