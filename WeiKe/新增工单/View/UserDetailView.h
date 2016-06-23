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
@end
