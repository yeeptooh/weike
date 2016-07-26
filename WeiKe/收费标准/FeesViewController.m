//
//  FeesViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "FeesViewController.h"
#import "UserModel.h"


@interface FeesViewController ()
@end

@implementation FeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=shoufei&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

//导航栏
-(void)setNavigationBar {

    self.navigationItem.title = @"收费标准";
}



@end
