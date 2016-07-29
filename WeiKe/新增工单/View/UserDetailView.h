//
//  UserDetailView.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailView : UITableView
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>

@property (nonatomic, assign) CGRect baseFrame;

@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *discID;
@property (nonatomic, strong) NSString *townID;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@end
