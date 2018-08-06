//
//  BWTipperHUD+Progress.m
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/30.
//

#import "BWTipperHUD+Progress.h"

@interface BWTipperHUD()

@property(nonatomic, strong)CAShapeLayer *progressLayer;

@end

@implementation BWTipperHUD (Progress)


+ (instancetype)sharedHUD{
    static dispatch_once_t onceToken;
    static BWTipperHUD *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

static BWTipperHUD *hud;

+ (void)showLoadingWithProgress: (CGFloat)progress
                   progressText: (NSString *)progressText
               backgroundDimmed: (BOOL)backgroundDimmed{
    if (hud == nil) {
        hud = [self new];
    }
    
    hud.message = progressText;
    hud.delay = CGFLOAT_MAX;
    hud.userInteractionEnabled = backgroundDimmed;
    
    [hud showWithProgress:progress];
}

#pragma mark - Private
- (void)showWithProgress:(CGFloat)progress{
    if ([self isFirstBuild]) {
        [self.imageView.layer addSublayer:self.progressLayer];
        [super show];
    }
    if (progress >= 1) {
        [self playHideAnimation];
        hud = nil;
        return;
    }
    self.progressLayer.strokeEnd = progress;
    [self setNeedsLayout];
}

- (BOOL)isFirstBuild{
    return self.shapeLayer == nil;
}

- (CAShapeLayer *)shapeLayer{
    CAShapeLayer *shape = nil;
    for (CALayer *sublayer in self.imageView.layer.sublayers) {
        if ([sublayer isKindOfClass:CAShapeLayer.class]) {
            shape = (CAShapeLayer *)sublayer;
            break;
        }
    }
    return shape;
}


- (CAShapeLayer *)progressLayer{
    CAShapeLayer *shape = self.shapeLayer;
    if (!shape) {
        shape = [CAShapeLayer layer];
        CAShapeLayer *outlineShape = [CAShapeLayer layer];
        
        [self commonSetShapeLayer:outlineShape strokeColorAlpha:0.1];
        [self commonSetShapeLayer:shape strokeColorAlpha:1];
        
        // 外轮廓
        CGFloat lineW = 4;
        CGFloat w = self.imageViewSize.width;
        CGFloat radius = w / 2 - lineW;
        CGRect rect = CGRectMake(0, 0, w, w);
        
        UIBezierPath *outlinePath = [UIBezierPath bezierPathWithOvalInRect: CGRectInset(rect, lineW, lineW)];
        outlineShape.path = outlinePath.CGPath;
        
        // 进度
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w / 2, w / 2) radius:radius startAngle:-M_PI_2 endAngle:3 * M_PI_2 clockwise:YES];
        shape.path = path.CGPath;
        shape.strokeEnd = 0;
        
        [shape addSublayer:outlineShape];
    }
    return shape;
}

- (void)commonSetShapeLayer: (CAShapeLayer *)layer strokeColorAlpha: (CGFloat)alpha{
    layer.fillColor = nil;
    layer.strokeColor = [BWTipperConfigure.defaultConfigure.themeRevertedColor colorWithAlphaComponent:alpha].CGColor;
    layer.lineWidth = 4;
    layer.lineCap = kCALineCapRound;
}

@end
