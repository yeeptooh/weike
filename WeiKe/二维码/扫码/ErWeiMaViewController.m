//
//  ErWeiMaViewController.m
//  天润
//
//  Created by Ji_YuFeng on 15/4/25.
//  Copyright (c) 2015年 Ji_YuFeng. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import "ErWeiMaTZViewController.h"
#import "MyProgressView.h"

@interface ErWeiMaViewController () {
    CGFloat _lineOriginY;
    CGFloat _totalOffsetY;
}
@end

@implementation ErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor ];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.title = @"扫一扫";
    
    
    self.view.backgroundColor = [UIColor blackColor];
    //    self.view.alpha = 0.7;
    //    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    //    scanButton.frame = CGRectMake(100, 420, 120, 40);
    //    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:scanButton];
    
    //    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 290, 50)];
    //    labIntroudction.backgroundColor = [UIColor clearColor];
    //    labIntroudction.numberOfLines=2;
    //    labIntroudction.textColor=[UIColor whiteColor];
    //    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    //    [self.view addSubview:labIntroudction];
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    float width = size.width / (400.0 / 230.0) + 10;
    float height = width;
    float x = (size.width - width) / 2.0;
    float y = size.width / (400.0 / 148.0) - 5;
    
    
    _totalOffsetY = height - 10;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    
    width = width * 0.7;
    x = (size.width - width) / 2.0;
    _lineOriginY = y + 5;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    width = imageView.frame.size.width - 20;
    x = (size.width - width) / 2.0;
    y = CGRectGetMaxY(imageView.frame) + 10;
    height = 60;
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines = 2;
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"请对准以便进行扫描";
    [self.view addSubview:labIntroudction];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(_line.frame.origin.x, _lineOriginY+2*num, _line.frame.size.width, 2);
        if (2*num == _totalOffsetY) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(_line.frame.origin.x, _lineOriginY+2*num, _line.frame.size.width, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    UIView*imageView=[self.navigationController.view viewWithTag:10000];
    imageView.hidden=YES;
    
    [self setupCamera];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    float width = size.width / (400.0 / 230.0);
    float height = width;
    float x = (size.width - width) / 2.0;
    float y = size.width / (400.0 / 148.0);
    
    
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(x,y,width,height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    [timer invalidate];
    //
    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"xx" message:stringValue delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    //
    //    [alertView show];
    
//    [ [ UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saoma" object:nil userInfo:@{@"thetag":[NSNumber numberWithInt:_theTag],@"String":stringValue}];
    [MyProgressView dissmiss];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"guangyou = %@",stringValue);
    
    
    //    ErWeiMaTZViewController *tz = [[ErWeiMaTZViewController alloc]init];
    //    tz.thenetString = stringValue;
    //    [self.navigationController pushViewController:tz animated:YES];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
