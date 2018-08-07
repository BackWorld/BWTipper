//
//  BWTipperToast.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperToast.h"

@interface BWTipperToast()

#pragma mark - UI Properties

#pragma mark - Data Properties
@property(nonatomic, readonly)CGFloat messageHeight;

@end

@implementation BWTipperToast

#pragma mark - Lifecycle
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.messageLabel.frame = CGRectZero;
    [self.messageLabel sizeToFit];
    
    CGPoint center = kCenter;
    
    CGFloat offset = 50;
    CGFloat space = 30;
    CGSize messageSize = self.messageLabel.bounds.size;
    
    CGFloat maxWidth = CGRectGetWidth(kTipperKeyWindow.bounds) - 3 * offset;
    
    // 多行
    if (messageSize.width > maxWidth) {
        messageSize = [self.messageLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
        self.wrapperCornerRadius = 20;
    }
    // 单行
    else{
        self.wrapperCornerRadius = (messageSize.height + space) / 2;
    }
    
    CGFloat w = messageSize.width + offset;
    CGFloat h = messageSize.height + space;
    CGFloat x = CGRectGetWidth(kTipperKeyWindow.bounds) / 2 - w / 2;
    CGFloat y = CGRectGetHeight(kTipperKeyWindow.bounds) - h - 44 - 34;
    
    CGRect frame = CGRectMake(x, y, w, h);
    self.wrapperView.frame = frame;
    
    center = CGPointMake(CGRectGetMidX(self.wrapperView.bounds), CGRectGetMidY(self.wrapperView.bounds));
    self.messageLabel.frame = CGRectMake(0, 0, messageSize.width, messageSize.height);
    self.messageLabel.center = center;
    
    // 动画
    [self playDisplayAnimation];
}

#pragma mark - Public
+ (void)showWithMessage:(NSString *)message delay:(NSTimeInterval)delay{
    BWTipperToast *toast = [self new];
    toast.delay = delay;
    toast.message = message;
    
    [toast show];
}

#pragma mark - Overrides
- (void)playDisplayAnimation{
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    [UIView animateWithDuration:kDisplayAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
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

#pragma mark - Getters
- (UILabel *)messageLabel{
    UILabel *label = [super messageLabel];
    label.numberOfLines = 0;
    
    return label;
}

@end
