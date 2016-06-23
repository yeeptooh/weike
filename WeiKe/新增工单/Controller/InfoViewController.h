//
//  InfoViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnInfo)(NSString *info, NSInteger row);
@interface InfoViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *infoList;
@property (nonatomic, copy) ReturnInfo returnInfo;
@end
