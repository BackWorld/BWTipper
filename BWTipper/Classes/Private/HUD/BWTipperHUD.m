//
//  BWTipperHUD.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import "BWTipperHUD.h"
#import "BWTipperConfigure.h"
#import "BWTipperHUD+Layout.h"
#import "BWTipperHUD+Animation.h"


@implementation BWTipperHUD

#pragma mark - Intial
- (void)initData{
    [super initData];
    
    self.wrapperCornerRadius = 20;
}

#pragma mark - Public

#pragma mark - Overrides

#pragma mark - Private

#pragma mark - Setters
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    if (userInteractionEnabled) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:BWTipperConfigure.defaultConfigure.backgroundDimmedAlpha];
    }
    
    [super setUserInteractionEnabled:userInteractionEnabled];
}

- (void)setImages:(NSArray<UIImage *> *)images{
    if (images.count == 1) {
        self.imageView.image = images.firstObject;
    }
    else if (images.count > 1){
        self.imageView.animationImages = images;
        self.imageView.animationDuration = self.imagesAnimationDuration;
        [self.imageView startAnimating];
    }
    
    _images = images;
}

#pragma mark - Getters
- (UIView *)wrapperView{
    UIView *view = [super wrapperView];
    
    [view addSubview:self.imageView];
    return view;
}

- (UILabel *)messageLabel{
    UILabel *label = [super messageLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize:label.font.pointSize];
    
    return label;
}




@end
