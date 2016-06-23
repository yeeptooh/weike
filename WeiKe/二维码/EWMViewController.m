//
//  EWMViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/31.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "EWMViewController.h"
#import "UserModel.h"

@interface EWMViewController ()

@end

@implementation EWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    
    [self setWebview];
    
}

//导航栏
- (void)setNavigationBar {
    self.navigationItem.title = @"二维码";
    
}

- (void)setWebview {
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Width ,Height)];
    webview.scrollView.bounces = NO;
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=erweima&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
}



@end
