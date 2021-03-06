//
//  ButtonViewController.m
//  爱服务
//
//  Created by 张冬冬 on 16/4/18.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "ButtonViewController.h"
#import "AFNetworking.h"
#import "UserModel.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1] ;
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    [self setView];
}

- (void)setView {
    
    CGFloat height;
    CGFloat width;
    CGFloat fontSize;
    if (iPhone6_plus) {
        height = Height/5;
        width = Width - 100;
        fontSize = 20;
    }else if (iPhone6) {
        height = Height/5;
        width = Width - 100;
        fontSize = 18;
    }else if (iPhone5_5s) {
        height = Height/5;
        width = Width - 100;
        fontSize = 18;
    }else {
        height = Height/5;
        width = Width - 100;
        fontSize = 16;
    }
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, width, height/2)];
    
    self.textfield.text = self.text;
    
    self.textfield.backgroundColor = [UIColor whiteColor];
    self.textfield.clearsOnBeginEditing = YES;
    self.textfield.placeholder = @"修改地址";
    [self.textfield becomeFirstResponder];
    [self.view addSubview:self.textfield];
    
    UIButton *ensureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureButton setTitle:@"确定" forState:UIControlStateNormal];
    [ensureButton setTitleColor:color(30, 30, 30, 1) forState:UIControlStateNormal];
    [ensureButton setTitleColor:color(240, 240, 240, 1) forState:UIControlStateHighlighted];
    ensureButton.backgroundColor = color(59, 165, 249, 1);
    ensureButton.frame = CGRectMake(0, height*2/3, width/2 - 0.5, height/3);
    
    
    [self.view addSubview:ensureButton];
    [ensureButton addTarget:self action:@selector(ensureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitButton setTitle:@"取消" forState:UIControlStateNormal];
    [quitButton setTitleColor:color(30, 30, 30, 1) forState:UIControlStateNormal];
    [quitButton setTitleColor:color(240, 240, 240, 1) forState:UIControlStateHighlighted];
    quitButton.backgroundColor = color(59, 165, 249, 1);
    quitButton.frame = CGRectMake(width/2 + 1, height*2/3, width/2 - 0.5, height/3);
    
    [self.view addSubview:quitButton];
    [quitButton addTarget:self action:@selector(quitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)quitButtonClicked {
    [self.textfield resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ensureButtonClicked {
    [self.textfield resignFirstResponder];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//    UserModel *userModel = [UserModel readUserModel];
//    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    
//    NSString *URL = [NSString stringWithFormat:@"%@Task.ashx?action=up_detail_address",HomeUrl];
    
//    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSDictionary *params = @{
//                             @"id":[NSNumber numberWithInteger:self.ID],
//                             @"handler":name,
//                             @"user_id":[NSNumber numberWithInteger:userModel],
//                             @"address":self.textfield.text
//    
//                             };
//    [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];

    [self dismissViewControllerAnimated:YES completion:nil];
    self.returnText(self.textfield.text);
    
}



@end
