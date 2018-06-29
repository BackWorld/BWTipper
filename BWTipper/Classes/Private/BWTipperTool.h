//
//  BWTipperTool.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <Foundation/Foundation.h>


#pragma mark - Defines


@interface BWTipperTool : NSObject

+ (UIImage *)bundleImage: (NSString *)name;

+ (UIImage *)image: (UIImage *)image withTintColor: (UIColor *)color;

+ (UIWindow *)tipperKeyWindow;

@end
