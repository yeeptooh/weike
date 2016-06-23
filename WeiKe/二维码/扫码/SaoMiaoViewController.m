//
//  SaoMiaoViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 16/1/6.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "SaoMiaoViewController.h"
#import "WECodeScannerView.h"

@interface SaoMiaoViewController ()
<
WECodeScannerViewDelegate
>
{
    UIView *viewPreview;
    UIButton *done;
    NSString *stringValue;
}

@property (nonatomic, strong) WECodeScannerView *codeScannerView;
@property (nonatomic, strong) UILabel *codeLabel;

@end

@implementation SaoMiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    CGFloat labelHeight = 60.0f;
    
    self.codeScannerView = [[WECodeScannerView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.codeScannerView.frame.size.height, self.view.bounds.size.width - 10, labelHeight)];
    
    self.codeLabel.backgroundColor = [UIColor clearColor];
    self.codeLabel.textColor = [UIColor blackColor];
    self.codeLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.codeLabel.numberOfLines = 2;
    self.codeLabel.textAlignment = NSTextAlignmentCenter;
    self.codeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    self.codeScannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.codeScannerView.delegate = self;
    [self.view addSubview:self.codeScannerView];
    [self.view addSubview:self.codeLabel];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.codeScannerView stop];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.codeScannerView start];
}

//导航栏
-(void)setNavigationBar
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, Width, 44)];
    headView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:headView];
    
    UIButton *ToCompleteBackButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 14, 80, 30)];
    [ToCompleteBackButton setTitle:@" <返回" forState:0];
    ToCompleteBackButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [ToCompleteBackButton setTitleColor:[UIColor whiteColor] forState:0];
    [ToCompleteBackButton addTarget:self action:@selector(ToCompleteBackButtonAction) forControlEvents:UIControlEventTouchUpInside];
    ToCompleteBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [headView addSubview:ToCompleteBackButton];
    
    
    
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width/2-50, 2, 100, 40)];
    TitleLabel.text = @"扫描";
    TitleLabel.textAlignment = 1;
    TitleLabel.textColor = [UIColor whiteColor];
    [headView addSubview:TitleLabel];
    
}

- (void)ToCompleteBackButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - WECodeScannerViewDelegate

- (void)scannerView:(WECodeScannerView *)scannerView didReadCode:(NSString*)code {
    NSLog(@"Scanned code: %@", code);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saoma" object:nil userInfo:@{@"thetag":[NSNumber numberWithInteger:_theTag],@"String":code}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scannerViewDidStartScanning:(WECodeScannerView *)scannerView {
}

- (void)scannerViewDidStopScanning:(WECodeScannerView *)scannerView {
    
}





@end
