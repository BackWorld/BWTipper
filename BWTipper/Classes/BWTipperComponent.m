//
//  BWTipperComponent.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperComponent.h"
#import "BWTipperConfigure.h"

@implementation BWTipperComponent

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:kKeyWindow.bounds]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+ (void)dismissWithAnimated: (BOOL)animated{
    for (UIView *subview in kKeyWindow.subviews) {
        if ([subview isKindOfClass:self.class]) {
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

- (void)show{
    // 移除其它
    [BWTipperComponent dismissWithAnimated:NO];
    
    // 添加当前
    [kKeyWindow addSubview:self];
}

#pragma mark - Setters

- (void)setMessage:(NSString *)message{
    self.messageLabel.text = message;
    
    _message = message;
}

#pragma mark - Getters
- (UIView *)wrapperView{
    if (!_wrapperView) {
        _wrapperView = [UIView new];
        _wrapperView.backgroundColor = BWTipperConfigure.defaultConfigure.themeColor;
        _wrapperView.alpha = 0;
        
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

@end
