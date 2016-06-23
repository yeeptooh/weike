//
//  ErWeiMaTZViewController.m
//  天润
//
//  Created by Ji_YuFeng on 15/4/25.
//  Copyright (c) 2015年 Ji_YuFeng. All rights reserved.
//

#import "ErWeiMaTZViewController.h"

@interface ErWeiMaTZViewController ()

@end

@implementation ErWeiMaTZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *theweb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    NSURL *url = [NSURL URLWithString:_thenetString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [theweb loadRequest:request];
    [self.view addSubview:theweb];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
