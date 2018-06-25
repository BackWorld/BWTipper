//
//  BWTipperComponent.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <UIKit/UIKit.h>
#import "BWTipperTool.h"
#import "BWTipperConfigure.h"

#define kDisplayAnimationDuration 0.3f
#define kHideAnimationDuration 0.2f
#define kAnimationScaleFrom 0.8f
#define kAnimationScaleTo 1.0f

@interface BWTipperComponent : UIView

#pragma mark - UI
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UILabel *messageLabel;
@property(nonatomic, strong)UIImageView *imageView;

#pragma mark - Data
@property(nonatomic)CGSize imageViewSize;
@property(nonatomic, copy)NSString *message;
@property(nonatomic, strong)UIImage *image;
@property(nonatomic)NSTimeInterval delay;

@property(nonatomic)BOOL isAnimating;
@property(nonatomic, strong, readonly)UIWindow *keyWindow;

+ (void)showComponent: (BWTipperComponent *)component;

+ (void)dismissComponentByClass: (Class)componentClass
                       animated: (BOOL)animated;

- (void)initData;

- (void)addViews;

- (void)playDisplayAnimation;

- (void)playHideAnimation;

- (void)setWrapperViewCornerRoundRadius: (CGFloat)radius;

- (void)setStatusBarHidden: (BOOL)hide;

@end
