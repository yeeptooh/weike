//
//  DetailTaskPlanTableViewCell.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/26.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callblock)(void);

@interface DetailTaskPlanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *BuyerName;
@property (weak, nonatomic) IBOutlet UIButton *BuyAddress;
@property (weak, nonatomic) IBOutlet UILabel *BuyerPhone;
@property (weak, nonatomic) IBOutlet UILabel *InfoFrom;
@property (weak, nonatomic) IBOutlet UILabel *BillCode;
@property (weak, nonatomic) IBOutlet UILabel *CallPhone;
@property (nonatomic, copy) NSString *CallPhoneString;
@property (nonatomic, copy) callblock  _block;
@property (weak, nonatomic) IBOutlet UIButton *dialogButton;
@end
