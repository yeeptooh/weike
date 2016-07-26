//
//  InformationViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "InformationViewController.h"
#import "UserModel.h"
#import "LoginViewController.h"

#import "AppDelegate.h"
@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    [self setWebview];
    
}

//导航栏
- (void)setNavigationBar {
    
    self.navigationItem.title = @"我的信息";
}

- (void)setWebview {
    
    self.webView.frame = CGRectMake(0, 0, Width ,Height- StatusBarAndNavigationBarHeight - 50);
    self.webView.scrollView.scrollEnabled = NO;
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=user&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    CGRect Frame = CGRectMake(0, Height - StatusBarAndNavigationBarHeight - 50, Width, 50);
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:Frame];
    backButton.backgroundColor = color(59, 165, 249, 1);
//    backButton.layer.cornerRadius = 5;
//    backButton.layer.masksToBounds = YES;
    [backButton setTitle:@"退出登录" forState:0];
//    [backButton setTitleColor:[UIColor whiteColor] forState:0];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}



#pragma mark - 退出登录
- (void)backButtonClicked:(UIButton *)sender {
    // 清空model
    UserModel *model = [[UserModel alloc]init];
    model = nil;
    
    LoginViewController *login = [[LoginViewController alloc]init];
    self.view.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:login];
    //if not pop, it will cause memory leak.
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hadLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"response"];
}


@end
