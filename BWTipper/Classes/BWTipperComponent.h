//
//  BWTipperComponent.h
//  BWTipper
//
//  Created by zhuxuhong on 2018/6/24.
//

#import <UIKit/UIKit.h>
#import "BWTipperTool.h"

@interface BWTipperComponent : UIView

@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UILabel *messageLabel;

@property(nonatomic, copy)NSString *message;

+ (void)dismissWithAnimated: (BOOL)animated;

- (void)show;

- (void)playDisplayAnimation;

- (void)playHideAnimation;

@end
