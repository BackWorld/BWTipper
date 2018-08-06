//
//  BWTipperHUD+Layout.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Layout.h"


#define kWrapperViewMinWidth 140.0f
#define kWrapperViewMaxWidth (CGRectGetWidth(kWindow.bounds) - 40.0f * 2)

#define kLayoutSpace20 20.0f
#define kLayoutSpace30 20.0f

#define kHasMessage (self.message.length > 0)


@implementation BWTipperHUD (Layout)


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.messageLabel.frame = CGRectZero;
    [self.messageLabel sizeToFit];
    
    // 计算frame
    CGFloat space = kLayoutSpace20;
    CGFloat wrapperW = kWrapperViewMinWidth;
    CGFloat messageW = CGRectGetWidth(self.messageLabel.bounds);
    
    if (messageW > wrapperW - 40) {
        wrapperW = messageW + 40;
        if (wrapperW > kWrapperViewMaxWidth) {
            wrapperW = kWrapperViewMaxWidth;
        }
    }
    CGFloat messageH = [self.messageLabel sizeThatFits:CGSizeMake(wrapperW, CGFLOAT_MAX)].height;
    
    // image view
    CGFloat imageY = kHasMessage
    ? space
    : (wrapperW / 2 - self.imageViewSize.height / 2);
    CGFloat imageX = wrapperW / 2 - self.imageViewSize.width / 2;
    self.imageView.frame = CGRectMake(imageX, imageY, self.imageViewSize.width, self.imageViewSize.height);
    
    // message label
    CGFloat messageY = CGRectGetMaxY(self.imageView.frame) + (kHasMessage ? space : 0);
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



- (CGSize)imageViewSize{
    if (self.imageView.animationImages.count > 0) {
        return CGSizeMake(100, 100);
    }
    return CGSizeMake(60, 60);
}


@end
