//
//  ProductDetailView.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "ProductDetailView.h"
#import "UserModel.h"
#import "AFNetworking.h"

#import "BreedViewController.h"
#import "ClassifyViewController.h"

#import <AVFoundation/AVFoundation.h>
//#import <CoreImage/CoreImage.h>

#import "ScanCodeViewController.h"

@interface ProductDetailView ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
AVCaptureMetadataOutputObjectsDelegate
>
@property (nonatomic, strong) NSMutableArray *breedList;
@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSMutableArray *productIDList;

@property (nonatomic, strong) NSMutableArray *classifyList;
@property (nonatomic, strong) UIView *animateLine;

@property (nonatomic, strong) ScanCodeViewController *scanVC;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end
@implementation ProductDetailView

- (ScanCodeViewController *)scanVC {
    if (!_scanVC) {
        _scanVC = [[ScanCodeViewController alloc]init];
    }
    return _scanVC;
}

- (NSMutableArray *)breedList{
    if (!_breedList) {
        _breedList = [NSMutableArray array];
    }
    return _breedList;
}

- (NSMutableArray *)productIDList{
    if (!_productIDList) {
        _productIDList = [NSMutableArray array];
    }
    return _productIDList;
}

- (NSMutableArray *)classifyList{
    if (!_classifyList) {
        _classifyList = [NSMutableArray array];
    }
    return _classifyList;
}

//AVMediaTypeAudio 打来麦克
//AVMediaTypeVideo 打开相机
- (AVCaptureDevice *)device {
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input {
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_output setRectOfInterest:[self rectOfInterestByScanViewRect:CGRectMake(40, 150, Width - 80, Width - 80)]];
    }
    return _output;
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.scanVC.bgView.frame);
    CGFloat height = CGRectGetHeight(self.scanVC.bgView.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}


- (AVCaptureSession *)session {
    if (!_session) {
        
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
        
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {

    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        
    }
    return _previewLayer;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.baseFrame = frame;
        self.delegate = self;
        self.dataSource = self;
        
        [self netWorkingRequest];
        
        self.backgroundColor = color(241, 241, 241, 1);
        self.tableFooterView = [[UIView alloc]init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.previewLayer.frame = self.scanVC.bgView.bounds;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [self.scanVC.bgView.layer addSublayer:self.previewLayer];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, Height)];
        leftView.backgroundColor = [UIColor blackColor];
        leftView.alpha = 0.5;
        [self.scanVC.bgView addSubview:leftView];
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(Width - 40, 0, 40, Height)];
        rightView.backgroundColor = [UIColor blackColor];
        rightView.alpha = 0.5;
        [self.scanVC.bgView addSubview:rightView];
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(40, 0, Width - 80, 150)];
        topView.backgroundColor = [UIColor blackColor];
        topView.alpha = 0.5;
        [self.scanVC.bgView addSubview:topView];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(40, 150 +(Width - 80), Width - 80, Height- 150 - Width + 80)];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.5;
        [self.scanVC.bgView addSubview:bottomView];
        
        self.animateLine = [[UIView alloc]initWithFrame:CGRectMake(40, 160, Width - 80, 3)];
        [self.scanVC.bgView addSubview:self.animateLine];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animatedLine) userInfo:nil repeats:YES];
        
        
        
        UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(41, 151, 1, Width - 82)];
        UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(Width - 41, 151, 1, Width - 82)];
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(41, 151, Width - 82, 1)];
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(41, 150 +(Width - 80) - 1, Width - 82, 1 )];
        
        leftLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        rightLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        topLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        bottomLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        
        UIView *leftTopLine1 = [[UIView alloc]initWithFrame:CGRectMake(42, 152, 20, 2)];
        UIView *leftTopLine2 = [[UIView alloc]initWithFrame:CGRectMake(42, 152, 2, 20)];
        
        leftTopLine1.backgroundColor = color(53, 175, 255, 1);
        leftTopLine2.backgroundColor = color(53, 175, 255, 1);
        
        UIView *rightTopLine1 = [[UIView alloc]initWithFrame:CGRectMake(Width - 61, 152, 20, 2)];
        UIView *rightTopLine2 = [[UIView alloc]initWithFrame:CGRectMake(Width - 43, 152, 2, 20)];
        
        rightTopLine1.backgroundColor = color(53, 175, 255, 1);
        rightTopLine2.backgroundColor = color(53, 175, 255, 1);
        
        UIView *leftBottomLine1 = [[UIView alloc]initWithFrame:CGRectMake(42, 150 +(Width - 80) - 3, 20, 2)];
        UIView *leftBottomLine2 = [[UIView alloc]initWithFrame:CGRectMake(42, 150 +(Width - 80) - 21, 2, 20)];
        
        leftBottomLine1.backgroundColor = color(53, 175, 255, 1);
        leftBottomLine2.backgroundColor = color(53, 175, 255, 1);
        
        UIView *rightBottomLine1 = [[UIView alloc]initWithFrame:CGRectMake(Width - 61, 150 +(Width - 80) - 3, 20, 2)];
        UIView *rightBottomLine2 = [[UIView alloc]initWithFrame:CGRectMake(Width - 43, 150 +(Width - 80) - 21, 2, 20)];
        
        rightBottomLine1.backgroundColor = color(53, 175, 255, 1);
        rightBottomLine2.backgroundColor = color(53, 175, 255, 1);
        
        [self.scanVC.bgView addSubview:leftTopLine1];
        [self.scanVC.bgView addSubview:leftTopLine2];
        [self.scanVC.bgView addSubview:rightTopLine1];
        [self.scanVC.bgView addSubview:rightTopLine2];
        [self.scanVC.bgView addSubview:leftBottomLine1];
        [self.scanVC.bgView addSubview:leftBottomLine2];
        [self.scanVC.bgView addSubview:rightBottomLine1];
        [self.scanVC.bgView addSubview:rightBottomLine2];
        
        [self.scanVC.bgView addSubview:leftLine];
        [self.scanVC.bgView addSubview:rightLine];
        [self.scanVC.bgView addSubview:topLine];
        [self.scanVC.bgView addSubview:bottomLine];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, bottomView.bounds.size.width, 50)];
        label.text = @"将条形码放入框内，即可自动扫描";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = color(53, 175, 255, 1);
        label.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:label];
        
                
        //接受类型写在输出添加到会话之后，不然崩溃
        [self.output setMetadataObjectTypes:@[
                                              AVMetadataObjectTypeEAN13Code,
                                              AVMetadataObjectTypeEAN8Code,
                                              AVMetadataObjectTypeCode128Code,
                                              AVMetadataObjectTypeCode39Code,
                                              AVMetadataObjectTypeCode93Code
                                              ]];
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Aztec"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return self;
}

- (void)animatedLine {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.animateLine.frame = CGRectMake(40, Width + 80, Width - 80, 3);
    } completion:^(BOOL finished) {
        self.animateLine.frame = CGRectMake(40, 160, Width - 80, 3);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *labelList = @[@"商品属性",
                           @"类 别",
                           @"产品型号",
                           @"产品数量",
                           @"产品条码",
                           @"外机条码",
                           @"购买商场",
                           ];
    static NSString *identifier = @"Mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width/4, 40)];
    label.text = labelList[indexPath.row];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTintColor:[UIColor blackColor]];
        button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = indexPath.row + 200;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
       
        if (indexPath.row == 0) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"美的" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"breedList"][0][@"Name"] forState:UIControlStateNormal];
            }
            
 
        }
        
        if (indexPath.row == 1) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"电热水器" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] forState:UIControlStateNormal];
            }
        }
 
        
    }else{
        
        if (indexPath.row == 4 || indexPath.row == 5) {
            UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            textfield.delegate = self;
            textfield.layer.cornerRadius = 5;
            textfield.font = [UIFont systemFontOfSize:14];
            textfield.layer.masksToBounds = YES;
            textfield.backgroundColor = [UIColor whiteColor];
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            
            textfield.tag = 100 + indexPath.row;
            [cell addSubview:textfield];
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTintColor:[UIColor blackColor]];
            button.frame = CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            button.backgroundColor = color(59, 165, 249, 1);
            button.tag = indexPath.row + 200;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [button addTarget:self action:@selector(scanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setTitle:@"扫码" forState:UIControlStateNormal];
            
            
            
        }else{
            UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            textfield.delegate = self;
            textfield.layer.cornerRadius = 5;
            textfield.font = [UIFont systemFontOfSize:14];
            textfield.layer.masksToBounds = YES;
            textfield.backgroundColor = [UIColor whiteColor];
            if (indexPath.row == 3) {
                textfield.keyboardType = UIKeyboardTypeNumberPad;
            }
            if (indexPath.row != 6) {
                textfield.returnKeyType = UIReturnKeyNext;
            }else{
                textfield.returnKeyType = UIReturnKeyDone;
            }
            textfield.tag = 100 + indexPath.row;
            [cell addSubview:textfield];
        }
        
    }
    
    return cell;
}


- (void) netWorkingRequest {
    UserModel *userModel = [UserModel readUserModel];
    NSString *breedURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductbreed&comid=%ld",HomeUrl,(long)userModel.CompanyID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:breedURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            self.breedList = responseObject[@"list"];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.breedList forKey:@"breedList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSMutableArray *breedNameList = [NSMutableArray array];
        for (NSDictionary *dic in self.breedList) {
            [breedNameList addObject:dic[@"Name"]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:breedNameList forKey:@"breedNameList"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
            for (NSDictionary *dic in self.breedList) {
                [self.productIDList addObject:dic[@"ID"]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:self.productIDList forKey:@"productIDList"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.productID = [responseObject[@"list"][0][@"ID"] integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:self.productID forKey:@"productID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *classifyURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductclassify&comid=%ld&parent=%ld",HomeUrl,(long)userModel.CompanyID,(long)self.productID];
        
        [manager GET:classifyURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *name = responseObject[@"list"][0][@"Name"];
            NSLog(@"----%@",responseObject);
            
            
            [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSMutableArray *IDList = [NSMutableArray array];
            
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [self.classifyList addObject:dic[@"Name"]];
                    [IDList addObject:dic[@"ID"]];
                }
            
            [[NSUserDefaults standardUserDefaults] setObject:IDList forKey:@"IDList"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:IDList[0] forKey:@"classifyID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)scanButtonClicked:(UIButton *)sender {

    [[self viewController].navigationController pushViewController:self.scanVC animated:YES];
    if (sender.tag == 204) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Aztec"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"Aztec"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [self.session startRunning];
}

- (void)buttonClicked:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.tag == 200) {
        BreedViewController *breedVC = [[BreedViewController alloc]init];

        
        breedVC.breedList = [[NSUserDefaults standardUserDefaults]objectForKey:@"breedNameList"];

        breedVC.returnBreed = ^(NSString *name, NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            
            UserModel *userModel = [UserModel readUserModel];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSInteger ID = [self.productIDList[row] integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:ID forKey:@"productID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *classifyURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getproductclassify&comid=%ld&parent=%ld",HomeUrl,(long)userModel.CompanyID,(long)ID];
            NSLog(@"%@",classifyURLString);
            
            [manager GET:classifyURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [list addObject:dic[@"Name"]];
                }
                
                NSMutableArray *IDList = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [IDList addObject:dic[@"ID"]];
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:IDList forKey:@"IDList"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self.classifyList removeAllObjects];
                self.classifyList  = list;
                
                UIButton *btn = [self viewWithTag:201];
                [btn setTitle:list[0] forState:UIControlStateNormal];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];

        };
        
        [[self viewController] presentViewController:breedVC animated:YES completion:nil];

    }else {
        
        ClassifyViewController *classifyVC = [[ClassifyViewController alloc]init];
        classifyVC.classifyList = self.classifyList;
        classifyVC.returnClassify = ^(NSString *name , NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            NSMutableArray *cliassifyIDList = [[NSUserDefaults standardUserDefaults]objectForKey:@"IDList"];
 
            [[NSUserDefaults standardUserDefaults] setInteger:[cliassifyIDList[row] integerValue] forKey:@"classifyID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
        };
        
        [[self viewController] presentViewController:classifyVC animated:YES completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (iPhone4_4s) {
        if (textField.tag == 102) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 10;
                
                self.frame = frame;
            }];
        }
        if (textField.tag == 103) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 10;
                
                self.frame = frame;
            }];
        }
        if (textField.tag == 104) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 50;
                
                self.frame = frame;
            }];
        }
        if (textField.tag == 105) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 80;
                
                self.frame = frame;
            }];
        }
        
        if (textField.tag == 106) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 150;
                
                self.frame = frame;
            }];
        }
    } else {
        
        if (textField.tag == 105) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 50;
                
                self.frame = frame;
            }];
        }
        if (textField.tag == 106) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - 125;
                
                self.frame = frame;
            }];
        }
 
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 102) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.baseFrame;
        }];
    }
    if (textField.tag == 103) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.baseFrame;
        }];
    }
    if (textField.tag == 104) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.baseFrame;
        }];
    }
    if (textField.tag == 105) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.baseFrame;
        }];
    }
    if (textField.tag == 106) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = self.baseFrame;
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 106) {
        [self endEditing:YES];
    }else{
        UITextField *lastTextField = (UITextField *)[self viewWithTag:textField.tag];
        [lastTextField resignFirstResponder];
        
        UITextField *nextTextField = (UITextField *)[self viewWithTag:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    }
    
    return YES;
}

#pragma mark - AVCaptureMetaDataOutputObjectsDelegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [self.session stopRunning];
//    [self.previewLayer removeFromSuperlayer];
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Aztec"] == 1) {
            UITextField *textfield = [self viewWithTag:104];
            textfield.text = obj.stringValue;
        }else {
            UITextField *textfield = [self viewWithTag:105];
            textfield.text = obj.stringValue;
        }
        
        NSLog(@"---%@",obj.stringValue);
        
    }
    
    [[self viewController].navigationController popViewControllerAnimated:YES];
    
    
}





- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
