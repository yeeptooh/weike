//
//  BreedViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnBreed)(NSString *breedName, NSInteger row);
@interface BreedViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *breedList;
@property (nonatomic, copy) ReturnBreed returnBreed;
@end
