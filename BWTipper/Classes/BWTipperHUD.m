//
//  BWTipperHUD.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperHUD.h"
#import "BWTipperConfigure.h"


#define kDisplayAnimationDuration 0.3f
#define kHideAnimationDuration 0.2f
#define kAnimationScaleFrom 0.8f
#define kAnimationScaleTo 1.0f


#pragma mark - BWTipperHUD
@interface BWTipperHUD()

#pragma mark - UI Properties
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

#pragma mark - Data Properties
@property(nonatomic)NSTimeInterval delay;
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, copy)BWTipperCompletion completion;

@property(nonatomic)CGSize imageViewSize;
@property(nonatomic, readonly)CGFloat messageHeight;
@property(nonatomic)BOOL isAnimating;

@end

@implementation BWTipperHUD

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialSettings];
    }
    return self;
}

- (void)initialSettings{
    [self initData];
    [self addViews];
}

- (void)initData{
    self.imageViewSize = CGSizeMake(60, 60);
    self.delay = 1.5;
}

- (void)addViews{
    [self addSubview:self.wrapperView];
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
    
    [hud show];
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
    
    [hud show];
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
    CGPoint center = CGPointMake(CGRectGetMidX(kKeyWindow.bounds), CGRectGetMidY(kKeyWindow.bounds));
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


#pragma mark - Setters
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    if (userInteractionEnabled) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    }
    
    [super setUserInteractionEnabled:userInteractionEnabled];
}

- (void)setImage:(UIImage *)image{
    self.imageView.image = image;
    
    _image = image;
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
    [view addSubview:self.messageLabel];
    
    if (BWTipperConfigure.defaultConfigure.cornerRoundOn) {
        view.layer.cornerRadius = 20;
    }
    
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
        _indicatorView.tintColor = BWTipperConfigure.defaultConfigure.themeRevertedColor;
        _indicatorView.hidden = YES;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}


@end
