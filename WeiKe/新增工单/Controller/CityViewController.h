//
//  CityViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnCity)(NSString *cityName, NSInteger row);
@interface CityViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *cityList;
@property (nonatomic, copy) ReturnCity returnCity;
@end
