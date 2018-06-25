//
//  BWTipperHUD.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperHUD.h"
#import "BWTipperConfigure.h"



#pragma mark - BWTipperHUD
@interface BWTipperHUD()

#pragma mark - UI Properties
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

#pragma mark - Data Properties
@property(nonatomic, copy)BWTipperCompletion completion;
@property(nonatomic, readonly)CGFloat messageHeight;

@end

@implementation BWTipperHUD

#pragma mark - Intial

- (void)initData{
    [super initData];
    self.imageViewSize = CGSizeMake(60, 60);
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
    
    // 计算frame
    CGFloat space = 30;
    
    // wrapper
    CGFloat messageSize = self.messageHeight > 0 ? space + self.messageHeight : 0;
    CGFloat size = self.imageViewSize.height + space * 2 + messageSize;
    CGPoint center = CGPointMake(CGRectGetMidX(self.keyWindow.bounds), CGRectGetMidY(self.keyWindow.bounds));
    self.wrapperView.frame = CGRectMake(0, 0, size, size);
    self.wrapperView.center = center;
    
    // image view
    CGFloat y = space;
    CGFloat x = CGRectGetMidX(self.wrapperView.bounds) - self.imageViewSize.width / 2;
    self.imageView.frame = CGRectMake(x, y, self.imageViewSize.width, self.imageViewSize.height);
    
    // indicator view
    self.indicatorView.frame = self.imageView.frame;
    
    // message label
    if (self.messageHeight > 0) {
        y = CGRectGetMaxY(self.imageView.frame) + space;
        self.messageLabel.frame = CGRectMake(20, y, CGRectGetWidth(self.wrapperView.bounds) - 40, self.messageHeight);
    }
    
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
    
    self.imageViewSize = CGSizeMake(80, 80);
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
    self.imageViewSize = CGSizeMake(80, 80);
    self.imageView.hidden = YES;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    
    [BWTipperHUD showComponent:self];
    
    // 启动超时计时器
    if (timeout > 0) {
        [self performSelector:@selector(playHideAnimation) withObject:nil afterDelay:timeout];
    }
}

#pragma mark - Setters
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    if (userInteractionEnabled) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    }
    
    [super setUserInteractionEnabled:userInteractionEnabled];
}


#pragma mark - Getters
- (CGFloat)messageHeight{
    if (self.message.length > 0) {
        return 20;
    }
    return 0;
}

- (UIView *)wrapperView{
    UIView *view = [super wrapperView];
    [view addSubview:self.imageView];
    [view addSubview:self.indicatorView];
    
    [self setWrapperViewCornerRoundRadius:20];
    
    return view;
}

- (UILabel *)messageLabel{
    UILabel *label = [super messageLabel];
    label.textAlignment = NSTextAlignmentCenter;
    
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
