//
//  TaskPlanToDoTableViewCell.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskPlanToDoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *TasdPlanCellBackView;
@property (weak, nonatomic) IBOutlet UILabel *appointmentTime;
@property (weak, nonatomic) IBOutlet UILabel *limitTime;
@property (weak, nonatomic) IBOutlet UILabel *SendName;
@property (weak, nonatomic) IBOutlet UILabel *User;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *Infoform;
@property (weak, nonatomic) IBOutlet UILabel *UserCity;
@property (weak, nonatomic) IBOutlet UILabel *OrderID;
@property (weak, nonatomic) IBOutlet UILabel *OrderState;

@end
