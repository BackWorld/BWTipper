//
//  BWTipperDefines.h
//  BWTipper
//
//  Created by koolearn on 2018/6/29.
//

#ifndef BWTipperHeader_h
#define BWTipperHeader_h



typedef NSDictionary<NSString *, UIImage *> * BWTipperImageAssset;

typedef void(^BWTipperCompletion)(void);

extern NSString *const BWTipperStyleIconImageKeySuccess;
extern NSString *const BWTipperStyleIconImageKeyError;
extern NSString *const BWTipperStyleIconImageKeyInfo;

typedef void(^BWTipperSnackbarActionHandler)(NSString *action);

typedef void(^BWTipperHUDLoadingProgressHandler)(CGFloat progress, NSString *text);

typedef enum : NSUInteger {
    BWTipperThemeDark, // 黑色
    BWTipperThemeLight // 白色
} BWTipperTheme;


typedef enum : NSUInteger {
    BWTipperStyleSuccess, // 成功
    BWTipperStyleError, // 错误
    BWTipperStyleInfo // 提示
} BWTipperStyle;


#endif /* BWTipperHeader_h */
