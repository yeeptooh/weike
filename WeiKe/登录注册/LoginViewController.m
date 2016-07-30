//
//  LoginViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/24.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AFNetClass.h"
#import "UserModel.h"
#import "MyProgressView.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()
<
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIView *LoginBackView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (strong, nonatomic) IBOutlet UIView *MainBackView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PassWord.delegate = self;
    self.UserName.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    self.LoginBackView.layer.cornerRadius = 10;
    self.LoginButton.layer.cornerRadius = 10;
    
    
    //取得密码
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"PassWord"];
    
    if (userName) {
        self.UserName.text = userName;
        self.PassWord.text = passWord;
    }
    
}


#pragma mark - 键盘回车 -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.PassWord resignFirstResponder];
    
    [self loginNetworking];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (iPhone4_4s) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = -145;
            self.view.frame = frame;
        }];
    }else if (iPhone5_5s){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = -60;
            self.view.frame = frame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (iPhone4_4s) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }else if (iPhone5_5s){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.UserName resignFirstResponder];
    [self.PassWord resignFirstResponder];
 
}

- (IBAction)LoginAction:(id)sender {
    [self loginNetworking];
}


- (void)loginNetworking {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    NSDictionary *params = @{
                             @"name":_UserName.text,
                         @"password":_PassWord.text,
                           @"action":@"login"
                            };
    [AFNetClass LoginRequestWithParmas:params withReturnBlock:^(NSDictionary *response, NSError *error) {
        
        [hud hideAnimated:YES];
        [hud removeFromSuperViewOnHide];
        if ([[response objectForKey:@"user"][0][@"State"]integerValue] == 1) {
            //  将用户数据存储到Usermodel
            UserModel *model = [[UserModel alloc]init];
            model.Name = response[@"user"][0][@"Name"];
            model.UserName = response[@"user"][0][@"UserName"];
            model.ID = [response[@"user"][0][@"ID"]integerValue];
            model.CompanyID = [response[@"user"][0][@"CompanyID"]integerValue];
            [UserModel writeUserModel:model];
            
            
            [self saveWords];
            //保存登录状态
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hadLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [MyProgressView dissmiss];
            //切换跟视图控制器，之前的跟视图控制器自动释放
            HomeViewController *home = [[HomeViewController alloc]init];
            self.view.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:home];
            //push的话造成memory leak
            //[self.navigationController pushViewController:home animated:YES];
            
            
        }else{
            if ([self.UserName.text isEqualToString:@""] || [self.PassWord.text isEqualToString:@""]) {
                
                [MyProgressView dissmissWithError:@"用户名或密码为空"];
            }else{
                [MyProgressView dissmissWithError:@"用户名或密码错误"];
            }
        }
    }];
}



#pragma mark - 保存用户名和密码 -
- (void)saveWords{
    [[NSUserDefaults standardUserDefaults] setObject:self.UserName.text forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.PassWord.text forKey:@"PassWord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
