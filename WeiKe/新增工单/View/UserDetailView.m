//
//  UserDetailView.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "UserDetailView.h"
#import "AFNetworking.h"
#import "UserModel.h"

#import "InfoViewController.h"
#import "CityViewController.h"
#import "DistricsViewController.h"
#import "TownViewController.h"

@interface UserDetailView ()

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *districtsName;
@property (nonatomic, strong) NSString *townName;

@property (nonatomic, strong) NSMutableArray *infoList;
@property (nonatomic, strong) NSMutableArray *cityList;
@property (nonatomic, strong) NSMutableArray *discList;
@property (nonatomic, strong) NSMutableArray *townList;

@property (nonatomic, strong) NSMutableArray *cityIDList;
@property (nonatomic, strong) NSMutableArray *discIDList;
@property (nonatomic, strong) NSMutableArray *townIDList;

@end

@implementation UserDetailView

- (NSMutableArray *)infoList {
    if (!_infoList) {
        _infoList = [NSMutableArray array];
    }
    return _infoList;
}

- (NSMutableArray *)cityList {
    if (!_cityList) {
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}

- (NSMutableArray *)discList {
    if (!_discList) {
        _discList = [NSMutableArray array];
    }
    return _discList;
}

- (NSMutableArray *)townList {
    if (!_townList) {
        _townList = [NSMutableArray array];
    }
    return _townList;
}

- (NSMutableArray *)cityIDList {
    if (!_cityIDList) {
        _cityIDList = [NSMutableArray array];
    }
    return _cityIDList;
}

- (NSMutableArray *)discIDList {
    if (!_discIDList) {
        _discIDList = [NSMutableArray array];
    }
    return _discIDList;
}

- (NSMutableArray *)townIDList {
    if (!_townIDList) {
        _townIDList = [NSMutableArray array];
    }
    return _townIDList;
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
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *labelList = @[@"姓 名",
                           @"手 机",
                           @"单据号码",
                           @"信息来源",
                           @"城市",
                           @"市/县/区",
                           @"街 道",
                           @"详细地址"];
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
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 7) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.layer.cornerRadius = 5;
        textfield.layer.masksToBounds = YES;
        textfield.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 1) {
            textfield.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row != 7) {
            textfield.returnKeyType = UIReturnKeyNext;
        }else{
            textfield.returnKeyType = UIReturnKeyDone;
        }
        textfield.tag = 100 + indexPath.row;
        [cell addSubview:textfield];
    }
    if (indexPath.row >= 3 && indexPath.row <=6) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = indexPath.row + 200;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
       
        if (indexPath.row == 3) {
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"400派工" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"infoResponseObject"][0][@"Name"] forState:UIControlStateNormal];
            }

        }
 
        if (indexPath.row == 4) {
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"佛山" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"cityResponseObject"][0][@"Name"] forState:UIControlStateNormal];
            }

        }

        if (indexPath.row == 5) {
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"顺德" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"distResponseObject"][0][@"Name"] forState:UIControlStateNormal];
            }

        }

        if (indexPath.row == 6) {
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"北滘" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"townResponseObject"][0][@"Name"] forState:UIControlStateNormal];
            }

        }
        
    }    return cell;
}

- (void)buttonClicked:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.tag == 203) {
        InfoViewController *infoVC = [[InfoViewController alloc]init];
        
        infoVC.infoList = self.infoList;
        
        infoVC.returnInfo = ^(NSString *info, NSInteger row){
            [sender setTitle:info forState:UIControlStateNormal];
        };
        
        [[self viewController] presentViewController:infoVC animated:YES completion:nil];
    }else if (sender.tag == 204) {
        CityViewController *cityVC = [[CityViewController alloc]init];
        cityVC.cityList = self.cityList;
        
        cityVC.returnCity = ^(NSString *cityName,NSInteger row){
            [sender setTitle:cityName forState:UIControlStateNormal];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            UserModel *userModel = [UserModel readUserModel];
            
            
            NSString *districtsURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=getdistricts&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,self.cityIDList[row]];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.cityIDList[row] forKey:@"cityID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            

            [manager GET:districtsURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.discList removeAllObjects];
                [self.discIDList removeAllObjects];
                for (NSDictionary *dic in responseObject) {
                    [self.discList addObject:dic[@"Name"]];
                    [self.discIDList addObject:dic[@"ID"]];
                }
                

                
                UIButton *btn = [self viewWithTag:205];
                if (self.discList.count != 0) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.discIDList[0] forKey:@"distID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [btn setTitle:self.discList[0] forState:UIControlStateNormal];
                    
                    NSString *townURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=gettown&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,self.discIDList[0]];
                    [manager GET:townURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        [self.townList removeAllObjects];
                        [self.townIDList removeAllObjects];
                        for (NSDictionary *dic in responseObject) {
                            [self.townList addObject:dic[@"Name"]];
                            [self.townIDList addObject:dic[@"ID"]];
                        }
                        NSLog(@"-----%@",self.townIDList);
                        
                        UIButton *btn = [self viewWithTag:206];
                        if (self.townList.count != 0) {
                            [[NSUserDefaults standardUserDefaults] setObject:self.townIDList[0] forKey:@"townID"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            [btn setTitle:self.townList[0] forState:UIControlStateNormal];
                        }else{
                            [btn setTitle:@"" forState:UIControlStateNormal];
                        }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
                }else{
                    [btn setTitle:@"" forState:UIControlStateNormal];
                    
                    [self.townList removeAllObjects];
                    [self.townIDList removeAllObjects];
                    UIButton *btn = [self viewWithTag:206];
                    [btn setTitle:@"" forState:UIControlStateNormal];
                    
                }
 
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        };
        
        
        [[self viewController] presentViewController:cityVC animated:YES completion:nil];
        
    }else if (sender.tag == 205) {
        DistricsViewController *discVC = [[DistricsViewController alloc]init];
        discVC.discList = self.discList;
        discVC.returnDisc = ^(NSString *discName,NSInteger row){
            [sender setTitle:discName forState:UIControlStateNormal];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            UserModel *userModel = [UserModel readUserModel];
            
            NSString *townURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=gettown&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,self.discIDList[row]];
            [[NSUserDefaults standardUserDefaults] setObject:self.discIDList[row] forKey:@"distID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIButton *btn = [self viewWithTag:206];
            [manager GET:townURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.townIDList removeAllObjects];
                [self.townList removeAllObjects];
                for (NSDictionary *dic in responseObject) {
                    [self.townList addObject:dic[@"Name"]];
                    [self.townIDList addObject:dic[@"ID"]];
                    
                }
                
                
                if (self.townList.count != 0) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.townIDList[0] forKey:@"townID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [btn setTitle:self.townList[0] forState:UIControlStateNormal];
                }else{
                    [btn setTitle:@"" forState:UIControlStateNormal];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        };
        
        [[self viewController] presentViewController:discVC animated:YES completion:nil];
    }else {
        TownViewController *townVC = [[TownViewController alloc]init];
        townVC.townList = self.townList;
        townVC.returnTown = ^(NSString *townName, NSInteger row){
            [sender setTitle:townName forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setObject:self.townIDList[row] forKey:@"townID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        };
        
        [[self viewController] presentViewController:townVC animated:YES completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 107) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.frame;
            frame.origin.y = frame.origin.y - 150;
            
            self.frame = frame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 107) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = self.baseFrame;
        }];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 107) {
        [self endEditing:YES];
    }else{
        
        if (textField.tag == 102) {
            UITextField *lastTextField = (UITextField *)[self viewWithTag:textField.tag];
            [lastTextField resignFirstResponder];
            UITextField *nextTextField = (UITextField *)[self viewWithTag:107];
            [nextTextField becomeFirstResponder];
        }else{
            UITextField *lastTextField = (UITextField *)[self viewWithTag:textField.tag];
            [lastTextField resignFirstResponder];
            
            UITextField *nextTextField = (UITextField *)[self viewWithTag:textField.tag + 1];
            [nextTextField becomeFirstResponder];
        }
    }
 
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)netWorkingRequest {
    UserModel *userModel = [UserModel readUserModel];
    NSString *infoURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=getinfofrom&comid=%ld",HomeUrl,(long)userModel.CompanyID];
    NSString *cityURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=getcity&comid=%ld",HomeUrl,(long)userModel.CompanyID];
    
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:infoURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"infoResponseObject"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        for (NSDictionary *dic in responseObject) {
            [self.infoList addObject:dic[@"Name"]];
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    [manager GET:cityURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"cityResponseObject"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        weakSelf.cityName = responseObject[0][@"Name"];
        NSString *ID = responseObject[0][@"ID"];
        
            for (NSDictionary *dic in responseObject) {
                [self.cityList addObject:dic[@"Name"]];
                [self.cityIDList addObject:dic[@"ID"]];
            }
        [[NSUserDefaults standardUserDefaults] setObject:ID forKey:@"cityID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *districtsURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=getdistricts&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,ID];
        
        [manager GET:districtsURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"distResponseObject"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            weakSelf.districtsName = responseObject[0][@"Name"];
            
                for (NSDictionary *dic in responseObject) {
                    [self.discList addObject:dic[@"Name"]];
                    [self.discIDList addObject:dic[@"ID"]];
                }
            
            
            NSString *ID = responseObject[0][@"ID"];
            [[NSUserDefaults standardUserDefaults] setObject:ID forKey:@"distID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *townURLString = [NSString stringWithFormat:@"%@/Common.ashx?action=gettown&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,ID];
            
            [manager GET:townURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"townResponseObject"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                weakSelf.townName = responseObject[0][@"Name"];
                
                    for (NSDictionary *dic in responseObject) {
                        [self.townList addObject:dic[@"Name"]];
                        [self.townIDList addObject:dic[@"ID"]];
                    }
                [[NSUserDefaults standardUserDefaults] setObject:self.townIDList[0] forKey:@"townID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
               
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

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
