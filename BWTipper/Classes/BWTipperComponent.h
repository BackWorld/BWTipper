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

#pragma mark - Data
@property(nonatomic)BOOL isAnimating;
@property(nonatomic)NSTimeInterval delay;
@property(nonatomic, copy)NSString *message;
@property(nonatomic, copy)BWTipperCompletion completion;

@property(nonatomic, strong, readonly)UIWindow *keyWindow;

- (void)initData;

- (void)addViews;

+ (void)dismissWithAnimated: (BOOL)animated;

- (void)show;

- (void)playDisplayAnimation;

- (void)playHideAnimation;

- (void)setWrapperViewCornerRoundRadius: (CGFloat)radius;

@end
