//
//  BuyShopViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/13.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnNewTitle)(NSString *title);
@interface BuyShopViewController : UIViewController
@property (nonatomic, copy) ReturnNewTitle returnTitle;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, assign) NSInteger ID;
@end
