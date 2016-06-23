//
//  ToCompleteTheWorkOrderViewController.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/1.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToCompleteTheWorkOrderViewController : UIViewController
@property (nonatomic,assign) NSInteger taskID;
@property (nonatomic,copy) NSString*WaiterName;
@property (nonatomic,strong) NSString *FinishTime;
@property (nonatomic,strong) NSString *BarCode;
@property (nonatomic,strong) NSString *BarCode2;
@property (nonatomic,strong) NSString *WorkPostscript;
@property (nonatomic,strong) NSString *BrokenReason;
@property (nonatomic,strong) NSString *Change;
@property (nonatomic,strong) NSString *DCode;
@property (nonatomic,strong) NSString *CheckCode;
@property (nonatomic,strong) NSString *PCode;
@property (nonatomic,strong) NSString *PickCode;
@property (nonatomic,strong) NSString *PriceService;
@property (nonatomic,strong) NSString *PriceMaterials;
@property (nonatomic,strong) NSString *PriceAppend;


@property (nonatomic, strong) NSString *cpOreder;

@property (nonatomic,strong) NSString *InvoiceCode;
@property (nonatomic,assign) NSInteger theway;
@end
