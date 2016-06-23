//
//  OrderModel.m
//  WeiKe
//
//  Created by 张冬冬 on 16/5/12.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
+ (instancetype)orderFromDictionary:(NSDictionary *)dictionary {
    return [[self alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        /*
         
         @property (nonatomic, strong) NSString *BuyerAddress;
         @property (nonatomic, strong) NSString *ExpectantTime;
         @property (nonatomic, strong) NSString *CloseTime;
         @property (nonatomic, strong) NSString *BuyerName;
         
         @property (nonatomic, strong) NSString *BuyerPhone;
         @property (nonatomic, strong) NSString *InfoFrom;
         @property (nonatomic, strong) NSString *BuyerCity;
         @property (nonatomic, strong) NSString *ID;
         
         @property (nonatomic, strong) NSString *StateStr;
         @property (nonatomic, strong) NSString *ServiceClassify;
         @property (nonatomic, strong) NSString *ProductBreed;
         @property (nonatomic, strong) NSString *ProductClassify;
         
         @property (nonatomic, strong) NSString *UnFinishRemark;
         @property (nonatomic, strong) NSString *CancelReason;
         @property (nonatomic, strong) NSString *CancelReason2;
         @property (nonatomic, strong) NSString *NoEntryReason;
         @property (nonatomic, strong) NSString *Change;
         */
        self.ReceiveTaskStr = dictionary[@"ReceiveTaskStr"];
        self.BuyerAddress = dictionary[@"BuyerAddress"];
        self.ExpectantTime = dictionary[@"ExpectantTime"];
        self.CloseTime = dictionary[@"CloseTime"];
        self.BuyerName = dictionary[@"BuyerName"];
        self.BuyerPhone = dictionary[@"BuyerPhone"];
        
        self.InfoFrom = dictionary[@"InfoFrom"];
        self.BuyerCity = dictionary[@"BuyerCity"];
        self.ID = dictionary[@"ID"];
        self.State = dictionary[@"State"];
        
        self.StateStr = dictionary[@"StateStr"];
        
        self.ServiceClassify = dictionary[@"ServiceClassify"];
        self.ProductBreed = dictionary[@"ProductBreed"];
        self.ProductClassify = dictionary[@"ProductClassify"];
        
        self.UnFinishRemark = dictionary[@"UnFinishRemark"];
        self.CancelReason = dictionary[@"CancelReason"];
        self.CancelReason2 = dictionary[@"CancelReason2"];
        self.NoEntryReason = dictionary[@"NoEntryReason"];
        self.Change = dictionary[@"Change"];
        
        /*
         
         
        
         
         @property (nonatomic, strong) NSString *ExpectantTimeStr;
         @property (nonatomic, strong) NSString *BrokenPhenomenon;
         @property (nonatomic, strong) NSString *BrokenReason;
         @property (nonatomic, strong) NSString *TaskPostscript;
         @property (nonatomic, strong) NSString *FinishTime;
         */
        
        
        
        self.BuyerShortAddress = dictionary[@"BuyerShortAddress"];
        self.BuyerDistrict = dictionary[@"BuyerDistrict"];
        self.BuyerTown = dictionary[@"BuyerTown"];
        
        self.CallPhone = dictionary[@"CallPhone"];
        self.BillCode = dictionary[@"BillCode"];
        
        self.ProductType = dictionary[@"ProductType"];
        self.BarCode = dictionary[@"BarCode"];
        self.BarCode2 = dictionary[@"BarCode2"];
        self.BuyerPhone2 = dictionary[@"BuyerPhone2"];
        
        self.BuyTimeStr = dictionary[@"BuyTimeStr"];
        
        self.RepairType = dictionary[@"RepairType"];
        
        
        
        
        
        self.ExpectantTimeStr = dictionary[@"ExpectantTimeStr"];
        self.BrokenPhenomenon = dictionary[@"BrokenPhenomenon"];
        
        self.BrokenReason = dictionary[@"BrokenReason"];
        self.TaskPostscript = dictionary[@"TaskPostscript"];
        self.FinishTime = dictionary[@"FinishTime"];
        self.SwiftNumber = dictionary[@"SwiftNumber"];
        self.AddTime = dictionary[@"AddTime"];
        /*
         
         @property (nonatomic, strong) NSString *PriceAppend;
         @property (nonatomic, strong) NSString *PriceService;
         @property (nonatomic, strong) NSString *PriceMaterials;
         @property (nonatomic, strong) NSString *WorkPostscript;
         
         @property (nonatomic, strong) NSString *MoneyService;
         @property (nonatomic, strong) NSString *MoneyMaterials;
         @property (nonatomic, strong) NSString *MoneyAppend;
         @property (nonatomic, strong) NSString *WaiterName;
         
         @property (nonatomic, strong) NSString *WorkScore;
         
         
         //@property (nonatomic, strong) NSString *Change;
         @property (nonatomic, strong) NSString *DCode;
         @property (nonatomic, strong) NSString *CheckCode;
         @property (nonatomic, strong) NSString *PCode;
         
         @property (nonatomic, strong) NSString *PickCode;
         */
        
        self.PriceAppend = dictionary[@"PriceAppend"];
        self.PriceService = dictionary[@"PriceService"];
        self.PriceMaterials = dictionary[@"PriceMaterials"];
        
        self.WorkPostscript = dictionary[@"WorkPostscript"];
        self.MoneyService = dictionary[@"MoneyService"];
        
        self.MoneyMaterials = dictionary[@"MoneyMaterials"];
        self.MoneyAppend = dictionary[@"MoneyAppend"];
        
        
        
        self.WaiterName = dictionary[@"WaiterName"];
        self.WorkScore = dictionary[@"WorkScore"];
        
        self.DCode = dictionary[@"DCode"];
        
        self.CheckCode = dictionary[@"CheckCode"];
        self.BuyAddress = dictionary[@"BuyAddress"];
        
        
        
        
        self.PCode = dictionary[@"PCode"];
        self.PickCode = dictionary[@"PickCode"];
        
        
        
        
        
    }
    return self;
}

@end
