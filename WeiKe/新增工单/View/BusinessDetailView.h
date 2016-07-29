//
//  BusinessDetailView.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessDetailView : UITableView
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, assign) CGRect baseFrame;
@property (nonatomic, strong) NSString *serviceID;
@property (nonatomic, strong) NSString *serivcePro;
@property (nonatomic, strong) NSString *date;
@end
