//
//  BWViewController.m
//  BWTipper
//
//  Created by 1906457616@qq.com on 06/24/2018.
//  Copyright (c) 2018 1906457616@qq.com. All rights reserved.
//

#import "BWViewController.h"
#import <BWTipper/BWTipper.h>

@interface BWViewController ()

@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}




- (IBAction)showDialog:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试对话框" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [self showHUD:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIApplication.sharedApplication.keyWindow endEditing:YES];
}

- (IBAction)dismiss:(id)sender {
    [BWTipper dismiss];
}


float progress;
- (IBAction)showProgress:(UISegmentedControl *)sender{
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        progress += 0.01;
        
        [BWTipper hudLoadingWithProgressing:^(BWTipperHUDLoadingProgressHandler handler) {
            handler(0.1, [NSString stringWithFormat:@"%.f %%", (100 * progress)]);
        } backgroundDimmed:YES];
        
        if (progress >= 1) {
            progress = 0;
            [timer invalidate];
            [BWTipper dismiss];
        }
    }];
}

- (IBAction)changeTheme:(UISegmentedControl *)sender {
    
    BWTipperConfigure.defaultConfigure.theme = sender.selectedSegmentIndex;
    
//    BWTipperConfigure.defaultConfigure.shadowOn = sender.selectedSegmentIndex;
    
//    BWTipperConfigure.defaultConfigure.cornerRoundOn = !sender.selectedSegmentIndex;
}


- (IBAction)showToast:(id)sender {
    [BWTipper toastWithMessage:@"提交成功"];
//    [BWTipper toastWithMessage:@"LongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToastLongToastToastToast" delay:10];
}


- (IBAction)showHUD:(id)sender {
//    [BWTipper hudWithStyle:BWTipperStyleSuccess];
    
//    [BWTipper hudLoadingWithMessage:nil backgroundDimmed:NO];
    
//    return;
//    BWTipperConfigure.defaultConfigure.backgroundDimmedAlpha = 0.8;
    NSMutableArray *images = [NSMutableArray new];
    for (int i=3; i>=0; i--) {
        NSString *icon = [NSString stringWithFormat:@"number-%d.png", i];
        [images addObject:[UIImage imageNamed:icon]];
    }
    [BWTipper hudLoadingWithAnimatedImages:images duration:0.5 message:nil backgroundDimmed:YES wrapperDisplayOn:NO timeout:2];
}

- (IBAction)showSnackbar:(id)sender {
//    [BWTipper snackbarWithStyle:BWTipperStyleError message:@"网络已断开连接" action:@"去检查" actionHandler:^(NSString *action) {
//        NSLog(@"you tapped: %@", action);
//    }];
    
//    [BWTipper snackbarWithStyle:BWTipperStyleSuccess message:@"Congratulations!"];
    
    [BWTipper snackbarWithImage:[UIImage imageNamed:@"check.png"] message:@"这是一个带有自定义图片的通知LongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessage" action:@"OK" actionHandler:nil];
}

@end
