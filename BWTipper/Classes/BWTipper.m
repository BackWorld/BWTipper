//
//  BWTipper.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipper.h"

@implementation BWTipper

+ (void)load{
    [BWTipperConfigure defaultConfigure];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message{
    [self hudWithStyle:style message:message backgroundDimmed:NO delay:1.5 completion:nil];
}

+ (void)hudWithStyle:(BWTipperStyle)style message:(NSString *)message backgroundDimmed:(BOOL)backgroundDimmed delay:(NSTimeInterval)delay completion:(BWTipperCompletion)completion{
    [BWTipperHUD showWithStyle:style message:message backgroundDimmed:backgroundDimmed delay:delay completion:completion];
}

+ (void)hudWithImage:(UIImage *)image message:(NSString *)message{
    [self hudWithImage:image message:message backgroundDimmed:NO delay:1.5 completion:nil];
}

+ (void)hudWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion{
    [BWTipperHUD showWithImage:image message:message backgroundDimmed:backgroundDimmed delay:delay completion:completion];
}

+ (void)hudTest{
    [self hudWithStyle:1 message:@"数据请求失败，请重试"];
}

@end
