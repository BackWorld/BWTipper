//
//  BWTipperHUD.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"


@interface BWTipperHUD : BWTipperComponent


#pragma mark - UI Properties

#pragma mark - Data Properties
@property(nonatomic, strong)NSArray<UIImage *> *images;
@property(nonatomic, copy)BWTipperCompletion completion;
@property(nonatomic)NSTimeInterval imagesAnimationDuration;


@end
