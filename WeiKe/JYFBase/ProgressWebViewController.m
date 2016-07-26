//
//  ProgressWebViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/7/26.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "ProgressWebViewController.h"
#import <WebKit/WebKit.h>
@interface ProgressWebViewController ()
<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation ProgressWebViewController

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - StatusBarAndNavigationBarHeight)];
        _webView.navigationDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;

        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = BlueColor;
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    if (!self.webView.loading) {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
//            [self.progressView removeFromSuperview];
        }];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.progressView.alpha = 0;
        //            [self.progressView removeFromSuperview];
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.progressView.alpha = 0;
        //            [self.progressView removeFromSuperview];
    }];
}


- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
