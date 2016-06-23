//
//  ServiceViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnService)(NSString *serviceName, NSInteger row);
@interface ServiceViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *serviceList;
@property (nonatomic, copy) ReturnService returnService;
@end
