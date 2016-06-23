//
//  SchedulingViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "SchedulingViewController.h"
#import "AddTableViewCell.h"
//#import "AddView.h"
#import "SchedulingView.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

#import "UserModel.h"
@interface SchedulingViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIViewControllerTransitioningDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SchedulingView *addView;
@end

@implementation SchedulingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, Width, self.view.bounds.size.height - 150) style:UITableViewStylePlain];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(Width*6/7, 5, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"icon_login_close_pre"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon_login_close_nor"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.transitioningDelegate = self;
    self.modalTransitionStyle = UIModalPresentationCustom;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.stepList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *identifier = @"Mycell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    //
    //    cell.textLabel.text = self.stepList[indexPath.row];
    AddTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AddTableViewCell" owner:self options:nil] lastObject];
    cell.nameLabel.text = self.stepList[indexPath.row][@"Name"];
    cell.codeLabel.text = self.stepList[indexPath.row][@"Code"];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@元",self.stepList[indexPath.row][@"PriceIn"]];
    
    cell.button.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    self.returnStep(self.stepList[indexPath.row], indexPath.row);
    
    
    NSLog(@"-0++++%@",self.stepList);
    
    AddTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.addView = [[SchedulingView alloc]initWithFrame:self.view.bounds];
    self.addView.nameLabel.text = [NSString stringWithFormat:@" %@",cell.nameLabel.text];
    self.addView.count.text = [NSString stringWithFormat:@" 剩余：%@",self.stepList[indexPath.row][@"CountLeave"]];
    self.addView.leaveCount = self.stepList[indexPath.row][@"CountLeave"];
    self.addView.saleLabel.text = [NSString stringWithFormat:@"%@",self.stepList[indexPath.row][@"PriceSell"]];
    NSLog(@"+++++%@",self.stepList[indexPath.row][@"PriceSell"]);
    self.addView.buyLabel.text = [NSString stringWithFormat:@"%@",self.stepList[indexPath.row][@"PriceIn"]];
    self.addView.ID = self.stepList[indexPath.row][@"ID"];
    
    [self. addView.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self. addView.quitButton addTarget:self action:@selector(quitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.addView];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.addView.containerView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}
//Product.ashx?action=addware companyId orderId priceSell productId count handler(用户名) postscript
- (void)addButtonClicked {
    [self.view endEditing:YES];
    if ([self.addView.leaveCount integerValue] < [self.addView.saleTextfield.text integerValue]|| [self.addView.saleTextfield.text isEqualToString:@""]) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.addView];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = @"输入数量有误";
        [self.addView addSubview:HUD];
        [HUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD hideAnimated:YES];
            [HUD removeFromSuperViewOnHide];
        });
        return ;
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=addChangr",HomeUrl];
        UserModel *um = [UserModel readUserModel];
        NSLog(@"-%@",[NSNumber numberWithInteger:um.CompanyID]);
        NSLog(@"--%@",[NSString stringWithFormat:@"%ld",(long)self.ID]);
        NSLog(@"---%ld",self.ID);
        NSLog(@"----%@",self.addView.ID);
        NSLog(@"-----%@",self.addView.saleTextfield.text);
        NSLog(@"------%@",self.addView.psTextfield.text);
        NSLog(@"-------%@",um.Name);
        
        NSDictionary *params = @{
                                 @"companyId":[NSNumber numberWithInteger:um.CompanyID],
                                 @"changeID":[NSString stringWithFormat:@"%ld",(long)self.ID],
                                 @"productId":self.addView.ID,
                                 @"count":self.addView.saleTextfield.text,
                                 @"name":um.Name,
                                 @"postscript":self.addView.psTextfield.text
                                 };
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.addView];
            HUD.mode = MBProgressHUDModeText;
            HUD.label.text = @"调动成功";
            [self.addView addSubview:HUD];
            [HUD showAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
                [HUD removeFromSuperViewOnHide];
                NSLog(@"--00--++%@",responseObject);
                [UIView animateWithDuration:0.5 animations:^{
                    self.addView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.addView removeFromSuperview];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            });
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.userInfo);
        }];
        
        
        
        
        
    }
    
    
}

- (void)quitButtonClicked {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.75 animations:^{
        self.addView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.addView removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionPresent duration:0.25 presentHeight:Height - StatusBarAndNavigationBarHeight scale:CGPointMake(0.9, 0.9)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionDismiss duration:0.25 presentHeight:Height - StatusBarAndNavigationBarHeight scale:CGPointMake(0.9, 0.9)];
}

@end
