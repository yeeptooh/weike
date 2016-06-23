//
//  ScanCodeViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/1.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "MBProgressHUD.h"
@interface ScanCodeViewController ()
@end

@implementation ScanCodeViewController

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
 
    }
    return _bgView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgView];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIButton  *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 60, 40);
    [backButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [backButton setTitleColor:color(170, 170, 170, 1) forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_light"] forState:UIControlStateNormal];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    
    
    
    UIBarButtonItem  *backItem =[[UIBarButtonItem alloc]initWithCustomView: backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title = @"扫一扫";
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)backLastView:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
