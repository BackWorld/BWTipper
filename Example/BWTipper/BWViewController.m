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
	
    UIImageView *iv = [[UIImageView alloc] initWithImage:[BWTipperConfigure.defaultConfigure iconWithStyle:BWTipperStyleSuccess]];
    iv.backgroundColor = UIColor.redColor;
    [self.view addSubview:iv];
    
    UIButton *label = [UIButton appearance];
    
    [label setTintColor:UIColor.redColor];
}

- (IBAction)changeTheme:(UISegmentedControl *)sender {
    
    BWTipperConfigure.defaultConfigure.theme = sender.selectedSegmentIndex;
}

- (IBAction)showHUD:(id)sender {
//    [BWTipper hudTest];
    [BWTipper hudWithImage:[UIImage imageNamed:@"check"] message:@"哈哈哈"];
}

@end
