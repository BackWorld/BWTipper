//
//  BWTipperConfigure.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <Foundation/Foundation.h>
#import "BWTipperDefines.h"


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
 默认的loading icons
 */
@property(nonatomic, copy)NSArray<UIImage *> *defaultLoadingIcons;


/**
 是否显示阴影
 */
@property(nonatomic)BOOL shadowOn;


/**
 是否圆角显示
 */
@property(nonatomic)BOOL cornerRoundOn;


/**
 蒙层透明度
 */
@property(nonatomic)CGFloat backgroundDimmedAlpha;


#pragma mark - Method

/**
 单例

 @return 单例
 */
+ (instancetype)defaultConfigure;


@end
