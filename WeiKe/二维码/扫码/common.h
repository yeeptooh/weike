//
//  common.h
//  美智高-T
//
//  Created by xl on 15/3/18.
//  Copyright (c) 2015年 xl. All rights reserved.
//

#ifndef ____T_common_h
#define ____T_common_h
#define margin  10
#define Width  [[UIScreen mainScreen]bounds].size.width
#define Height  [[UIScreen mainScreen]bounds].size.height
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define rectNav  self.navigationController.navigationBar.frame
#define rectStatus  [[UIApplication sharedApplication] statusBarFrame]
//#import "labelWithOutput.h"
//#import "lebelWithDropList.h"
//#import "inputTextFieldView.h"
//#import "nameWithOutLabel.h"
//#import "BtnWIthDropList.h"
//#import "labelWithInput.h"
//#import "labelWithBgImage.h"
//#import "LineWithTitle.h"
//#import "exchScore.h"
//#import "scanforInCell.h"
#import "AFNetworking.h"
//#import "Account.h"
//#import "AccountTool.h"
//#import "titleView.h"
//#import "OrderCell.h"
//#import "equalWidth_header.h"
//#import "UIImageView+WebCache.h"


#define HOST @"http://api.xologood-fc.com/meizhigao/action.aspx"

#define kPicScrollUrlString @"http://apis.36kr.com/api/v1/topics/feature.json?token=734dca654f1689f727cc:32710&platform=android&version=1.0.5"
#define MZGNotificationCenter [NSNotificationCenter defaultCenter]
//#import "SVProgressHUD.h"

#endif
