//
//  BWTipperConfigure.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <Foundation/Foundation.h>
#import "BWTipperHUD.h"
#import "BWTipperToast.h"
#import "BWTipperSnackbar.h"
#import "BWTipperTool.h"


@interface BWTipperConfigure : NSObject


#pragma mark - Properties
/**
 主题样式
 */
@property(nonatomic)BWTipperTheme theme;

/**
 BWTipper style icons
 */
@property(nonatomic, strong)BWTipperImageAssset styleIcons;

/**
 是否显示阴影
 */
@property(nonatomic)BOOL shadowOn;


/**
 是否圆角显示
 */
@property(nonatomic)BOOL cornerRoundOn;


#pragma mark - Method

/**
 单例

 @return 单例
 */
+ (instancetype)defaultConfigure;


- (UIImage *)iconWithStyle:(BWTipperStyle)style;

- (UIColor *)themeRevertedColor;

- (UIColor *)themeColor;


@end
