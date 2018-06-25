//
//  BWTipperComponent.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"

@implementation BWTipperComponent

#pragma mark - Intial

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

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
    self.userInteractionEnabled = NO;
    self.delay = 1.5;
}

- (void)addViews{
    [self addSubview:self.wrapperView];
}

#pragma mark - Interface
+ (void)showComponent: (BWTipperComponent *)component{
    // 移除其它
    [BWTipperComponent dismissComponentByClass:component.class animated:NO];
    
    // 添加当前
    [BWTipperTool.tipperKeyWindow addSubview:component];
}

- (void)playDisplayAnimation{
    
}

- (void)playHideAnimation{
    
}

- (void)setWrapperViewCornerRoundRadius:(CGFloat)radius{
    if (BWTipperConfigure.defaultConfigure.cornerRoundOn) {
        _wrapperView.layer.cornerRadius = radius;
    }
}

- (void)setStatusBarHidden: (BOOL)hide{
    [UIApplication.sharedApplication setStatusBarHidden:hide withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Lifecycle
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = self.keyWindow.bounds;
}

#pragma mark - Private
+ (void)dismissComponentByClass: (Class)componentClass animated: (BOOL)animated{
    for (UIView *subview in BWTipperTool.tipperKeyWindow.subviews) {
        if ([subview isKindOfClass:componentClass]) {
            if (animated) {
                BWTipperComponent *component = (BWTipperComponent *)subview;
                [component playHideAnimation];
            }
            else{
                [subview removeFromSuperview];
            }
        }
    }
}

#pragma mark - Setters
- (void)setImage:(UIImage *)image{
    self.imageView.image = image;
    
    _image = image;
}

- (void)setDelay:(NSTimeInterval)delay{
    _delay = delay ?: 1.0;
}

- (void)setMessage:(NSString *)message{
    self.messageLabel.text = message;
    [self.messageLabel sizeToFit];
    
    _message = message;
}

#pragma mark - Getters

- (UIWindow *)keyWindow{
    return [BWTipperTool tipperKeyWindow];
}

- (UIView *)wrapperView{
    if (!_wrapperView) {
        _wrapperView = [UIView new];
        _wrapperView.backgroundColor = BWTipperConfigure.defaultConfigure.themeColor;
        _wrapperView.alpha = 0;
        
        [_wrapperView addSubview:self.messageLabel];
        
        if (BWTipperConfigure.defaultConfigure.shadowOn) {
            _wrapperView.layer.shadowOffset = CGSizeZero;
            _wrapperView.layer.shadowOpacity = 0.3;
            _wrapperView.layer.shadowRadius = 8;
        }
    }
    return _wrapperView;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = BWTipperConfigure.defaultConfigure.themeRevertedColor;
    }
    return _messageLabel;
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
