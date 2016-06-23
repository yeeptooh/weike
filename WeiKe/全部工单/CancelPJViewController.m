//
//  CancelPJViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "CancelPJViewController.h"
#import "AddTableViewCell.h"
#import "AFNetworking.h"
#import "UserModel.h"
//#import "SearchPJViewController.h"
#import "SchedulingViewController.h"
#import "MBProgressHUD.h"
@interface CancelPJViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label2;
@end

@implementation CancelPJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    [self.view addSubview:HUD];
    [HUD showAnimated:YES];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //Product.ashx?action=SearchChange&changeID= 核销开单id
    NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=SearchChange&changeID=%@",HomeUrl,self.taskID];
    
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.ID = [responseObject[@"product"][0][@"ID"] integerValue];
        self.proCount = responseObject[@"count"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"product"]) {
            [arr addObject:dic];
            
        }
        NSMutableArray *countArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"changeDatail"]) {
            [countArr addObject:dic];
        }
        //                            cancelVC.Warehouse = Warehouse;
        self.countList = countArr;
        self.List = arr;
       
        [HUD hideAnimated:YES];
        [HUD removeFromSuperViewOnHide];
        [self.tableView reloadData];
        if (!self.proCount) {
            self.proCount = @"0";
        }
        _label2.text = [NSString stringWithFormat:@"合计：%@",self.proCount];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



- (void)setUI {
    
    CGFloat fontSize;
    if (iPhone6_plus || iPhone6) {
        fontSize = 17;
    }else{
        fontSize = 14;
    }
    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cButton setTitle:@"查找配件" forState:UIControlStateNormal];
    cButton.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, Width , (Height - StatusBarAndNavigationBarHeight)/10 - 10);
    cButton.backgroundColor = color(23, 133, 255, 1);
    
    cButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    //    cButton.layer.masksToBounds = YES;
    
    
    
    [cButton addTarget:self action:@selector(cButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cButton];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(Width/16, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/10 - 10, Width*4/16, (Height - StatusBarAndNavigationBarHeight)/10 - 10)];
    label1.text = @"已调配件";
    
    label1.font = [UIFont systemFontOfSize:fontSize];
    label1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(Width*5/16, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/10 - 10, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/10 - 10)];
    if (!self.proCount) {
        self.proCount = @"0";
    }
    _label2.text = [NSString stringWithFormat:@"合计：%@",self.proCount];
    _label2.textColor = [UIColor redColor];
    _label2.font = [UIFont systemFontOfSize:fontSize];
    _label2.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_label2];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)/10 - 11 + (Height - StatusBarAndNavigationBarHeight)/10 - 10, Width, 1)];
    view.backgroundColor = color(200, 200, 200, 1);
    [self.view addSubview:view];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + (Height - StatusBarAndNavigationBarHeight)*2/10 - 20, Width, Height - ((Height - StatusBarAndNavigationBarHeight)*2/10 - 20))];
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.List.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AddTableViewCell" owner:self options:nil] lastObject];
    
    
    cell.nameLabel.text = self.List[indexPath.row][@"Name"];
    cell.codeLabel.text = self.List[indexPath.row][@"Code"];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@ x %@ = %.2f",self.List[indexPath.row][@"PriceIn"],self.countList[indexPath.row][@"Count"],[self.List[indexPath.row][@"PriceIn"] floatValue]*[self.countList[indexPath.row][@"Count"] integerValue]];
    cell.button.hidden = YES;
//    [cell.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Product.ashx?action=search companyId condition(默认为"") Warehouse key

- (void)cButtonClicked:(UIButton *)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=search",HomeUrl];
    UserModel *um = [UserModel readUserModel];
    NSDictionary *params = @{
                             @"companyId":[NSNumber numberWithInteger:um.CompanyID],
                             @"condition":@"",
                             @"Warehouse":self.Warehouse,
                             @"key":@""
                             };
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        SchedulingViewController *svc = [[SchedulingViewController alloc]init];
        svc.ID = [self.taskID integerValue];
 
        
        svc.stepList = responseObject[@"storageProduct"];
        svc.returnStep = ^(NSString *StepName, NSInteger row){
            
        };
        
        [self presentViewController:svc animated:YES completion:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}


-(void)setNavigationBar {
    
    self.navigationItem.title = @"配件调拨";
}

- (void)backLastView:(UIBarButtonItem *)sender {
    NSInteger count = self.navigationController.viewControllers.count;
    if (count == 5) {
        UIViewController *VC = self.navigationController.viewControllers[count - 3];
        [self.navigationController popToViewController:VC animated:YES];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
