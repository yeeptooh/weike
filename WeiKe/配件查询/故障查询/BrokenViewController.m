//
//  BrokenViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/21.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "BrokenViewController.h"
#import "UserModel.h"
@interface BrokenViewController ()
@end

@implementation BrokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=guzhang&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
    NSLog(@"%@",self.url);
}

//导航栏
-(void)setNavigationBar {
    
    self.navigationItem.title = @"故障查询";
}

@end
