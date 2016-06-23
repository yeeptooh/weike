//
//  ClassifyViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnClassify)(NSString *classifyName, NSInteger row);
@interface ClassifyViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *classifyList;
@property (nonatomic, copy) ReturnClassify returnClassify;
@end
