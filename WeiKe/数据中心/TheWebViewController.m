//
//  TheWebViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 16/1/12.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "TheWebViewController.h"
#import "UserModel.h"

@interface TheWebViewController ()

@end

@implementation TheWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@&comid=%ld&uid=%ld",HomeUrl,_urlStirng,(long)usermodel.CompanyID,(long)usermodel.ID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

//导航栏
- (void)setNavigationBar {
    
    self.navigationItem.title = self.theTitle;
}




@end
