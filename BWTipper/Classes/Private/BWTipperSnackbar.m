//
//  BWTipperSnackbar.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperSnackbar.h"

#define kIsIphoneX (CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame) == 44)

#define kIsLandscape UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)

// 精细化调整
#define kStatusBarHeight (kIsLandscape ? 0 : (kIsIphoneX ? 30 : 20))
#define kWrapperViewHeight (kIsLandscape ? 44 : (kStatusBarHeight + (kIsIphoneX ? 58 : 44)))

#define kAnimationFrameYFrom (-kWrapperViewHeight)
#define kAnimationFrameYTo 0

@interface BWTipperSnackbar()

@property(nonatomic, strong)UIButton *button;

@property(nonatomic)BWTipperSnackbarActionHandler actionHandler;

@property(nonatomic)UIStatusBarStyle originalStatusBarStyle;

@end

@implementation BWTipperSnackbar

#pragma mark - Initial

- (void)initData{
    [super initData];
    self.userInteractionEnabled = YES;
}


#pragma mark - Public
+ (void)showWithStyle:(BWTipperStyle)style
              message:(NSString *)message
               action:(NSString *)action
        actionHandler:(BWTipperSnackbarActionHandler)actionHandler
                delay:(NSTimeInterval)delay{
    
    [self showWithImage:[BWTipperConfigure.defaultConfigure iconWithStyle:style] message:message action:action actionHandler:actionHandler delay:delay];
}

+ (void)showWithImage:(UIImage *)image
              message:(NSString *)message
               action:(NSString *)action
        actionHandler:(BWTipperSnackbarActionHandler)actionHandler
                delay:(NSTimeInterval)delay{
    BWTipperSnackbar *bar = [BWTipperSnackbar new];
    
    bar.message = message;
    bar.imageView.image = image;
    bar.actionHandler = actionHandler;
    bar.delay = delay;
    if (action.length > 0) {
        bar.delay = CGFLOAT_MAX;
        bar.button.hidden = NO;
        [bar.button setTitle:action forState:UIControlStateNormal];
        [bar.button sizeToFit];
    }
    
    [bar show];
}

#pragma mark - Overrides

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // self frame
    CGRect frame = self.frame;
    frame.size.height = kWrapperViewHeight;
    self.frame = frame;
    
    CGFloat space = 20;
    
    // wrapper view
    CGFloat w = CGRectGetWidth(frame);
    CGFloat h = kWrapperViewHeight;
    CGFloat contentH = kWrapperViewHeight - kStatusBarHeight;
    self.wrapperView.frame = frame;
    
    // image view
    CGFloat imageY = (contentH - self.imageViewSize.height) / 2 + kStatusBarHeight;
    self.imageView.frame = CGRectMake(space, imageY, self.imageViewSize.width, self.imageViewSize.height);
    
    // button
    CGFloat buttonW = CGRectGetWidth(self.button.bounds) ?: -space;
    CGFloat buttonX = w - buttonW - space;
    CGFloat buttonH = h - kStatusBarHeight;
    self.button.frame = CGRectMake(buttonX, kStatusBarHeight, buttonW, buttonH);
    
    // message label
    CGFloat messageX = CGRectGetMaxX(self.imageView.frame) + space;
    CGFloat messageW = w - messageX - space - buttonW - space;
    CGSize messageSize = [self.messageLabel sizeThatFits:CGSizeMake(messageW, CGFLOAT_MAX)];
    CGFloat messageY = (contentH - messageSize.height) / 2 + kStatusBarHeight;
    self.messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageSize.height);
    
    [self playDisplayAnimation];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    
    self.isAnimating = NO;
    
    [UIApplication.sharedApplication setStatusBarStyle:self.originalStatusBarStyle];
}

- (void)playDisplayAnimation{
    self.originalStatusBarStyle = UIApplication.sharedApplication.statusBarStyle;
    
    UIStatusBarStyle style = BWTipperConfigure.defaultConfigure.isLightTheme
    ? UIStatusBarStyleDefault
    : UIStatusBarStyleLightContent;
    [UIApplication.sharedApplication setStatusBarStyle:style];
    
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    CGRect frame = self.wrapperView.frame;
    frame.origin.y = kAnimationFrameYFrom;
    self.wrapperView.frame = frame;
    [UIView animateWithDuration:kDisplayAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.wrapperView.frame;
        frame.origin.y = kAnimationFrameYTo;
        self.wrapperView.frame = frame;
    } completion:^(BOOL finished) {
        // 启动计时器
        [self performSelector:@selector(playHideAnimation) withObject:nil afterDelay:self.delay];
    }];
}

- (void)playHideAnimation{
    [UIView animateWithDuration:kDisplayAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.wrapperView.frame;
        frame.origin.y = kAnimationFrameYFrom;
        self.wrapperView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private
- (void)buttonAction: (UIButton *)sender{
    if (self.actionHandler) {
        self.actionHandler(sender.currentTitle);
    }
    [self playHideAnimation];
}

#pragma mark - Setters
- (void)setDelay:(NSTimeInterval)delay{
    super.delay = delay ?: 1.5;
}

#pragma mark - Getters

- (CGSize)imageViewSize{
    return CGSizeMake(26, 26);
}

- (UIView *)wrapperView{
    UIView *view = [super wrapperView];
    view.alpha = 1;
    
    [view addSubview:self.imageView];
    [view addSubview:self.button];
    
    return view;
}

- (UILabel *)messageLabel{
    UILabel *label = [super messageLabel];
    label.numberOfLines = 2;
    
    return label;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _button.hidden = YES;
        _button.tintColor = BWTipperConfigure.defaultConfigure.themeRevertedColor;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
