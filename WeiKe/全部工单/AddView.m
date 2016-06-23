//
//  AddView.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/22.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "AddView.h"

@implementation AddView
/*
 
 @property (nonatomic, strong) UILabel *nameLabel;
 @property (nonatomic, strong) UILabel *priceLabel;
 
 @property (nonatomic, strong) UILabel *priceTextfield;
 @property (nonatomic, strong) UILabel *count;
 
 @property (nonatomic, strong) UILabel *saleCount;
 @property (nonatomic, strong) UILabel *saleTextfield;
 @property (nonatomic, strong) UILabel *ps;
 
 @property (nonatomic, strong) UIButton *addButton;
 
 
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, strong) NSString *price;
 @property (nonatomic, strong) NSString *CountName;
 @property (nonatomic, strong) NSString *saleCountName;
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, Height)];
    if (self) {
        
        CGFloat fontSize;
        if (iPhone6_plus || iPhone6) {
            fontSize = 16;
        }else{
            fontSize = 14;
        }
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.containerView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, Width - 60, Width - 60)];
        self.containerView.backgroundColor = color(241, 241, 241, 1);
        [self addSubview:self.containerView];
        self.containerView.alpha = 0;
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.containerView.bounds.size.width, (Width - 60)/6-10)];
        self.nameLabel.font = [UIFont systemFontOfSize:fontSize];
//        self.nameLabel.text = self.name;
        [self.containerView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (Width - 60)/6+5, self.containerView.bounds.size.width/4, (Width - 60)/6 - 10)];
        self.priceLabel.text = @" 销售价格";
        self.priceLabel.font = [UIFont systemFontOfSize:fontSize];
        [self.containerView addSubview:self.priceLabel];
//        self.priceLabel.textAlignment = NSTextAlignmentRight;
        
        
        self.priceTextfield = [[UITextField alloc]initWithFrame:CGRectMake(self.containerView.bounds.size.width*5/16, (Width - 60)/6+5, self.containerView.bounds.size.width*10/16, (Width - 60)/6 - 10)];
        self.priceTextfield.font = [UIFont systemFontOfSize:fontSize];
        self.priceTextfield.backgroundColor = [UIColor whiteColor];
        self.priceTextfield.layer.cornerRadius = 5;
        self.priceTextfield.layer.masksToBounds = YES;
        self.priceTextfield.textAlignment  = NSTextAlignmentCenter;
        self.priceTextfield.textColor = [UIColor redColor];
        

        
        [self.containerView addSubview:self.priceTextfield];
        
        
        self.count = [[UILabel alloc]initWithFrame:CGRectMake(0, (Width - 60)*2/6+5, self.containerView.bounds.size.width, (Width - 60)/6 - 10)];
//        self.count.text = self.CountName;
        self.count.font = [UIFont systemFontOfSize:fontSize];
        self.count.textAlignment = NSTextAlignmentLeft;
        
        [self.containerView addSubview:self.count];
        
        self.saleCount = [[UILabel alloc]initWithFrame:CGRectMake(0, (Width - 60)*3/6+5, self.containerView.bounds.size.width/4, (Width - 60)/6 - 10)];
        self.saleCount.text = @" 销售数量";
        self.saleCount.font = [UIFont systemFontOfSize:fontSize];
//        self.saleCount.textAlignment = NSTextAlignmentRight;
        [self.containerView addSubview:self.saleCount];
        
        
        self.saleTextfield = [[UITextField alloc]initWithFrame:CGRectMake(self.containerView.bounds.size.width*5/16, (Width - 60)*3/6+5, self.containerView.bounds.size.width*10/16, (Width - 60)/6 - 10)];
        self.saleTextfield.font = [UIFont systemFontOfSize:fontSize];
        self.saleTextfield.backgroundColor = [UIColor whiteColor];
        self.saleTextfield.layer.cornerRadius = 5;
        self.saleTextfield.layer.masksToBounds = YES;
        self.saleTextfield.text = @"1";
        self.saleTextfield.textColor = [UIColor redColor];
        self.saleTextfield.textAlignment  = NSTextAlignmentCenter;
        [self.containerView addSubview:self.saleTextfield];
        
        
        
        self.psTextfield = [[UITextField alloc]initWithFrame:CGRectMake(self.containerView.bounds.size.width/16, (Width - 60)*4/6+5, self.containerView.bounds.size.width*14/16, (Width - 60)/6-10)];
        self.psTextfield.backgroundColor = [UIColor whiteColor];
        self.psTextfield.layer.cornerRadius = 5;
        self.psTextfield.layer.masksToBounds = YES;
        self.psTextfield.placeholder = @"备注";
        
        [self.containerView addSubview:self.psTextfield];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(0, (Width - 60)*5/6, self.containerView.bounds.size.width/2 - 0.5, (Width - 60)/6);
        self.addButton.backgroundColor = color(23, 133, 255, 1);
        [self.addButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.containerView addSubview:self.addButton];
        
        self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.quitButton.frame = CGRectMake(self.containerView.bounds.size.width/2 +0.5, (Width - 60)*5/6, self.containerView.bounds.size.width/2 - 0.5, (Width - 60)/6);
        self.quitButton.backgroundColor = color(23, 133, 255, 1);
        [self.quitButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.containerView addSubview:self.quitButton];
        
    }
    return self;
}

@end
