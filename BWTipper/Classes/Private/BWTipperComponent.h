//
//  BWTipperComponent.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <UIKit/UIKit.h>
#import "BWTipperTool.h"
#import "BWTipperConfigure.h"
#import "BWTipperConfigure+Private.h"

#define kDisplayAnimationDuration 0.3f
#define kHideAnimationDuration 0.2f
#define kAnimationScaleFrom 0.8f
#define kAnimationScaleTo 1.0f

#define kWindow [BWTipperTool tipperKeyWindow]
#define kCenter CGPointMake(CGRectGetMidX(kWindow.bounds), CGRectGetMidY(kWindow.bounds))

@interface BWTipperComponent : UIView

#pragma mark - UI
@property(nonatomic, strong)UIVisualEffectView *wrapperView;
@property(nonatomic, strong)UILabel *messageLabel;
@property(nonatomic, strong)UIImageView *imageView;

#pragma mark - Data
@property(nonatomic, readonly)CGSize imageViewSize;
@property(nonatomic)CGFloat wrapperCornerRadius;
@property(nonatomic, copy)NSString *message;
@property(nonatomic)NSTimeInterval delay;

@property(nonatomic)BOOL isAnimating;
@property(nonatomic, strong, readonly)UIWindow *keyWindow;

- (void)show;

+ (void)dismissComponentByClass: (Class)componentClass
                       animated: (BOOL)animated;

- (void)initData;

- (void)addViews;

- (void)playDisplayAnimation;

- (void)playHideAnimation;

- (void)clearWrapperViewBackgroundColor;

@end
