//
//  CancelPJViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/4/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface CancelPJViewController : BaseViewController
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSMutableArray *List;
@property (nonatomic, strong) NSMutableArray *countList;

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *Warehouse;



@property (nonatomic, strong) NSString *proCount;
@property (nonatomic, strong) NSString *proMoney;
@property (nonatomic, strong) NSString *proSum;



@property (nonatomic, strong) NSString *taskID;
@end
