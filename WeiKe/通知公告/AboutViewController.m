//
//  AboutViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "AboutViewController.h"
#import "UserModel.h"
#import <WebKit/WebKit.h>
@interface AboutViewController ()
<UIWebViewDelegate>
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setWebview];
    
}

//导航栏
- (void)setNavigationBar {
  self.navigationItem.title = @"通知公告";
    
}

- (void)setWebview {
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Width ,Height)];
    webview.scrollView.bounces = NO;
//    webview.delegate = self;
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=tongzhi&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
