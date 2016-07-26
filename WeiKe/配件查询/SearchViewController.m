//
//  SearchViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/28.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "SearchViewController.h"
#import "UserModel.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/productlist.aspx?&userid=%ld&companyid=%ld",HomeUrl,(long)usermodel.ID,(long)usermodel.CompanyID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

//导航栏
-(void)setNavigationBar {
    
    self.navigationItem.title = @"配件查询";
}



@end
