//
//  BWTipperTool.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperTool.h"

#define kResourceBundle @"BWTipper.bundle"


NSString *const BWTipperStyleIconImageKeySuccess = @"BWTipperStyleIconImageKeySuccess";
NSString *const BWTipperStyleIconImageKeyError = @"BWTipperStyleIconImageKeyError";
NSString *const BWTipperStyleIconImageKeyInfo = @"BWTipperStyleIconImageKeyInfo";


@implementation BWTipperTool


#pragma mark - Private
+ (NSBundle *)frameworkBundle{
    return [NSBundle bundleForClass:self.class];
}

+ (NSBundle *)resourceBundle{
    NSString *path = [self.frameworkBundle.bundlePath stringByAppendingPathComponent:kResourceBundle];
    return [NSBundle bundleWithPath:path];
}

#pragma mark - Public

+ (UIWindow *)tipperKeyWindow{
    return UIApplication.sharedApplication.keyWindow;
}

+ (UIImage *)image:(UIImage *)image withTintColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    [color set];
    UIRectFill(rect);
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)bundleImage: (NSString *)name{
    NSString *imagePath = [self.resourceBundle pathForResource:name ofType:nil];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
