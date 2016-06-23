//
//  SaleViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/4/22.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface SaleViewController : BaseViewController
@property (nonatomic, assign) NSInteger taskID;
@property (nonatomic, assign) NSInteger flag1;
@property (nonatomic, assign) NSInteger flag2;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) NSMutableArray *storeNameList;




@end
