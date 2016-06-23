//
//  DistricsViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnDistrics)(NSString *districs, NSInteger row);
@interface DistricsViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *discList;
@property (nonatomic, copy) ReturnDistrics returnDisc;

@end
