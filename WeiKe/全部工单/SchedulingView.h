//
//  SchedulingView.h
//  WeiKe
//
//  Created by 张冬冬 on 16/4/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchedulingView : UIView
@property (nonatomic, strong) NSString *proID;
@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *leaveCount;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UITextField *priceTextfield;
@property (nonatomic, strong) UILabel *count;

@property (nonatomic, strong) UILabel *saleCount;
@property (nonatomic, strong) UITextField *saleTextfield;

@property (nonatomic, strong) UILabel *ps;
@property (nonatomic, strong) UITextField *psTextfield;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *quitButton;


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *CountName;
@property (nonatomic, strong) NSString *saleCountName;

@property (nonatomic, strong) UILabel *buyMarkLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UILabel *buyLabel;


@end
