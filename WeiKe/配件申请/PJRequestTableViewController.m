//
//  PJRequestTableViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/6.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "PJRequestTableViewController.h"
#import "AFNetworking.h"
#import "AFNetClass.h"
#import "UserModel.h"
#import "BreedViewController.h"
#import "ClassifyViewController.h"
#import "MyProgressView.h"
#import "LGPhoto.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
#import "AllOrderViewController.h"
@interface PJRequestTableViewController ()
<
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
LGPhotoPickerViewControllerDelegate
>
{
    NSArray *_productBrandList;
    NSArray *_productTypeList;
    NSInteger _theProductID;
    
    NSString *_breed;
    NSString *_classify;
    NSString *_type;
    NSString *_ps;
}
@property (nonatomic, strong) NSMutableArray *breedList;
@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSMutableArray *productIDList;

@property (nonatomic, strong) NSMutableArray *classifyList;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;

@property (nonatomic, strong) NSMutableArray *typeList;

@property (nonatomic, assign) NSInteger selectedBtnposition;
@property (nonatomic, assign) LGShowImageType showType;

@property (nonatomic, strong) NSData *imageData1;
@property (nonatomic, strong) NSData *imageData2;
@property (nonatomic, strong) NSData *imageData3;

@property (nonatomic, strong) MBProgressHUD *errorHUD;
@property (nonatomic, strong) MBProgressHUD *successHUD;
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) WKWebView *webView;
@end

@implementation PJRequestTableViewController

- (NSMutableArray *)typeList {
    if (!_typeList) {
        _typeList = [NSMutableArray array];
    }
    return _typeList;
}

- (NSMutableArray *)breedList{
    if (!_breedList) {
        _breedList = [NSMutableArray array];
    }
    return _breedList;
}

- (NSMutableArray *)productIDList{
    if (!_productIDList) {
        _productIDList = [NSMutableArray array];
    }
    return _productIDList;
}

- (NSMutableArray *)classifyList{
    if (!_classifyList) {
        _classifyList = [NSMutableArray array];
    }
    return _classifyList;
}

- (MBProgressHUD *)successHUD {
    if (!_successHUD) {
        _successHUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        _successHUD.mode = MBProgressHUDModeText;
        _successHUD.label.text = @"申请成功";
        _successHUD.label.font = [UIFont systemFontOfSize:16];
        [self.navigationController.view addSubview:_successHUD];
    }
    return _successHUD;
}

- (MBProgressHUD *)HUD {
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        _HUD.mode = MBProgressHUDModeText;
        _HUD.label.text = @"申请失败";
        _HUD.label.font = [UIFont systemFontOfSize:16];
        [self.navigationController.view addSubview:_HUD];
    }
    return _HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = color(241, 241, 241, 1);
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self setNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self getProductList];
    [self getTypeListWithRow:0];
    
    
    
    
}

- (MBProgressHUD *)errorHUD{
    if (!_errorHUD) {
        _errorHUD = [[MBProgressHUD alloc]initWithView:self.view];
        _errorHUD.mode = MBProgressHUDModeText;
        _errorHUD.label.text = @"配件描述不能为空";
        _errorHUD.label.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:_errorHUD];
        
    }
    return _errorHUD;
}


- (void)getProductList {
    
        // 获取产品名称
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductbreed&comid=%ld",HomeUrl,(long)usermodel.CompanyID];
    [AFNetClass AFNetworkingRequestWithURL:urlString andParmas:nil withReturnBlock:^(NSDictionary *response, NSError *error) {
        
        _productBrandList = response[@"list"];
        NSLog(@"----%@",response);
        [MyProgressView dissmiss];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in _productBrandList) {
            [array addObject:dic[@"ID"]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"IDArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        for (NSInteger i = 0; i < _productBrandList.count; i++) {
            [self.breedList addObject:_productBrandList[i][@"Name"]];
        }
        
    }];

   
}

- (void)getTypeListWithRow:(NSInteger )row {
    
    [self.classifyList removeAllObjects];
//    _theProductID = [_productBrandList[_selectedRow][@"ID"]integerValue];
    
    //      获取产品类型
    UserModel *usermodel = [UserModel readUserModel];
    NSString *ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"IDArr"][row];
    NSString *theUrlStinrg = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductclassify&comid=%ld&parent=%ld",HomeUrl,(long)usermodel.CompanyID,(long)[ID integerValue]];
    
    [AFNetClass AFNetworkingRequestWithURL:theUrlStinrg andParmas:nil withReturnBlock:^(NSDictionary *response, NSError *error) {
        
        _productTypeList = response[@"list"];
        
        for (NSInteger i = 0; i < _productTypeList.count; i++) {
            [self.classifyList addObject:_productTypeList[i][@"Name"]];
        }

    }];
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

- (void)setNavigationBar {
    self.navigationItem.title = @"配件申请";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIButton  *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 60, 40);
    [backButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [backButton setTitleColor:color(170, 170, 170, 1) forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_light"] forState:UIControlStateNormal];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    
    UIBarButtonItem  *backItem =[[UIBarButtonItem alloc]initWithCustomView: backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *requestItem = [[UIBarButtonItem alloc]initWithTitle:@"申请" style:UIBarButtonItemStylePlain target:self action:@selector(request:)];
    self.navigationItem.rightBarButtonItem = requestItem;
    
    
}

- (void)backLastView:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    UIButton *breed = [self.view viewWithTag:200];
    UIButton *classify = [self.view viewWithTag:201];
    UITextField *type = [self.view viewWithTag:102];
    UITextField *ps = [self.view viewWithTag:103];
    _breed = breed.titleLabel.text;
    _classify = classify.titleLabel.text;
    _type = type.text;
    _ps = ps.text;
    NSLog(@"%@",_breed);
    if ([_ps isEqualToString:@""]) {
        
        [self.errorHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.errorHUD hideAnimated:YES];
        });
        
        return;
    }
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    [self.navigationController.view addSubview:HUD];
    [HUD showAnimated:YES];
    
    
    
    NSInteger count = 0;
    if (self.firstImageView.image) {
        count ++;
        self.imageData1 = UIImageJPEGRepresentation(self.firstImageView.image, 0.1);
    }
    
    if (self.secondImageView.image) {
        count ++;
        self.imageData2 = UIImageJPEGRepresentation(self.secondImageView.image, 0.1);
    }
    
    if (self.thirdImageView.image) {
        count ++;
        self.imageData3 = UIImageJPEGRepresentation(self.thirdImageView.image, 0.1);
    }
    
    //
    
    
    
    //
//    [MyProgressView showWith:@"Loading..."];
   
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=applysubmit",HomeUrl];
    NSDictionary *params = @{@"comid":[NSNumber numberWithInteger: usermodel.CompanyID],@"uid":[ NSNumber numberWithInteger:usermodel.ID],@"breed":_breed,@"classify":_classify,@"type":_type,@"ps":_ps};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *picArray = [[NSArray alloc]init];
        NSArray *nameArray = @[
                               @"profile_picture1",
                               @"profile_picture2",
                               @"profile_picture3"
                               ];
        NSArray *fileNameArray = @[
                                   @"profile_picture1.jpeg",
                                   @"profile_picture2.jpeg",
                                   @"profile_picture3.jpeg"
                                   ];
        if (self.firstImageView.image) {
            if (self.secondImageView.image) {
                if (self.thirdImageView.image) {
                    picArray = @[self.imageData1,self.imageData2,self.imageData3];
                }else{
                    picArray = @[self.imageData1,self.imageData2];
                }
            }else{
                if (self.thirdImageView.image) {
                    picArray = @[self.imageData1,self.imageData3];
                }else{
                    picArray = @[self.imageData1];
                }
            }
        }else{
            if (self.secondImageView.image) {
                if (self.thirdImageView.image) {
                    picArray = @[self.imageData2,self.imageData3];
                }else{
                    picArray = @[self.imageData2];
                }
            }else{
                if (self.thirdImageView.image) {
                    picArray = @[self.imageData3];
                }else{
                    picArray = @[];
                }
            }
        }
        
        for (NSInteger i = 0; i < count; i ++) {

            [formData appendPartWithFileData:picArray[i] name:nameArray[i] fileName:fileNameArray[i] mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MyProgressView dissmiss];
        [HUD hideAnimated:YES];
        [HUD removeFromSuperViewOnHide];
        
        [self.successHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.successHUD hideAnimated:YES];
            [self.successHUD removeFromSuperViewOnHide];
//            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=applymine&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
        NSLog(@"%@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %-----@",error);
        [HUD hideAnimated:YES];
        [HUD removeFromSuperViewOnHide];
        [self.HUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.HUD hideAnimated:YES];
            [self.HUD removeFromSuperViewOnHide];
//            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 5 || indexPath.row == 7) {
        return (Height - StatusBarAndNavigationBarHeight)/12;
    }else{
        return (Height - StatusBarAndNavigationBarHeight)*3/12;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *labelList = @[
                      @"产品品牌",
                      @"产品类型",
                      @"产品型号",
                      @"配件描述",
                      @"工单号",
                      @"添加照片",
                      @"",
                      @""
                      ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width/4, 40)];
    label.text = labelList[indexPath.row];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTintColor:[UIColor blackColor]];
        button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = indexPath.row + 200;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        if (indexPath.row == 0) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"美的" forState:UIControlStateNormal];
            }else {
                if ([button.titleLabel.text isEqualToString:@""]) {
                    [button setTitle:@"美的" forState:UIControlStateNormal];
                }else{
                    [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"breedList"][0][@"Name"] forState:UIControlStateNormal];
                }
                
            }
            
            
        }
        
        if (indexPath.row == 1) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"电热水器" forState:UIControlStateNormal];
            }else {
                
                if ([button.titleLabel.text isEqualToString:@""]) {
                    [button setTitle:@"电热水器" forState:UIControlStateNormal];
                }else{
                    [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] forState:UIControlStateNormal];
                }
            }
        }
    }else if(indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        UITextField *textfield;
        
        if (indexPath.row == 4) {
            textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
            [button setTitle:@"选择" forState:UIControlStateNormal];
            button.frame = CGRectMake(Width*13/16 , 5, Width *2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.backgroundColor = color(59, 165, 249, 1);
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            
            [button addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            
        }else{
            textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        }
        textfield.delegate = self;
        textfield.layer.cornerRadius = 5;
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.layer.masksToBounds = YES;
        textfield.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 2 || indexPath.row == 4) {
//            textfield.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        textfield.tag = 100 + indexPath.row;
        [cell addSubview:textfield];
    }else if(indexPath.row == 5 ){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTintColor:[UIColor blackColor]];
        button.frame = CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = color(241, 241, 241, 1);
        button.userInteractionEnabled = NO;
        button.tag = indexPath.row + 200;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        
        [cell addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if(indexPath.row == 6){
        
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        firstView.backgroundColor = color(230, 230, 230, 1);
        
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        secondView.backgroundColor = color(230, 230, 230, 1);
        UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        thirdView.backgroundColor = color(230, 230, 230, 1);
        
        [cell addSubview:firstView];
        [cell addSubview:secondView];
        [cell addSubview:thirdView];
        {
            UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(20 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
            firstLineView.backgroundColor = [UIColor whiteColor];
            UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(25, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
            secondLineView.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview:firstLineView];
            [cell addSubview:secondLineView];
        }
        
        {
            UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
            firstLineView.backgroundColor = [UIColor whiteColor];
            UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(65 + (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
            secondLineView.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview:firstLineView];
            [cell addSubview:secondLineView];
            
        }
        
        {
            UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
            firstLineView.backgroundColor = [UIColor whiteColor];
            UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 15 - (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
            secondLineView.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview:firstLineView];
            [cell addSubview:secondLineView];
            
        }
        
        self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        self.secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        self.thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
        
        [cell addSubview:self.firstImageView];
        [cell addSubview:self.secondImageView];
        [cell addSubview:self.thirdImageView];
        
        UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom
                              ];
        firstBtn.backgroundColor = [UIColor clearColor];
        firstBtn.frame = CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9);
        [cell addSubview:firstBtn];
        [firstBtn addTarget:self action:@selector(firstBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom
                               ];
        secondBtn.backgroundColor = [UIColor clearColor];
        secondBtn.frame = CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
        [cell addSubview:secondBtn];
        [secondBtn addTarget:self action:@selector(secondBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom
                              ];
        thirdBtn.backgroundColor = [UIColor clearColor];
        thirdBtn.frame = CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
        [cell addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(thirdBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    }else{
        
//        cell.backgroundColor = [UIColor redColor];
        self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, (Height - StatusBarAndNavigationBarHeight)*9/12, Width, (Height - StatusBarAndNavigationBarHeight)*3/12)];
        self.webView.scrollView.bounces = NO;
        UserModel *usermodel = [UserModel readUserModel];
        NSString *urlString = [NSString stringWithFormat:@"%@/page.aspx?type=applymine&comid=%ld&uid=%ld",HomeUrl,(long)usermodel.CompanyID,(long)usermodel.ID];
        NSLog(@"%@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    


    return cell;
}

- (void)buttonClicked:(UIButton *)sender {
    [self.tableView endEditing:YES];
    if (sender.tag == 200) {
        BreedViewController *breedVC = [[BreedViewController alloc]init];
//        NSMutableArray *list = [NSMutableArray array];
//        for (NSDictionary *dic in [[NSUserDefaults standardUserDefaults] objectForKey:@"breedList"]) {
//            [list addObject:dic[@"Name"]];
//        }
        
        breedVC.breedList = self.breedList;
        
        breedVC.returnBreed = ^(NSString *name, NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            
            UserModel *userModel = [UserModel readUserModel];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSInteger ID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"IDArr"][row] integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:ID forKey:@"breedID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *classifyURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductclassify&comid=%ld&parent=%ld",HomeUrl,(long)userModel.CompanyID,(long)ID];
//            NSLog(@"%@",classifyURLString);
            
            [manager GET:classifyURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [list addObject:dic[@"Name"]];
                }
                
                NSLog(@"333%@",list);
                
                [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"list"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                NSMutableArray *IDList = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [IDList addObject:dic[@"ID"]];
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:IDList forKey:@"classifyIDList"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self.classifyList removeAllObjects];
                self.classifyList  = list;
                
                UIButton *btn = [self.tableView viewWithTag:201];
                [btn setTitle:list[0] forState:UIControlStateNormal];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
        };
        
        [self presentViewController:breedVC animated:YES completion:nil];
        
    }else if(sender.tag == 201){
        
        ClassifyViewController *classifyVC = [[ClassifyViewController alloc]init];
        classifyVC.classifyList = self.classifyList;
        classifyVC.returnClassify = ^(NSString *name , NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            NSMutableArray *cliassifyIDList = [[NSUserDefaults standardUserDefaults]objectForKey:@"classifyIDList"];
            
            [[NSUserDefaults standardUserDefaults] setInteger:[cliassifyIDList[row] integerValue] forKey:@"classifyID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        };
        
        [self presentViewController:classifyVC animated:YES completion:nil];
        
    }else {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
            
        }];
        
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self presentPhotoPickerViewControllerWithStyle:0];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [actionSheet addAction:cameraAction];
        [actionSheet addAction:albumAction];
        [actionSheet addAction:cancelAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}

- (void)firstBtnClicked:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    self.selectedBtnposition = 1;
    
}

- (void)secondBtnClicked:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        imagePickerController.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    self.selectedBtnposition = 2;
    
}

- (void)thirdBtnClicked:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    self.selectedBtnposition = 3;
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.selectedBtnposition != 0) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        if (self.selectedBtnposition == 1) {
            self.firstImageView.image = image;
        }
        if (self.selectedBtnposition == 2) {
            self.secondImageView.image = image;
        }
        if (self.selectedBtnposition == 3) {
            self.thirdImageView.image = image;
        }
        
        self.selectedBtnposition ++;
        if (self.selectedBtnposition == 4) {
            self.selectedBtnposition = 1;
        }
      
        return;
    }else{
        self.selectedBtnposition = 2;
        self.firstImageView.image = image;
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 3;   // 最多能选3张图片
    pickerVc.delegate = self;
    self.showType = style;
    [pickerVc showPickerVc:self];
}

#pragma mark - LGPhotoPickerControllerDelegate -

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original {
    
    if (assets.count == 1) {
        self.firstImageView.image = [assets[0] compressionImage];
    }else if (assets.count == 2) {
        self.firstImageView.image = [assets[0] compressionImage];
        self.secondImageView.image = [assets[1] compressionImage];
    }else {
        self.firstImageView.image = [assets[0] compressionImage];
        self.secondImageView.image = [assets[1] compressionImage];
        self.thirdImageView.image = [assets[2] compressionImage];
    }
//
    
}
- (void)pushVC {
    AllOrderViewController *allVC = [[AllOrderViewController alloc]init];
    allVC.returnID = ^(NSString *ID){
        UITextField *textfield = [self.view viewWithTag:104];
        textfield.text = ID;
    };
    [self.navigationController pushViewController:allVC animated:YES];
}
@end
