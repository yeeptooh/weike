//
//  SchedulingViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/4/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnStep)(NSString *StepName, NSInteger row);
@interface SchedulingViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *stepList;
@property (nonatomic, copy) ReturnStep returnStep;
@property (nonatomic, assign) NSInteger ID;
@end
