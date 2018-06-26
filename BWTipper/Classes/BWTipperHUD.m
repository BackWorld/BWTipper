//
//  BWTipperHUD.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperHUD.h"
#import "BWTipperConfigure.h"

#define kWrapperViewMinWidth 140.0f
#define kWrapperViewMaxWidth (CGRectGetWidth(kWindow.bounds) - 40.0f * 2)

#define kLayoutSpace20 20.0f
#define kLayoutSpace30 20.0f

#define kHasMessage (self.message.length > 0)


#pragma mark - BWTipperHUD
@interface BWTipperHUD()

#pragma mark - UI Properties
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

#pragma mark - Data Properties
@property(nonatomic, copy)BWTipperCompletion completion;

@end

@implementation BWTipperHUD

#pragma mark - Intial
- (void)initData{
    [super initData];
    
    self.wrapperCornerRadius = 20;
}

#pragma mark - Public
+(void)showWithStyle:(BWTipperStyle)style
             message:(NSString *)message
    backgroundDimmed:(BOOL)backgroundDimmed
               delay:(NSTimeInterval)delay
          completion:(BWTipperCompletion)completion{
    BWTipperHUD *hud = [self new];
    
    hud.image = [BWTipperConfigure.defaultConfigure iconWithStyle:style];
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.completion = completion;
    hud.delay = delay;
    
    [self showComponent:hud];
}

+ (void)showWithImage: (UIImage *)image
             message: (NSString *)message
    backgroundDimmed: (BOOL)backgroundDimmed
               delay: (NSTimeInterval)delay
          completion: (BWTipperCompletion)completion{
    BWTipperHUD *hud = [self new];
    
    hud.image = image;
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.completion = completion;
    hud.delay = delay;
    
    [self showComponent:hud];
}

+ (void)showLoadingWithMessage:(NSString *)message backgroundDimmed: (BOOL)backgroundDimmed timeout:(NSTimeInterval)timeout{
    BWTipperHUD *hud = [self new];
    
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.delay = CGFLOAT_MAX;
    
    [hud showLoadingWithTimeout: timeout];
}

+ (void)showLoadingWithAnimatedImages:(NSArray<UIImage *> *)images
                             duration:(NSTimeInterval)duration
                              message:(NSString *)message
                     backgroundDimmed:(BOOL)backgroundDimmed
                              timeout:(NSTimeInterval)timeout{
    BWTipperHUD *hud = [self new];
    
    hud.userInteractionEnabled = backgroundDimmed;
    hud.message = message;
    hud.delay = CGFLOAT_MAX;
    
    [hud showLoadingWithAnimatedImages:images duration:duration timeout:timeout];
}

#pragma mark - Overrides
- (void)removeFromSuperview{
    [super removeFromSuperview];
    
    if (self.completion) {
        self.completion();
    }
    
    self.isAnimating = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.messageLabel.frame = CGRectZero;
    [self.messageLabel sizeToFit];
    
    // 计算frame
    CGFloat space = kLayoutSpace20;
    CGFloat wrapperW = kWrapperViewMinWidth;
    CGFloat messageW = CGRectGetWidth(self.messageLabel.bounds);
    CGFloat messageH = 0;
    
    if (messageW > kWrapperViewMaxWidth) {
        wrapperW = kWrapperViewMaxWidth;
        messageH = [self.messageLabel sizeThatFits:CGSizeMake(wrapperW, CGFLOAT_MAX)].height;
    }
    
    // image view
    CGFloat imageY = kHasMessage
    ? space
    : (wrapperW / 2 - self.imageViewSize.height / 2);
    CGFloat imageX = wrapperW / 2 - self.imageViewSize.width / 2;
    self.imageView.frame = CGRectMake(imageX, imageY, self.imageViewSize.width, self.imageViewSize.height);
    
    // indicator view
    self.indicatorView.frame = self.imageView.frame;
    
    // message label
    CGFloat messageY = CGRectGetMaxY(self.imageView.frame) + (kHasMessage ? 8 : 0);
    self.messageLabel.frame = CGRectMake(20, messageY, wrapperW - 40, messageH);
    
    // wrapper view
    CGFloat wrapperH = kHasMessage
    ? (CGRectGetMaxY(self.messageLabel.frame) + space)
    : wrapperW;
    
    self.wrapperView.frame = CGRectMake(0, 0, wrapperW, wrapperH);
    self.wrapperView.center = kCenter;
    
    // 动画
    [self playDisplayAnimation];
}

- (void)playDisplayAnimation{
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    self.wrapperView.transform = CGAffineTransformMakeScale(kAnimationScaleFrom, kAnimationScaleFrom);
    [UIView animateWithDuration:kDisplayAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.wrapperView.transform = CGAffineTransformMakeScale(kAnimationScaleTo, kAnimationScaleTo);
        self.wrapperView.alpha = 1;
    } completion:^(BOOL finished) {
        // 启动计时器
        [self performSelector:@selector(playHideAnimation) withObject:nil afterDelay:self.delay];
    }];
}

- (void)playHideAnimation{
    [UIView animateWithDuration:kHideAnimationDuration animations:^{
        self.wrapperView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private

- (void)showLoadingWithAnimatedImages:(NSArray<UIImage *> *)images
                             duration:(NSTimeInterval)duration
                              timeout:(NSTimeInterval)timeout{
    
    self.imageView.animationImages = images;
    self.imageView.animationDuration = duration;
    [self.imageView startAnimating];
    
    [BWTipperHUD showComponent:self];
    
    // 启动超时计时器
    if (timeout > 0) {
        [self performSelector:@selector(playHideAnimation) withObject:nil afterDelay:timeout];
    }
}

- (void)showLoadingWithTimeout: (NSTimeInterval)timeout{
    self.imageView.hidden = YES;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    
    [BWTipperHUD showComponent:self];
    
    // 启动超时计时器
    if (timeout > 0) {
        [self performSelector:@selector(playHideAnimation) withObject:nil afterDelay:timeout];
    }
}

- (BOOL)hasMessage{
    return self.message.length > 0;
}

#pragma mark - Setters
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    if (userInteractionEnabled) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    }
    
    [super setUserInteractionEnabled:userInteractionEnabled];
}

#pragma mark - Getters

- (CGSize)imageViewSize{
    if (self.imageView.animationImages.count > 0) {
        return CGSizeMake(100, 100);
    }
    return CGSizeMake(60, 60);
}

- (UIVisualEffectView *)wrapperView{
    UIVisualEffectView *view = [super wrapperView];
    
    [view.contentView addSubview:self.imageView];
    [view.contentView addSubview:self.indicatorView];
    
    return view;
}

- (UILabel *)messageLabel{
    UILabel *label = [super messageLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    
    return label;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        _indicatorView.color = BWTipperConfigure.defaultConfigure.themeRevertedColor;
        _indicatorView.hidden = YES;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}



@end
