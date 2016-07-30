//
//  DetailTaskPlanViewController.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "OrderModel.h"

@interface DetailTaskPlanViewController : BaseViewController


//@property (nonatomic, strong) NSMutableArray *responesList;
@property (nonatomic, strong) OrderModel *orderModel;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *theStatus;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) void (^block)(NSString*str);

@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, assign, getter=isCancel) BOOL cancel;
@property (nonatomic, assign, getter=isChange) BOOL change;

@property (nonatomic, strong) NSString *fromUserID;
@property (nonatomic, strong) NSString *fromUserName;
@property (nonatomic, strong) NSString *toUserID;
@property (nonatomic, strong) NSString *toUserName;

/********接收修改属性***********/
@property (nonatomic, strong) NSString *username;






@end
