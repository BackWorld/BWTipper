//
//  BWTipperTool.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <Foundation/Foundation.h>

#define kKeyWindow [BWTipperTool tipperKeyWindow]


#pragma mark - Defines


typedef enum : NSUInteger {
    BWTipperThemeDark, // 黑色
    BWTipperThemeLight // 白色
} BWTipperTheme;


typedef enum : NSUInteger {
    BWTipperAnimationStyleFade, // 淡入淡出
    BWTipperAnimationStyleZoom // 缩放
} BWTipperAnimationStyle;


typedef enum : NSUInteger {
    BWTipperStyleSuccess,
    BWTipperStyleError,
    BWTipperStyleInfo
} BWTipperStyle;

typedef NSDictionary<NSString *, UIImage *> * BWTipperImageAssset;

typedef void(^BWTipperCompletion)(void);

extern NSString *const BWTipperStyleIconImageKeySuccess;
extern NSString *const BWTipperStyleIconImageKeyError;
extern NSString *const BWTipperStyleIconImageKeyInfo;





@interface BWTipperTool : NSObject

+ (UIImage *)bundleImage: (NSString *)name;

+ (UIImage *)image: (UIImage *)image withTintColor: (UIColor *)color;

+ (UIWindow *)tipperKeyWindow;

@end
