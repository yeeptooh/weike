//
//  SectionDetailTaskPlanTableViewCell.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/26.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionDetailTaskPlanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *businessInfoButton;

@property (weak, nonatomic) IBOutlet UILabel *ExpectantTime;//预约
@property (weak, nonatomic) IBOutlet UILabel *BrokenPhenomenon;
@property (weak, nonatomic) IBOutlet UILabel *BrokenReason;
@property (weak, nonatomic) IBOutlet UILabel *TaskPostscript;
@property (weak, nonatomic) IBOutlet UILabel *FinishTime;//受理
@property (weak, nonatomic) IBOutlet UILabel *CloseTime;

@end
