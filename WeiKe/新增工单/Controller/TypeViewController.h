//
//  TypeViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnType)(NSInteger row);
@interface TypeViewController : UIViewController
@property (nonatomic, copy) ReturnType returnType;
@end
