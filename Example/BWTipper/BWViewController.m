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

- (IBAction)dismiss:(id)sender {
    [BWTipper dismiss];
}

- (IBAction)changeTheme:(UISegmentedControl *)sender {
    
    BWTipperConfigure.defaultConfigure.theme = sender.selectedSegmentIndex;
    
    BWTipperConfigure.defaultConfigure.shadowOn = sender.selectedSegmentIndex;
    
    BWTipperConfigure.defaultConfigure.cornerRoundOn = !sender.selectedSegmentIndex;
}

- (IBAction)showHUD:(id)sender {
//    [BWTipper hudTest];
    [BWTipper hudWithStyle:BWTipperStyleSuccess];
//    [BWTipper hudLoadingWithMessage:nil backgroundDimmed:YES timeout:5];
    
    
    NSMutableArray *images = [NSMutableArray new];
    for (int i=3; i>=0; i--) {
        NSString *icon = [NSString stringWithFormat:@"number-%d.png", i];
        [images addObject:[UIImage imageNamed:icon]];
    }
    [BWTipper hudLoadingWithAnimatedImages:images duration:0.5];
}

@end
