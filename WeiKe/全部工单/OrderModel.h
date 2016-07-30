//
//  OrderModel.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/12.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic, strong) NSString *ReceiveTaskStr;
@property (nonatomic, strong) NSString *SwiftNumber;

@property (nonatomic, strong) NSString *BuyerAddress;
@property (nonatomic, strong) NSString *ExpectantTime;
@property (nonatomic, strong) NSString *CloseTime;
@property (nonatomic, strong) NSString *BuyerName;
@property (nonatomic, strong) NSString *AddTime;

@property (nonatomic, strong) NSString *BuyerPhone;
@property (nonatomic, strong) NSString *InfoFrom;
@property (nonatomic, strong) NSString *BuyerCity;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *State;

@property (nonatomic, strong) NSString *StateStr;
@property (nonatomic, strong) NSString *ServiceClassify;
@property (nonatomic, strong) NSString *ProductBreed;
@property (nonatomic, strong) NSString *ProductClassify;

@property (nonatomic, strong) NSString *UnFinishRemark;
@property (nonatomic, strong) NSString *CancelReason;
@property (nonatomic, strong) NSString *CancelReason2;
@property (nonatomic, strong) NSString *NoEntryReason;
@property (nonatomic, strong) NSString *Change;




//@property (nonatomic, strong) NSString *BuyerName;
@property (nonatomic, strong) NSString *BuyerShortAddress;
//@property (nonatomic, strong) NSString *BuyerPhone;
@property (nonatomic, strong) NSString *BuyerDistrict;
@property (nonatomic, strong) NSString *BuyerTown;
//@property (nonatomic, strong) NSString *InfoFrom;
@property (nonatomic, strong) NSString *CallPhone;
@property (nonatomic, strong) NSString *BillCode;

@property (nonatomic, strong) NSString *ProductType;
@property (nonatomic, strong) NSString *BarCode;
@property (nonatomic, strong) NSString *BarCode2;
@property (nonatomic, strong) NSString *BuyerPhone2;
@property (nonatomic, strong) NSString *BuyTimeStr;
@property (nonatomic, strong) NSString *RepairType;
//@property (nonatomic, strong) NSString *CloseTime;

@property (nonatomic, strong) NSString *ExpectantTimeStr;
@property (nonatomic, strong) NSString *BrokenPhenomenon;
@property (nonatomic, strong) NSString *BrokenReason;
@property (nonatomic, strong) NSString *TaskPostscript;
@property (nonatomic, strong) NSString *FinishTime;


@property (nonatomic, strong) NSString *PriceAppend;
@property (nonatomic, strong) NSString *PriceService;
@property (nonatomic, strong) NSString *PriceMaterials;
@property (nonatomic, strong) NSString *WorkPostscript;

@property (nonatomic, strong) NSString *MoneyService;
@property (nonatomic, strong) NSString *MoneyMaterials;
@property (nonatomic, strong) NSString *MoneyAppend;
@property (nonatomic, strong) NSString *WaiterName;

@property (nonatomic, strong) NSString *WorkScore;
@property (nonatomic, strong) NSString *BuyAddress;

//@property (nonatomic, strong) NSString *Change;
@property (nonatomic, strong) NSString *DCode;
@property (nonatomic, strong) NSString *CheckCode;
@property (nonatomic, strong) NSString *PCode;

@property (nonatomic, strong) NSString *PickCode;
@property (nonatomic, strong) NSString *CollectionMoney;

+ (instancetype)orderFromDictionary:(NSDictionary *)dictionary;
@end
