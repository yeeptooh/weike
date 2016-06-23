//
//  CancelViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/22.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "CancelViewController.h"
#import "DatePickerViewController.h"

#import "NameViewController.h"
#import "StoreNameViewController.h"

#import "AFNetworking.h"
#import "UserModel.h"

#import "AddPJViewController.h"
#import "MBProgressHUD.h"
#import "CancelPJViewController.h"
@interface CancelViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@end

@implementation CancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self setUI];
    
    
    
    
    
}

- (void)setUI {
    self.view.backgroundColor = color(241, 241, 241, 1);
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 5, Width/4, (Height - StatusBarAndNavigationBarHeight)/10 - 10)];
    label1.text = @"调出仓";
    CGFloat fontSize;
    if (iPhone6_plus || iPhone6) {
        fontSize = 17;
    }else{
        fontSize = 14;
    }
    label1.font = [UIFont systemFontOfSize:fontSize];
    label1.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + Height*1/10 + 5, Width/4, (Height - StatusBarAndNavigationBarHeight)/10 - 10)];
    label2.text = @"调入仓";
    
    label2.font = [UIFont systemFontOfSize:fontSize];
    label2.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + Height*2/10 + 5, Width/4, (Height - StatusBarAndNavigationBarHeight)/10 - 10)];
    label3.text = @"单据日期";
    
    label3.font = [UIFont systemFontOfSize:fontSize];
    label3.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label3];
    
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button1 setTitle:self.name forState:UIControlStateNormal];
    self.button1.frame = CGRectMake(Width *5/16, StatusBarAndNavigationBarHeight + 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/10 - 10);
    self.button1.backgroundColor = [UIColor whiteColor];
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.masksToBounds = YES;
    self.button1.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.button1 setTitleColor:[UIColor blackColor] forState:0];
    [self.button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    if (self.flag1 == 0) {
        
    }else{
        self.button1.userInteractionEnabled = NO;
        [self.button1 setTitleColor:color(100, 100, 100, 1) forState:UIControlStateNormal];
    }
    [self.view addSubview:self.button1];
    
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button2 setTitle:self.storeName forState:UIControlStateNormal];
    self.button2.userInteractionEnabled = NO;
    [self.button2 setTitleColor:color(100, 100, 100, 1) forState:UIControlStateNormal];
    self.button2.frame = CGRectMake(Width *5/16, StatusBarAndNavigationBarHeight + 5+Height*1/10, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/10 - 10);
    self.button2.backgroundColor = [UIColor whiteColor];
    self.button2.layer.cornerRadius = 5;
    self.button2.layer.masksToBounds = YES;
    self.button2.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    self.button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.button2 setTitleColor:[UIColor blackColor] forState:0];
//    [self.button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
//    if ([self.button2.titleLabel.text isEqualToString:@""]) {
//        
//    }else{
//        self.button2.userInteractionEnabled = NO;
//        [self.button2 setTitleColor:color(100, 100, 100, 1) forState:UIControlStateNormal];
//    }
    [self.view addSubview:self.button2];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button3 setTitle:dateString forState:UIControlStateNormal];
    self.button3.frame = CGRectMake(Width *5/16, StatusBarAndNavigationBarHeight + 5+Height*2/10, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/10 - 10);
    self.button3.backgroundColor = [UIColor whiteColor];
    self.button3.layer.cornerRadius = 5;
    self.button3.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    self.button3.layer.masksToBounds = YES;
    self.button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.button3 setTitleColor:[UIColor blackColor] forState:0];
    [self.button3 addTarget:self action:@selector(button3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button3];
    
    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cButton setTitle:dateString forState:UIControlStateNormal];
    cButton.frame = CGRectMake(50, StatusBarAndNavigationBarHeight + 5 + Height*8/10, Width - 100, (Height - StatusBarAndNavigationBarHeight)/10 - 10);
    cButton.backgroundColor = color(23, 133, 255, 1);
    cButton.layer.cornerRadius = 5;
    cButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    cButton.layer.masksToBounds = YES;
    [cButton setTitle:@"确定提交" forState:UIControlStateNormal];
    
    
    [cButton addTarget:self action:@selector(cButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cButton];
    
    
}
//Product.ashx?action=add CompanyID Client(销售员名称) Warehouse(仓库名称) TaskID Name(登录的用户名) Time
- (void)cButtonClicked:(UIButton *)sender {
    
    if ([self.storeName isEqualToString:@""]) {
        MBProgressHUD *nameHUD = [[MBProgressHUD alloc]initWithView:self.view];
        nameHUD.mode = MBProgressHUDModeText;
        nameHUD.label.text = @"调出仓无次品仓，无法调出";
        nameHUD.label.numberOfLines = 0;
        nameHUD.label.font = [UIFont systemFontOfSize:14];
        
        [self.view addSubview:nameHUD];
        [nameHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [nameHUD hideAnimated:YES];
            nameHUD.removeFromSuperViewOnHide = YES;
            
        });
        return;
    }
    
    
    if ([self.button1.titleLabel.text isEqualToString:self.button2.titleLabel.text]) {
        MBProgressHUD *nameHUD = [[MBProgressHUD alloc]initWithView:self.view];
        nameHUD.mode = MBProgressHUDModeText;
        nameHUD.label.text = @"调入调出仓\n不允许相同";
        nameHUD.label.numberOfLines = 0;
        nameHUD.label.font = [UIFont systemFontOfSize:14];
        
        [self.view addSubview:nameHUD];
        [nameHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [nameHUD hideAnimated:YES];
            nameHUD.removeFromSuperViewOnHide = YES;
            
        });
        return;
    }
    
    
    UserModel *userModel = [UserModel readUserModel];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=addChangeOrder",HomeUrl];
    NSDictionary *params = @{
                             @"TaskID":[NSNumber numberWithInteger:self.taskID],
                             @"userId":[NSNumber numberWithInteger:userModel.ID],
                             @"fromId":self.from,
                             @"fromName":self.button1.titleLabel.text,
                             @"toId":self.to,
                             @"toName":self.button2.titleLabel.text,
                             @"Time":self.button3.titleLabel.text,
                             @"name":userModel.Name
                             };
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *s = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //    Product.ashx?action=SearchChange&changeID= 核销开单id
        CancelPJViewController *cancelVC = [[CancelPJViewController alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=SearchChange&changeID=%@",HomeUrl,s];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

#warning        s是销售单号
            cancelVC.taskID = s;
            cancelVC.Warehouse = self.button1.titleLabel.text;
            cancelVC.ID = [responseObject[@"product"][0][@"ID"] integerValue];
            cancelVC.proCount = responseObject[@"count"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"product"]) {
                [arr addObject:dic];
                
            }
            NSMutableArray *countArr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"changeDatail"]) {
                [countArr addObject:dic];
            }
            //                            cancelVC.Warehouse = Warehouse;
            cancelVC.countList = countArr;
            cancelVC.List = arr;

            [self.navigationController pushViewController:cancelVC animated:YES];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
            HUD.mode = MBProgressHUDModeText;
            HUD.label.text = @"请检查网络";
            [self.view addSubview:HUD];
            [HUD showAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
                [HUD removeFromSuperViewOnHide];
            });
            return ;
        }];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = @"请检查网络";
        [self.view addSubview:HUD];
        [HUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD hideAnimated:YES];
            [HUD removeFromSuperViewOnHide];
        });
        return ;
    }];
    
    
}

- (void)button1Clicked:(UIButton *)sender {
    NameViewController *nvc = [[NameViewController alloc]init];
    nvc.stepList = self.nameList;
    nvc.returnStep = ^(NSString *StepName, NSInteger row){
        [sender setTitle:StepName forState:UIControlStateNormal];
    };
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (void)button2Clicked:(UIButton *)sender {
    
    StoreNameViewController *sVC = [[StoreNameViewController alloc]init];
    sVC.stepList = self.storeNameList;
    sVC.returnStep = ^(NSString *StepName, NSInteger row) {
        [sender setTitle:StepName forState:UIControlStateNormal];
    };
    [self presentViewController:sVC animated:YES completion:nil];
}

- (void)button3Clicked:(UIButton *)sender {
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
    datePickerVC.returnDate = ^(NSString *dateStr){
        
        NSString *year = [dateStr substringToIndex:4];
        NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [dateStr substringFromIndex:8];

        NSString *date = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
        
        
        [sender setTitle:date forState:UIControlStateNormal];
    };
    
    [self presentViewController:datePickerVC animated:YES completion:nil];
    
}

-(void)setNavigationBar {
    
    self.navigationItem.title = @"配件核销";
}

@end
