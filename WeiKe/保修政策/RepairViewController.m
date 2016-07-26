//
//  RepairViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "RepairViewController.h"
#import "UserModel.h"

@interface RepairViewController ()

@end

@implementation RepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=baoxiu&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
    NSLog(@"url = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

//导航栏
- (void)setNavigationBar {
    self.navigationItem.title = @"保修政策";
    
}


@end
