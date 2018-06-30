//
//  BWTipperHUD+Animation.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Animation.h"

@implementation BWTipperHUD (Animation)


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

- (void)removeFromSuperview{
    [super removeFromSuperview];
    
    if (self.completion) {
        self.completion();
    }
    
    self.isAnimating = NO;
}


@end
