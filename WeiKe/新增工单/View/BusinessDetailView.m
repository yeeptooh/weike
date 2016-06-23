//
//  BusinessDetailView.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "BusinessDetailView.h"
#import "UserModel.h"

#import "AFNetworking.h"

#import "ServiceViewController.h"
#import "TypeViewController.h"
#import "DatePickerViewController.h"

@interface BusinessDetailView()
@property (nonatomic, strong) NSMutableArray *serviceList;
@end

@implementation BusinessDetailView

- (NSMutableArray *)serviceList {
    if (!_serviceList) {
        _serviceList = [NSMutableArray array];
    }
    return _serviceList;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.baseFrame = frame;
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = color(241, 241, 241, 1);
        self.tableFooterView = [[UIView alloc]init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self netWorkingRequest];
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *labelList = @[@"服务类型",
                           @"保修性质",
                           @"预约时间",
                           @"备 注",
                           ];
    static NSString *identifier = @"Mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
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
                [button setTitle:@"配送" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceList"][0] forState:UIControlStateNormal];
            }
  
        }
        
        if (indexPath.row == 1) {
            [button setTitle:@"保内" forState:UIControlStateNormal];
        }
        
        
    }else if(indexPath.row == 3){
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.layer.cornerRadius = 5;
        textfield.layer.masksToBounds = YES;
        textfield.backgroundColor = [UIColor whiteColor];
        
        
        textfield.tag = 100 + indexPath.row;
        [cell addSubview:textfield];
    }else {
        
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
    }
    
    return cell;
}

- (void)netWorkingRequest {
    UserModel *userModel = [UserModel readUserModel];
    /*
     Task.ashx?action=getservicetype&comid= parent(产品类型)
     */
    [[NSUserDefaults standardUserDefaults] setObject:@"保内" forKey:@"serivcePro"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSInteger productID = [[NSUserDefaults standardUserDefaults] integerForKey:@"productID"];
    NSString *serviceURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getservicetype&comid=%ld&parent=%ld",HomeUrl,(long)userModel.CompanyID,(long)productID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:serviceURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *IDList = [NSMutableArray array];
        
        for (NSDictionary *dic in responseObject[@"servicetype"]) {
            [self.serviceList addObject:dic[@"Name"]];
            [IDList addObject:dic[@"ID"]];
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:IDList forKey:@"serviceIDList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:IDList[0] forKey:@"serviceID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.serviceList forKey:@"serviceList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.serviceList[0] forKey:@"serviceType"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

- (void)buttonClicked:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.tag == 200) {
        
        ServiceViewController *serviceVC = [[ServiceViewController alloc]init];
        
        serviceVC.serviceList = self.serviceList;
        serviceVC.returnService = ^(NSString *name, NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setObject:self.serviceList[row] forKey:@"serviceType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceIDList"][row] forKey:@"serviceID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        };
        
        
        [[self viewController] presentViewController:serviceVC animated:YES completion:nil];
        
    }else if(sender.tag == 201){
        
        TypeViewController *typeVC = [[TypeViewController alloc]init];
        typeVC.returnType = ^(NSInteger row){
            if (row == 0) {
                [sender setTitle:@"保内" forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults] setObject:@"保内" forKey:@"serivcePro"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            if (row == 1) {
                [sender setTitle:@"保外" forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults] setObject:@"保外" forKey:@"serivcePro"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        };
        
        [[self viewController] presentViewController:typeVC animated:YES completion:nil];
        
    }else{
        DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
        datePickerVC.returnDate = ^(NSString *dateStr){
            [sender setTitle:dateStr forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setObject:dateStr forKey:@"date"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        };
        
         [[self viewController] presentViewController:datePickerVC animated:YES completion:nil];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (iPhone4_4s) {
        if (textField.tag == 102) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 50;
                
                self.frame = frame;
            }];
        }
        
        if (textField.tag == 103) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 55;
                
                self.frame = frame;
            }];
        }
    }
    
    if (textField.tag == 103) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.frame;
            frame.origin.y = frame.origin.y - 40;
            
            self.frame = frame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 102) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = self.baseFrame;
        }];
    }
    
    if (textField.tag == 103) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = self.baseFrame;
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 103) {
        [self endEditing:YES];
    }else{
        UITextField *lastTextField = (UITextField *)[self viewWithTag:textField.tag];
        [lastTextField resignFirstResponder];
        
        UITextField *nextTextField = (UITextField *)[self viewWithTag:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
         
- (UIViewController*)viewController {
 for (UIView* next = [self superview]; next; next = next.superview) {
     UIResponder* nextResponder = [next nextResponder];
     if ([nextResponder isKindOfClass:[UIViewController class]]) {
         return (UIViewController*)nextResponder;
     }
 }
 return nil;
}

@end
