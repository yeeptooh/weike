//
//  TaskPlanToDoTableViewCell.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "TaskPlanToDoTableViewCell.h"

@implementation TaskPlanToDoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.TasdPlanCellBackView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
