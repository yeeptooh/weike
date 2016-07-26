//
//  ProgressWebViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/7/26.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
@interface ProgressWebViewController : BaseViewController
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *url;
@end
