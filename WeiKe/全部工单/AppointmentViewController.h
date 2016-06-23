//
//  AppointmentViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/16.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^ReturnTime)(NSString *startTime, NSString *endTime);
@interface AppointmentViewController : UIViewController
//@property (nonatomic, copy) ReturnTime returnTime;
@property (nonatomic, strong) UIButton *startTimeButton;
@property (nonatomic, strong) UIButton *endTimeButton;
@property (nonatomic, assign) NSInteger ID;
@end
