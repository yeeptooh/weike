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
