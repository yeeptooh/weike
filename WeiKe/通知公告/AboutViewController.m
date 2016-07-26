//
//  AboutViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "AboutViewController.h"
#import "UserModel.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=tongzhi&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

//导航栏
- (void)setNavigationBar {
  self.navigationItem.title = @"通知公告";
    
}

@end
