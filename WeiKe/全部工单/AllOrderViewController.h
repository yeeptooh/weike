//
//  AllOrderViewController.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void (^ReturnID)(NSString *ID);
@interface AllOrderViewController :BaseViewController
@property (nonatomic, strong) ReturnID returnID;
@end
