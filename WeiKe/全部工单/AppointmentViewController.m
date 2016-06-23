//
//  AppointmentViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/5/16.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AFNetworking.h"
#import "UserModel.h"
//#import "TimeViewController.h"
#import "MBProgressHUD.h"
@interface AppointmentViewController ()
<
UIViewControllerTransitioningDelegate
>
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, assign) NSInteger flag;
@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.transitioningDelegate = self;
    self.modalTransitionStyle = UIModalPresentationCustom;
    
    UILabel *appointmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, Width/4, 50)];
    appointmentLabel.text = @"预约时间:";
    appointmentLabel.textAlignment = NSTextAlignmentCenter;
    appointmentLabel.font = [UIFont systemFontOfSize:16];
    appointmentLabel.backgroundColor = [UIColor clearColor];
    appointmentLabel.textColor = [UIColor blackColor];
    [self.view addSubview:appointmentLabel];
    
    
    self.startTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startTimeButton setTitle:@"起始时间" forState:UIControlStateNormal];
    [self.startTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.startTimeButton addTarget:self action:@selector(startTimeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.startTimeButton.backgroundColor = [UIColor clearColor];//color(23, 133, 255, 1);
    self.startTimeButton.frame = CGRectMake(Width/4,25,Width*5/16,40);
    [self.view addSubview:self.startTimeButton];
    
    UIView *startLineView = [[UIView alloc]initWithFrame:CGRectMake(Width/4, 69, Width*5/16, 1)];
    startLineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:startLineView];
    
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width*9/16,20,Width/8,50)];
    lineLabel.text = @"-";
    lineLabel.textAlignment = NSTextAlignmentCenter;
    lineLabel.font = [UIFont systemFontOfSize:14];
    lineLabel.backgroundColor = [UIColor clearColor];
    lineLabel.textColor = [UIColor blackColor];
    [self.view addSubview:lineLabel];
    
    self.endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.endTimeButton setTitle:@"截止时间" forState:UIControlStateNormal];
    [self.endTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.endTimeButton addTarget:self action:@selector(endTimeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.endTimeButton.backgroundColor = [UIColor clearColor];//[UIColor lightGrayColor];//color(23, 133, 255, 1);
    self.endTimeButton.frame = CGRectMake(Width*11/16,25,Width*5/16,40);
    [self.view addSubview:self.endTimeButton];
    
    UIView *endLineView = [[UIView alloc]initWithFrame:CGRectMake(Width*11/16, 69, Width*5/16, 1)];
    endLineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:endLineView];
    
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80, Width, 216)];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    [self.view addSubview:self.datePicker];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake((Width-300)/4 + (100 + (Width-300)/4)*2, 300, 100, 40);
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.masksToBounds = YES;
    backBtn.backgroundColor = color(59, 165, 249, 1);
    [backBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [backBtn setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton setTitle:@"选择" forState:UIControlStateNormal];
    self.saveButton.layer.cornerRadius = 5;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.backgroundColor = color(59, 165, 249, 1);
    [self.saveButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [self.saveButton setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [self.saveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.frame = CGRectMake((Width-300)/4 + (100 + (Width-300)/4), 300, 100, 40);
    [self.view addSubview:self.saveButton];
    
    UIButton *appointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [appointmentButton setTitle:@"预约" forState:UIControlStateNormal];
    appointmentButton.layer.cornerRadius = 5;
    appointmentButton.layer.masksToBounds = YES;
    appointmentButton.backgroundColor = color(59, 165, 249, 1);
    [appointmentButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [appointmentButton setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [appointmentButton addTarget:self action:@selector(appointmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    appointmentButton.frame = CGRectMake((Width-300)/4, 300, 100, 40);
    [self.view addSubview:appointmentButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)startTimeButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.endTimeButton.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.backgroundColor = color(241, 241, 241, 1);
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.endTimeButton.backgroundColor = [UIColor clearColor];
            [self.endTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }];
        
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            sender.backgroundColor = [UIColor clearColor];
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.endTimeButton.backgroundColor = color(241, 241, 241, 1);
            [self.endTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        }];
    }
    self.flag = 1;
}

- (void)endTimeButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.startTimeButton.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.2 animations:^{
            self.startTimeButton.backgroundColor = [UIColor clearColor];
            [self.startTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            sender.backgroundColor = color(241, 241, 241, 1);
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            sender.backgroundColor = [UIColor clearColor];
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.startTimeButton.backgroundColor = color(241, 241, 241, 1);
            [self.startTimeButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        }];
    }
    self.flag = 2;
}


- (void)saveButtonClicked:(UIButton *)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSString *dateString = [formatter stringFromDate:self.datePicker.date];

    if (self.startTimeButton.selected) {
        [self.startTimeButton setTitle:dateString forState:UIControlStateNormal];
        [self.startTimeButton setTitle:dateString forState:UIControlStateSelected];
        return;
    }
    
    if (self.endTimeButton.selected) {
        
        [self.endTimeButton setTitle:dateString forState:UIControlStateNormal];
        [self.endTimeButton setTitle:dateString forState:UIControlStateSelected];
        return;
    }


}

- (void)appointmentButtonClicked:(UIButton *)sender {
    
    if ([self.startTimeButton.titleLabel.text isEqualToString:@"起始时间"]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请选择起始时间";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
        });
        return;
    }
    
    if ([self.endTimeButton.titleLabel.text isEqualToString:@"截止时间"]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请选择结束时间";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
        });
        return;
    }
    
    
    NSString *startTime = self.startTimeButton.titleLabel.text;
    NSString *endTime = self.endTimeButton.titleLabel.text;
    
    NSString *subToStartTime = [startTime substringToIndex:2];
    NSString *subToEndTime = [endTime substringToIndex:2];
    
    NSString *rangeStartTime = [startTime substringWithRange:NSMakeRange(3, 1)];
    NSString *rangeEndTime = [endTime substringWithRange:NSMakeRange(3, 1)];
    
    NSString *subFromStartTime = [startTime substringFromIndex:3];
    NSString *subFromEndTime = [endTime substringFromIndex:3];
    
    if ([subToEndTime integerValue] < [subToStartTime integerValue]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"截止时间不能早于起始时间";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
        });
        return;
    }
    
    if (([subToEndTime integerValue] == [subToStartTime integerValue]) && ([rangeStartTime integerValue] > [rangeEndTime integerValue])) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"截止时间不能早于起始时间";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
        });
        return;
    }
    
    if (([subToEndTime integerValue] == [subToStartTime integerValue]) && ([rangeStartTime integerValue] == [rangeEndTime integerValue]) &&([subFromStartTime integerValue] > [subFromEndTime integerValue])) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"截止时间不能早于起始时间";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
        });
        return;
    }
    //预约参数有问题
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *params = @{
                             @"taskID":@(self.ID),
                             @"time1":self.startTimeButton.titleLabel.text ,
                             @"time2":self.endTimeButton.titleLabel.text};

    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=updateExpectantTime",HomeUrl];
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *data = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"预约成功";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
            [self dismissViewControllerAnimated:YES completion:nil];
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"预约失败";
        hud.label.font = font(14);
        [self.view addSubview:hud];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        
    }];
}

- (void)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionPresent duration:0.25 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionDismiss duration:0.25 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}










@end
