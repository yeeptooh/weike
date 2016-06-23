//
//  MyProgressView.h
//  天润
//
//  Created by t on 15/6/5.
//  Copyright (c) 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProgressView : UIView
@property(nonatomic,retain)UIView *view;
@property(nonatomic,retain)UIActivityIndicatorView *quan;
+(void)showWith:(NSString *)str;
+(void)dissmiss;
+(void)dissmissWithError:(NSString *)str;








@end
