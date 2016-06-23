//
//  ChangeNameViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/13.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnNewName)(NSString *name);
@interface ChangeNameViewController : UIViewController
@property (nonatomic, copy) ReturnNewName returnName;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, assign) NSInteger ID;
@end
