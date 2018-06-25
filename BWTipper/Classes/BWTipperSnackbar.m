//
//  BWTipperSnackbar.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperSnackbar.h"

#define kStatusBarHeight 20
#define kHeight (kStatusBarHeight + 68)

#define kAnimationFrameYFrom -kHeight
#define kAnimationFrameYTo 0


@interface BWTipperSnackbar()

@property(nonatomic, strong)UIButton *button;

@property(nonatomic)BWTipperSnackbarActionHandler actionHandler;

@end

@implementation BWTipperSnackbar

#pragma mark - Initial

- (void)initData{
    [super initData];
    self.imageViewSize = CGSizeMake(34, 34);
    self.userInteractionEnabled = YES;
}


#pragma mark - Public
+ (void)showWithStyle:(BWTipperStyle)style
              message:(NSString *)message
               action:(NSString *)action
        actionHandler:(BWTipperSnackbarActionHandler)actionHandler
                delay:(NSTimeInterval)delay{
    BWTipperSnackbar *bar = [BWTipperSnackbar new];
    
    bar.message = message;
    bar.image = [BWTipperConfigure.defaultConfigure iconWithStyle:style];
    bar.actionHandler = actionHandler;
    if (actionHandler && action.length > 0) {
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
    frame.size.height = kHeight;
    self.frame = frame;
    
    CGFloat space = 20;
    
    // wrapper view
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = kHeight;
    CGFloat contentH = kHeight - kStatusBarHeight;
    
    self.wrapperView.frame = self.frame;
    
    // image view
    CGFloat imageY = (contentH - self.imageViewSize.height) / 2 + kStatusBarHeight;
    self.imageView.frame = CGRectMake(space, imageY, self.imageViewSize.width, self.imageViewSize.height);
    
    // button
    CGFloat buttonW = CGRectGetWidth(self.button.bounds) ?: -space;
    CGFloat buttonX = w - buttonW - space;
    CGFloat buttonH = h - kStatusBarHeight;
    self.button.frame = CGRectMake(buttonX, kStatusBarHeight, buttonW, buttonH);
    
    // message label
    CGFloat messageW = w - space - self.imageViewSize.width - space - buttonW - space;
    CGFloat messageX = CGRectGetMaxX(self.imageView.frame) + space;
    CGSize messageSize = [self.messageLabel sizeThatFits:CGSizeMake(messageW, CGFLOAT_MAX)];
    CGFloat messageY = (contentH - messageSize.height) / 2 + kStatusBarHeight;
    self.messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageSize.height);
    
    [self playDisplayAnimation];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    
    self.isAnimating = NO;
    
    [self setStatusBarHidden:NO];
}

- (void)playDisplayAnimation{
    [self setStatusBarHidden:NO];
    
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    
    self.wrapperView.alpha = 1;
    
    CGRect frame = self.wrapperView.frame;
    frame.origin.y = kAnimationFrameYFrom;
    self.wrapperView.frame = frame;
    [UIView animateWithDuration:kDisplayAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.wrapperView.frame;
        frame.origin.y = kAnimationFrameYTo;
        self.wrapperView.frame = frame;
        
        [self setStatusBarHidden:YES];
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
        [self playHideAnimation];
    }
}

#pragma mark - Getters
- (UIView *)wrapperView{
    UIView *view = [super wrapperView];
    [view addSubview:self.imageView];
    [view addSubview:self.button];
    
    return view;
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
