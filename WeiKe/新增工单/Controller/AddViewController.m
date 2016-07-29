//
//  AddViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/29.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "AddViewController.h"
#import "UserDetailView.h"
#import "ProductDetailView.h"
#import "BusinessDetailView.h"

#import "AFNetworking.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
@interface AddViewController ()


@property (nonatomic, strong) UserDetailView *userDetailView;
@property (nonatomic, strong) ProductDetailView *productDetailView;
@property (nonatomic, strong) BusinessDetailView *businessDetailView;

@property (nonatomic, strong) UIView *firstTitleView;
@property (nonatomic, strong) UIView *secondTitleView;
@property (nonatomic, strong) UIView *thirdTitleView;
@property (nonatomic, strong) UIView *fourthTitleView;

@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIButton *productBtn;
@property (nonatomic, strong) UIButton *businessBtn;

@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UILabel *streetLabel;

@property (nonatomic, strong) UILabel *propertyLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *serveLabel;
@property (nonatomic, strong) UILabel *guaranteeLabel;


@property (nonatomic, strong) UIView *userInfoDetailView;
@property (nonatomic, strong) UIView *productInfoDetailView;
@property (nonatomic, strong) UIView *businessInfoDetailView;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UITapGestureRecognizer *tapUserInfo;
@property (nonatomic, strong) UITapGestureRecognizer *tapProductInfo;
@property (nonatomic, strong) UITapGestureRecognizer *tapBusinessInfo;

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) MBProgressHUD *nameHUD;
@property (nonatomic, strong) MBProgressHUD *phoneHUD;
@property (nonatomic, strong) MBProgressHUD *orderHUD;
@property (nonatomic, strong) MBProgressHUD *typeHUD;
@property (nonatomic, strong) MBProgressHUD *numberHUD;
@property (nonatomic, strong) MBProgressHUD *barcode1HUD;
@property (nonatomic, strong) MBProgressHUD *barcode2HUD;
@property (nonatomic, strong) MBProgressHUD *buyAddressHUD;
@property (nonatomic, strong) MBProgressHUD *timeHUD;
@property (nonatomic, strong) MBProgressHUD *billcodeHUD;


@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = color(241, 241, 241, 1);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self configSaveButton];
    [self setNavigationBar];
    [self configBaseView];
    [self configDetailView];
    
    self.tapUserInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userBtnClicked:)];
    self.tapUserInfo.numberOfTapsRequired = 1;
    [self.firstTitleView addGestureRecognizer:self.tapUserInfo];
    self.tapProductInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productBtnClicked:)];
    self.tapProductInfo.numberOfTapsRequired = 1;
    [self.secondTitleView addGestureRecognizer:self.tapProductInfo];
    self.tapBusinessInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(businessBtnClicked:)];
    self.tapBusinessInfo.numberOfTapsRequired = 1;
    [self.thirdTitleView addGestureRecognizer:self.tapBusinessInfo];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.tap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:self.tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    [self.view removeGestureRecognizer:self.tap];
}

- (void)configSaveButton {
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*11/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
    saveBtn.backgroundColor = color(59, 165, 249, 1);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [saveBtn setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [saveBtn addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}


- (void)configBaseView {
    
    self.firstTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight , Width, (Height - StatusBarAndNavigationBarHeight)/12)];
    self.firstTitleView.backgroundColor = color(74, 129, 212, 1);
    [self.view addSubview:self.firstTitleView];

    
    self.secondTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*9/12, Width, (Height - StatusBarAndNavigationBarHeight)/12)];
    
    self.secondTitleView.backgroundColor = color(74, 154, 185, 1);
    [self.view addSubview:self.secondTitleView];

    
    self.thirdTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12 , Width, (Height - StatusBarAndNavigationBarHeight)/12)];
    self.thirdTitleView.backgroundColor = color(130, 142, 203, 1);
    [self.view addSubview:self.thirdTitleView];

    
    UILabel *userInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, Width/2, (Height - StatusBarAndNavigationBarHeight)/12)];
    UILabel *productInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, Width/2, (Height - StatusBarAndNavigationBarHeight)/12)];
    UILabel *businessInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, Width/2, (Height - StatusBarAndNavigationBarHeight)/12)];
    
    [self.firstTitleView addSubview:userInfoLabel];
    [self.secondTitleView addSubview:productInfoLabel];
    [self.thirdTitleView addSubview:businessInfoLabel];
    
    userInfoLabel.text = @"用户信息";
    productInfoLabel.text = @"产品信息";
    businessInfoLabel.text = @"业务信息";
    
    userInfoLabel.textAlignment = NSTextAlignmentLeft;
    productInfoLabel.textAlignment = NSTextAlignmentLeft;
    businessInfoLabel.textAlignment = NSTextAlignmentLeft;
    
    userInfoLabel.font = [UIFont systemFontOfSize:15];
    productInfoLabel.font = [UIFont systemFontOfSize:15];
    businessInfoLabel.font = [UIFont systemFontOfSize:15];
    self.userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userBtn setTitle:@"单击隐藏" forState:UIControlStateNormal];
    [self.userBtn setTitle:@"单击展开" forState:UIControlStateSelected];
    self.userBtn.frame = CGRectMake(Width*3/4, 0, Width/4, (Height - StatusBarAndNavigationBarHeight)/12);
    self.userBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.userBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [self.userBtn setTitleColor:color(190, 190, 190, 1) forState:UIControlStateHighlighted];
    [self.userBtn addTarget:self action:@selector(userBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstTitleView addSubview:self.userBtn];
    
    
    self.productBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.productBtn setTitle:@"单击展开" forState:UIControlStateNormal];
    [self.productBtn setTitle:@"单击隐藏" forState:UIControlStateSelected];
    self.productBtn.frame = CGRectMake(Width*3/4, 0, Width/4, (Height - StatusBarAndNavigationBarHeight)/12);
    self.productBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.productBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [self.productBtn setTitleColor:color(190, 190, 190, 1) forState:UIControlStateHighlighted];
    [self.productBtn addTarget:self action:@selector(productBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.secondTitleView addSubview:self.productBtn];
    
    self.businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.businessBtn setTitle:@"单击展开" forState:UIControlStateNormal];
    [self.businessBtn setTitle:@"单击隐藏" forState:UIControlStateSelected];
    self.businessBtn.frame = CGRectMake(Width*3/4, 0, Width/4, (Height - StatusBarAndNavigationBarHeight)/12);
    self.businessBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.businessBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [self.businessBtn setTitleColor:color(190, 190, 190, 1) forState:UIControlStateHighlighted];
    [self.businessBtn addTarget:self action:@selector(businessBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.thirdTitleView addSubview:self.businessBtn];
}


- (void)configDetailView {
    
    self.userInfoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, (Height - StatusBarAndNavigationBarHeight)/12 + StatusBarAndNavigationBarHeight, Width, (Height - StatusBarAndNavigationBarHeight)*8/12)];
    self.userInfoDetailView.backgroundColor =  color(241, 241, 241, 1);
    self.userInfoDetailView.layer.masksToBounds = YES;
    //有问题＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    [self.view addSubview:self.userInfoDetailView];
    self.userDetailView = [[UserDetailView alloc]initWithFrame:self.userInfoDetailView.bounds style:UITableViewStylePlain];
    [self.userInfoDetailView addSubview:self.userDetailView];
  
    //原始
    self.productInfoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*9/12, Width, 0)];
    self.productInfoDetailView.backgroundColor =  color(241, 241, 241, 1);
    [self.view addSubview:self.productInfoDetailView];
    self.productInfoDetailView.layer.masksToBounds = YES;

    self.productDetailView = [[ProductDetailView alloc]initWithFrame:CGRectMake(0, 0, Width, (Height - StatusBarAndNavigationBarHeight)*7/12) style:UITableViewStylePlain];
    [self.productInfoDetailView addSubview:self.productDetailView];
    
    
    //原始
    self.businessInfoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0,StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, 0)];
    self.businessInfoDetailView.backgroundColor =  color(241, 241, 241, 1);
    [self.view addSubview:self.businessInfoDetailView];
    self.businessInfoDetailView.layer.masksToBounds = YES;
    self.businessDetailView = [[BusinessDetailView alloc]initWithFrame:CGRectMake(0, 0, Width, (Height - StatusBarAndNavigationBarHeight)*4/12) style:UITableViewStylePlain];
    [self.businessInfoDetailView addSubview:self.businessDetailView];

}

- (void)buttonClicked:(UIButton *)sender {
    if (sender.tag == 203) {
        
    }else if (sender.tag == 204) {
        
    }else if (sender.tag == 205) {
        
    }else {
        
    }
}



- (UIView *)configEveryItemWithName:(NSString *)labelName lineNumber:(NSInteger)lineNumber ReturnKeyType:(UIReturnKeyType)returnKeyType willShowTableView:(BOOL)willShow Label:(UILabel *)label {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, ((Height - StatusBarAndNavigationBarHeight)-4) * (lineNumber-1)/12, Width, (Height - StatusBarAndNavigationBarHeight)/12)];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width/4, (Height - StatusBarAndNavigationBarHeight)/12)];
    infoLabel.text = labelName;
    infoLabel.font = [UIFont systemFontOfSize:13];
    infoLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:infoLabel];
    
    if (willShow) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(Width/4, 0, Width * 3 / 4, (Height - StatusBarAndNavigationBarHeight)/12)];
        label.font = [UIFont systemFontOfSize:14];
        
        UIButton *showTabelViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showTabelViewBtn.frame = CGRectMake(Width/4, 0, Width * 3 / 4, (Height - StatusBarAndNavigationBarHeight)/12);
        
        showTabelViewBtn.backgroundColor = [UIColor clearColor];
        
       
        [view addSubview:label];
        [view addSubview:showTabelViewBtn];
        
    } else {
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(Width/4, 0, Width * 3 / 4, (Height - StatusBarAndNavigationBarHeight)/12)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.clearsOnBeginEditing = YES;
        textField.returnKeyType = returnKeyType;
        textField.backgroundColor = [UIColor redColor];
        [view addSubview:textField];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(Width*5/16, (Height - StatusBarAndNavigationBarHeight)/12-1, Width*10/16, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.4];
    [view addSubview:lineView];
    
    return view;
}



- (void)userBtnClicked:(NSNotification *)sender {
    [self.view endEditing:YES];
//    sender.selected = !sender.selected;
    self.userBtn.selected = !self.userBtn.selected;
    if (self.userInfoDetailView.bounds.size.height != 0) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.userInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight +(Height - StatusBarAndNavigationBarHeight)/12 , Width, 0);
            self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
            self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6, Width, 0);
            self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width, (Height - StatusBarAndNavigationBarHeight)/12);
            self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*3/12, Width, 0);
        }];
    }else{
        if (self.productInfoDetailView.bounds.size.height != 0) {
            self.productBtn.selected = !self.productBtn.selected;
            [UIView animateWithDuration:0.4 animations:^{
                self.userInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12 , Width, (Height - StatusBarAndNavigationBarHeight)*8/12);
                
                self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*9/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, 0);
   
            }];
        }else if (self.businessInfoDetailView.bounds.size.height != 0) {
            self.businessBtn.selected = !self.businessBtn.selected;
            [UIView animateWithDuration:0.4 animations:^{
                self.userInfoDetailView.frame = CGRectMake(0,StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12 , Width, (Height - StatusBarAndNavigationBarHeight)*8/12);
                
                self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*9/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, 0);
                
                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*11/12, Width, 0);
                
            }];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                self.userInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12 , Width, (Height - StatusBarAndNavigationBarHeight)*8/12);
                
                self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*9/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, 0);
                
                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*11/12, Width, 0);
                
            }];
        }
    }
}

- (void)productBtnClicked:(NSNotification *)sender {
    [self.view endEditing:YES];
//    sender.selected = !sender.selected;
    self.productBtn.selected = !self.productBtn.selected;
    if (self.productInfoDetailView.bounds.size.height != 0) {
        [UIView animateWithDuration:0.4 animations:^{
            
            self.productInfoDetailView.frame = CGRectMake(0,StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width, 0);
            
            self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6, Width, (Height - StatusBarAndNavigationBarHeight)/12);
            self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight+ (Height - StatusBarAndNavigationBarHeight)*3/12, Width, 0);
        }];
    }else{
        if (self.userInfoDetailView.bounds.size.height != 0) {
            self.userBtn.selected = !self.userBtn.selected;
            
            [UIView animateWithDuration:0.4 animations:^{
                self.userInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12 , Width, 0);
                
                self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight +  (Height - StatusBarAndNavigationBarHeight)/12 , Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                 self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width, (Height - StatusBarAndNavigationBarHeight)*7/12);
    
            }];
            
        }else if (self.businessInfoDetailView.bounds.size.height != 0) {
            self.businessBtn.selected = !self.businessBtn.selected;
            [UIView animateWithDuration:0.4 animations:^{
                
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width, (Height - StatusBarAndNavigationBarHeight)*7/12);
                
                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.businessInfoDetailView.frame = CGRectMake(0,StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*11/12, Width, 0);
            }];
            
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width, (Height - StatusBarAndNavigationBarHeight)*7/12);

                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*10/12, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*11/12, Width, 0);
                
            }];
        }
    }
}

- (void)businessBtnClicked:(NSNotification *)sender {
    [self.view endEditing:YES];
//    sender.selected = !sender.selected;
    self.businessBtn.selected = !self.businessBtn.selected;
    if (self.businessInfoDetailView.bounds.size.height != 0) {
        [UIView animateWithDuration:0.4 animations:^{
            self.businessInfoDetailView.frame = CGRectMake(0,StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*3/12 , Width, 0);
        }];
    }else{
        
        if (self.productInfoDetailView.bounds.size.height != 0) {
            self.productBtn.selected = !self.productBtn.selected;
            [UIView animateWithDuration:0.4 animations:^{
                
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6 , Width,0);
                
                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight +  (Height - StatusBarAndNavigationBarHeight)/6, Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*3/12 , Width, (Height - StatusBarAndNavigationBarHeight)*4/12);
                
            }];
        }else if (self.userInfoDetailView.bounds.size.height != 0) {
            self.userBtn.selected = !self.userBtn.selected;
            [UIView animateWithDuration:0.4 animations:^{
                
                self.userInfoDetailView.frame = CGRectMake(0,StatusBarAndNavigationBarHeight+ (Height - StatusBarAndNavigationBarHeight)/12 , Width, 0);
                self.secondTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/12 , Width, (Height - StatusBarAndNavigationBarHeight)/12);
                self.productInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/6, Width, 0);
                self.thirdTitleView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight +  (Height - StatusBarAndNavigationBarHeight)/6 , Width, (Height - StatusBarAndNavigationBarHeight)/12);
                
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*3/12 , Width, (Height - StatusBarAndNavigationBarHeight)*4/12);
                
            }];
        }else{
            
            [UIView animateWithDuration:0.4 animations:^{
                self.businessInfoDetailView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*3/12 , Width, (Height - StatusBarAndNavigationBarHeight)*4/12);
            }];
        }
    }
}

- (void)saveButtonClicked:(UIButton *)sender {
    
    NSLog(@"self.userDetailView.button3.titleLabel.text = %@",self.userDetailView.button3.titleLabel.text);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    UserModel *userModel = [UserModel readUserModel];
    
    UIButton *infoBtn = [self.userDetailView viewWithTag:203];
    UITextField *userName = [self.userDetailView viewWithTag:100];
    
    if (userName.text.length == 0) {
        _nameHUD = [[MBProgressHUD alloc]initWithView:self.view];
        _nameHUD.mode = MBProgressHUDModeText;
        _nameHUD.label.text = @"请填写姓名";
        
        _nameHUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_nameHUD];
        [self.nameHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.nameHUD hideAnimated:YES];
            self.nameHUD.removeFromSuperViewOnHide = YES;
            
        });
        return;
    }
    
    UITextField *userPhone = [self.userDetailView viewWithTag:101];
    if (userPhone.text.length == 0) {
        _phoneHUD = [[MBProgressHUD alloc]initWithView:self.view];
        _phoneHUD.mode = MBProgressHUDModeText;
        _phoneHUD.label.text = @"请填写手机号码";
        _phoneHUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_phoneHUD];
        [self.phoneHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.phoneHUD hideAnimated:YES];
            self.phoneHUD.removeFromSuperViewOnHide = YES;
        });
        return;
    }
    UITextField *billCode = [self.userDetailView viewWithTag:102];
    
    NSInteger productBreedID = self.productDetailView.productID;//[[NSUserDefaults standardUserDefaults] integerForKey:@"productID"];
    UIButton *breedName = [self.productDetailView viewWithTag:200];
    
    NSString *classifyID = [NSString stringWithFormat:@"%@",@(self.productDetailView.classifyID)];//[[NSUserDefaults standardUserDefaults] objectForKey:@"classifyID"];
    UIButton *classifyName = [self.productDetailView viewWithTag:201];
    
    UITextField *typeName = [self.productDetailView viewWithTag:102];
    UITextField *productCount = [self.productDetailView viewWithTag:103];
    if (productCount.text.length == 0) {
        _numberHUD = [[MBProgressHUD alloc]initWithView:self.view];
        _numberHUD.mode = MBProgressHUDModeText;
        _numberHUD.label.text = @"请填写产品数量";
        _numberHUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_numberHUD];
        
        [self.numberHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.numberHUD hideAnimated:YES];
            self.numberHUD.removeFromSuperViewOnHide = YES;
        });
        return;
    }
    
    NSString *cityID = self.userDetailView.cityID;
    NSString *distID = self.userDetailView.discID;
    NSString *townID = self.userDetailView.townID;
    
    UIButton *cityBtn = [self.userDetailView viewWithTag:204];
    UIButton *distBtn = [self.userDetailView viewWithTag:205];
    UIButton *townBtn = [self.userDetailView viewWithTag:206];
    if ([cityID isEqualToString:@""]) {
        
    }
    
    if ([self.userDetailView.button2.titleLabel.text isEqualToString:@""]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请填写市县区";
        hud.label.font = [UIFont systemFontOfSize:14];
        
        [hud hideAnimated:YES afterDelay:1.0];
        return;
        
    }
    if  ([self.userDetailView.button3.titleLabel.text isEqualToString:@""]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请填写街道";
        hud.label.font = [UIFont systemFontOfSize:14];
        
        [hud hideAnimated:YES afterDelay:1.0];
        return;
    }
    
    UITextField *detailAddress = [self.userDetailView viewWithTag:107];
    
    NSString *serviceType = [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceType"];
    
    UITextField *barCode1 = [self.productDetailView viewWithTag:104];

    UITextField *barCode2 = [self.productDetailView viewWithTag:105];
    UITextField *buyAddress = [self.productDetailView viewWithTag:106];

    NSString *serviceID = self.businessDetailView.serviceID;
    NSString *serviceName = self.businessDetailView.serivcePro;
    
    UITextField *task = [self.businessDetailView viewWithTag:103];
    
    NSString *time = self.businessDetailView.date;//[[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    if (time.length == 0) {
        
        _timeHUD = [[MBProgressHUD alloc]initWithView:self.view];
        _timeHUD.mode = MBProgressHUDModeText;
        _timeHUD.label.text = @"请填写预约时间";
        _timeHUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_timeHUD];
        [self.timeHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.timeHUD hideAnimated:YES];
            self.timeHUD.removeFromSuperViewOnHide = YES;
        });
        return;
    }
    
    
    NSDictionary *params = @{
                             @"comid":@(userModel.CompanyID),
                             @"InfoFrom":infoBtn.titleLabel.text,
                             @"BuyerName":userName.text,
                             @"BuyerPhone":userPhone.text,
                             @"ProductBreedID":@(productBreedID),
                             @"ProductBreed":breedName.titleLabel.text,
                             @"ProductClassifyID":classifyID,
                             @"ProductClassify":classifyName.titleLabel.text,
                             @"ProductType":typeName.text,
                             @"ProductCount":productCount.text,
                             @"BuyerCityID":cityID,
                             @"BuyerCity":cityBtn.titleLabel.text,
                             @"BuyerDistrictID":distID,
                             @"BuyerDistrict":distBtn.titleLabel.text,
                             @"BuyerTownID":townID,
                             @"BuyerTown":townBtn.titleLabel.text,
                             @"BuyerAddress":detailAddress.text,
                             @"RepairType":serviceName,
                             @"BuyAddress":buyAddress.text,
                             @"ServiceClassifyID":serviceID,
                             @"ServiceClassify":serviceType,
                             @"ExpectantTime":time,
                             @"TaskPostscript":task.text,
                             @"WaiterID":@(userModel.ID),
                             @"WaiterName":userModel.UserName,
                             @"BillCode":billCode.text,
                             @"BarCode":barCode1.text,
                             @"BarCode2":barCode2.text
                             };
    NSLog(@"params = %@",params);
    
    NSString *addURL = [NSString stringWithFormat:@"%@/Task.ashx?action=addTask",HomeUrl];

    addURL = [addURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:addURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:self.HUD];
        self.HUD.label.text = @"保存成功";
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateRedLabel object:nil];
        [self.HUD showAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.HUD hideAnimated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.font = font(14);
        hud.label.text = @"保存失败，请检查";
        [hud hideAnimated:YES afterDelay:1.0];
        
    }];
}

//导航栏
-(void)setNavigationBar {
    
    self.navigationItem.title = @"新增工单";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




@end
