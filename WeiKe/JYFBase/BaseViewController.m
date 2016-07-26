//
//  BaseViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/24.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
<UIGestureRecognizerDelegate>
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        return NO;
    }
    return YES;
}//有navi的话，statusBarStyle由navi管理，下面代码无效，我们需要设置barStyle来改变状态栏颜色。self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//但是如果我们设置navi.hidden的话，下面代码有效。

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)backLastView:(UIBarButtonItem *)sender {    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
