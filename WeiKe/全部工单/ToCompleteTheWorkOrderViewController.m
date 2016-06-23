//
//  ToCompleteTheWorkOrderViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/1.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "ToCompleteTheWorkOrderViewController.h"
#import "AFNetClass.h"
#import "MyProgressView.h"
#import "UserModel.h"
#import "AFNetworking.h"
#import "ScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "CPViewController.h"

#import "LGPhoto.h"
#import "MBProgressHUD.h"
#import "DatePickerViewController.h"
#import "RefuseViewController.h"

#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]

extern const CFStringRef kUTTypeImage                                __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_3_0);


@interface ToCompleteTheWorkOrderViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
AVCaptureMetadataOutputObjectsDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

{
    UIButton *button1;
    UIButton *button2;
    UIButton *dateButton;
    NSString *bill;

}

@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSData *image_data;

@property (nonatomic, strong) ScanCodeViewController *scanVC;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UITextField *textfield1;
@property (nonatomic, strong) UITextField *textfield2;

@property (nonatomic, strong) NSMutableArray *List;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *blackView;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;

@property (nonatomic, assign) NSInteger selectedBtnposition;

@property (nonatomic, strong) NSData *imageData1;
@property (nonatomic, strong) NSData *imageData2;
@property (nonatomic, strong) NSData *imageData3;



@property (nonatomic, strong) NSMutableArray *stepList;
@property (nonatomic, strong) NSString *cpString;

@property (nonatomic, strong) UIButton *button;

@end

@implementation ToCompleteTheWorkOrderViewController

- (NSMutableArray *)stepList {
    if (!_stepList) {
        _stepList = [NSMutableArray array];
    }
    return _stepList;
}
- (NSMutableArray *)List {
    if (!_List) {
        _List = [NSMutableArray array];
    }
    return _List;
}

- (UITextField *)textfield1 {
    if (!_textfield1) {
        _textfield1 = [[UITextField alloc]init];
    }
    return _textfield1;
}

- (UITextField *)textfield2 {
    if (!_textfield2) {
        _textfield2 = [[UITextField alloc]init];
    }
    return _textfield2;
}

- (ScanCodeViewController *)scanVC {
    if (!_scanVC) {
        _scanVC = [[ScanCodeViewController alloc]init];
    }
    return _scanVC;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    picCount = 0;
    self.view.backgroundColor = color(241, 241, 241, 1);
    // Do any additional setup after loading the view.
    
    if (self.theway == 0) {
        
        self.List = [NSMutableArray arrayWithObjects:@"完成时间",@"产品条码",@"外机条码",@"发票号",@"安装维修",@"配件材料",@"其他费用",@"备注内容",@"完工措施",@"现场拍照",@"", nil];
    }else if(self.theway == 2){
        self.List = [NSMutableArray arrayWithObjects:@"完成时间",@"产品条码",@"外机条码",@"发票号",@"单号1",@"单号2",@"单号3",@"单号4",@"安装维修",@"配件材料",@"其他费用",@"备注内容",@"完工措施",@"现场拍照",@"", nil];

    }else{
        self.List = [NSMutableArray arrayWithObjects:@"完成时间",@"产品条码",@"外机条码",@"发票号",@"故障原因",@"配件更换",@"安装维修",@"配件材料",@"其他费用",@"备注内容",@"完工措施",@"现场拍照",@"", nil];
    }
    

    _WorkPostscript = @"";
    [self setToCompleteTableView];
    [self setNavigationBar];
    [self keyboardAddNotification];
    
    
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
    
    
//    接受类型写在输出添加到会话之后，不然崩溃
    [self.output setMetadataObjectTypes:@[
                                          AVMetadataObjectTypeEAN13Code,
                                          AVMetadataObjectTypeEAN8Code,
                                          AVMetadataObjectTypeCode128Code,
                                          AVMetadataObjectTypeCode39Code,
                                          AVMetadataObjectTypeCode93Code
                                          ]];

}

- (void)viewDidDisappear:(BOOL)animated {
    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data1.data"];
    NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data2.data"];
    NSString *path3 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data3.data"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:path1 error:nil];
    [manager removeItemAtPath:path2 error:nil];
    [manager removeItemAtPath:path3 error:nil];
    
}

#pragma mark - 监听键盘 -
- (void)keyboardAddNotification {
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - 键盘 -
- (void)keyboardWasShown:(NSNotification*)aNotification{

    //添加手势
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.tap];

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [self.view removeGestureRecognizer:self.tap];
}

#pragma mark - 单击手势 -
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}


//导航栏
-(void)setNavigationBar {    
    self.navigationItem.title = @"完成工单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIButton  *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 60, 40);
    [backButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [backButton setTitleColor:color(170, 170, 170, 1) forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_light"] forState:UIControlStateNormal];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    
    UIBarButtonItem  *backItem =[[UIBarButtonItem alloc]initWithCustomView: backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backLastView:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setToCompleteTableView {
    
    self.view.backgroundColor = color(241, 241, 241, 1);
    
//    CGFloat height;
//    if (iPhone6_plus || iPhone6) {
//        height = 80;
//    }else{
//        height = 50;
//    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = color(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.theway == 0) {
        return 11;
    }else if (self.theway == 1){
        return 13;
    }

        return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    UILabel *dataLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, Width/4, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
    dataLab.text = [self.List objectAtIndex:indexPath.row];
    CGFloat fontSize;
    if (iPhone6_plus || iPhone6) {
        fontSize = 17;
    }else{
        fontSize = 14;
    }
    dataLab.font = [UIFont systemFontOfSize:fontSize];
    dataLab.textAlignment = NSTextAlignmentRight;
    [cell addSubview:dataLab];
    
    
    UITextField *textfield = [[UITextField alloc]init];
    textfield.delegate = self;
    
    CGFloat size;
    if (iPhone6_plus || iPhone6) {
        size = 16;
    }else{
        size = 14;
    }
    textfield.font = font(size);
//    textfield.tag = 350+indexPath.row;
    if (indexPath.row == 0) {
        if (iPhone6_plus || iPhone6) {
            fontSize = 16;
        }else{
            fontSize = 14;
        }
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];

        
        
        dateButton = [[UIButton alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        dateButton.layer.masksToBounds = YES;
        dateButton.layer.cornerRadius = 5;
        dateButton.backgroundColor = [UIColor whiteColor];
        dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dateButton.titleLabel.font = font(fontSize);
        [dateButton setTitleColor:[UIColor blackColor] forState:0];
        
        
        if (!_FinishTime) {
            [dateButton setTitle:[NSString stringWithFormat:@"%@", dateString] forState:0];
            _FinishTime = dateString;
        }else{
            [dateButton setTitle:[NSString stringWithFormat:@"%@", _FinishTime] forState:0];
        }
        
        [dateButton addTarget:self action:@selector(dateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:dateButton];
        
    }
   
    
    if (indexPath.row>0 && indexPath.row<=2){
        
        if (iPhone6_plus || iPhone6) {
            fontSize = 16;
        }else{
            fontSize = 14;
        }
        
        if (indexPath.row == 1) {
            self.textfield1.frame = CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            self.textfield1.layer.cornerRadius = 5;//设置那个圆角的有多圆
            self.textfield1.layer.masksToBounds = YES;
            self.textfield1.delegate = self;
            self.textfield1.font = font(fontSize);
            self.textfield1.tag = 3001;
            self.textfield1.backgroundColor = [UIColor whiteColor];
            [cell addSubview:self.textfield1];
            
        }else{
            self.textfield2.frame = CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            self.textfield2.layer.cornerRadius = 5;//设置那个圆角的有多圆
            self.textfield2.layer.masksToBounds = YES;
            self.textfield2.font = font(fontSize);
            self.textfield2.delegate = self;
            self.textfield2.tag = 3002;
            self.textfield2.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview:self.textfield2];
        }
        

        UIButton *sweepTheYardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sweepTheYardBtn.frame = CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        sweepTheYardBtn.layer.cornerRadius = 5;
        sweepTheYardBtn.layer.masksToBounds = YES;
        CGFloat fontSize;
        if (iPhone6_plus || iPhone6) {
            fontSize = 16;
        }else{
            fontSize = 14;
        }
        [sweepTheYardBtn setTitle:@"扫码" forState:UIControlStateNormal];
        [sweepTheYardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sweepTheYardBtn.backgroundColor = color(57, 195, 228, 1);
        sweepTheYardBtn.tag = 3300+indexPath.row;
        sweepTheYardBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [sweepTheYardBtn addTarget:self action:@selector(sweepTheYardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [sweepTheYardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [sweepTheYardBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [cell addSubview:sweepTheYardBtn];
        
        NSArray *array = @[_BarCode,_BarCode2];
        
        self.textfield1.text = array[0];
        self.textfield2.text = array[1];
        
    }
    
    if (self.theway == 0) {
        if(indexPath.row>2 && indexPath.row<=6){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            textfield.tag = 3000+indexPath.row;
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            
            if (indexPath.row==3) {
                moneyLab.text=@"";
               
            }else{
                moneyLab.text=@"元";
            }
            CGFloat fontSize;
            if (iPhone6_plus || iPhone6) {
                fontSize = 17;
            }else{
                fontSize = 14;
            }
            moneyLab.font = [UIFont systemFontOfSize:fontSize];
            if (!_InvoiceCode) {
                _InvoiceCode = @"";
            }
            
            if (indexPath.row == 3) {
                textfield.text = _InvoiceCode;
            }else{
                NSArray *priceArray = @[_PriceService,_PriceMaterials,_PriceAppend];
                NSString *completeTextString = priceArray[indexPath.row - 4];
                if ([completeTextString  isEqual: @0]) {
                    completeTextString = @"";
                }
                textfield.text = [NSString stringWithFormat:@"%@", completeTextString];

            }
            
            
            
            
            [cell addSubview:moneyLab];
            [cell addSubview:textfield];

        }
        
        if (indexPath.row == 7){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.tag = 3000+indexPath.row;
            textfield.text = _WorkPostscript;
            [cell addSubview:textfield];
            
        }
        
        
        if (indexPath.row == 8) {
            self.button = [UIButton buttonWithType:0];
            
            self.button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            self.button.backgroundColor = [UIColor whiteColor];
            self.button.layer.cornerRadius = 5;
            self.button.layer.masksToBounds = YES;
            if (!self.cpString) {
                self.cpString = @"";
            }
            [self.button setTitle:self.cpString forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(completeOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.button];
        }
        
        if (indexPath.row == 9){
            
            UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            firstView.backgroundColor = color(230, 230, 230, 1);
            
            UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            secondView.backgroundColor = color(230, 230, 230, 1);
            UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            thirdView.backgroundColor = color(230, 230, 230, 1);
            
            [cell addSubview:firstView];
            [cell addSubview:secondView];
            [cell addSubview:thirdView];
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(20 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(25, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(65 + (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 15 - (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            
            [cell addSubview:self.firstImageView];
            [cell addSubview:self.secondImageView];
            [cell addSubview:self.thirdImageView];
            
            UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            firstButton.backgroundColor = [UIColor clearColor];
            firstButton.frame = CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:firstButton];
            firstButton.tag = 4001;
            [firstButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secondButton.backgroundColor = [UIColor clearColor];
            secondButton.frame = CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:secondButton];
            secondButton.tag = 4002;
            [secondButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
            thirdButton.backgroundColor = [UIColor clearColor];
            thirdButton.frame = CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:thirdButton];
            thirdButton.tag = 4003;
            [thirdButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        if (indexPath.row == 10){
            UIButton *FinishButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 5, Width - 100, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            FinishButton.backgroundColor = color(59, 165, 249, 1);
            [FinishButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
            [FinishButton setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
            [FinishButton setTintColor:[UIColor whiteColor]];
            [FinishButton setTitle:@"提交" forState:0];
            FinishButton.layer.cornerRadius = 5;
            [FinishButton addTarget:self action:@selector(FinishButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:FinishButton];
        }
    }else if(self.theway == 2){
    
        if(indexPath.row>2 && indexPath.row<=7){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            if (!_InvoiceCode) {
                _InvoiceCode = @"";
            }
            NSArray *array3 = @[_InvoiceCode,_DCode,_CheckCode,_PCode,_PickCode];
            textfield.text = [NSString stringWithFormat:@"%@", array3[indexPath.row-3]];
            textfield.tag = 3000+indexPath.row;
            [cell addSubview:textfield];
        }
        
        if (indexPath.row>7 && indexPath.row<=10) {
            textfield.frame = CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            textfield.tag = 3000+indexPath.row;
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            moneyLab.text = @"元";
            CGFloat fontSize;
            if (iPhone6_plus || iPhone6) {
                fontSize = 18;
            }else{
                fontSize=15;
            }
            moneyLab.font = [UIFont systemFontOfSize:fontSize];
            [cell addSubview:moneyLab];

            NSArray *priceArray = @[_PriceService,_PriceMaterials,_PriceAppend];
            NSString *completeTextString = priceArray[indexPath.row - 8];
            if ([completeTextString  isEqual: @0]) {
                completeTextString = @"";
            }
            textfield.text = [NSString stringWithFormat:@"%@", completeTextString];
            [cell addSubview:textfield];

        }
        
        if (indexPath.row == 11){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
//            completeText.text = [NSString stringWithFormat:@" %@", _WorkPostscript];
            textfield.tag = 3000+indexPath.row;
            textfield.text = _WorkPostscript;
            [cell addSubview:textfield];
        }
        
        
        if (indexPath.row == 12) {
            
            self.button = [UIButton buttonWithType:0];
            
            self.button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            self.button.backgroundColor = [UIColor whiteColor];
            self.button.layer.cornerRadius = 5;
            self.button.layer.masksToBounds = YES;
            if (!self.cpString) {
                self.cpString = @"";
            }
            [self.button setTitle:self.cpString forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(completeOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.button];
        }
        
        
        if (indexPath.row == 13){
            UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            firstView.backgroundColor = color(230, 230, 230, 1);
            
            UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            secondView.backgroundColor = color(230, 230, 230, 1);
            UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            thirdView.backgroundColor = color(230, 230, 230, 1);
            
            [cell addSubview:firstView];
            [cell addSubview:secondView];
            [cell addSubview:thirdView];
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(20 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(25, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(65 + (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 15 - (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            
            [cell addSubview:self.firstImageView];
            [cell addSubview:self.secondImageView];
            [cell addSubview:self.thirdImageView];
            
            NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data1.data"];
            NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data2.data"];
            NSString *path3 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data3.data"];
            
            
            NSData *data1 = [NSData dataWithContentsOfFile:path1];
            
            
            self.firstImageView.image = [UIImage imageWithData:data1];
            
            NSData *data2 = [NSData dataWithContentsOfFile:path2];
            
            
            self.secondImageView.image = [UIImage imageWithData:data2];

            
            NSData *data3 = [NSData dataWithContentsOfFile:path3];
            
            
            self.thirdImageView.image = [UIImage imageWithData:data3];

            
            
            
            UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            firstButton.backgroundColor = [UIColor clearColor];
            firstButton.frame = CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:firstButton];
            firstButton.tag = 4001;
            [firstButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secondButton.backgroundColor = [UIColor clearColor];
            secondButton.frame = CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:secondButton];
            secondButton.tag = 4002;
            [secondButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
            thirdButton.backgroundColor = [UIColor clearColor];
            thirdButton.frame = CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:thirdButton];
            thirdButton.tag = 4003;
            [thirdButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (indexPath.row == 14){
            UIButton *FinishButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 5, Width - 100, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            FinishButton.backgroundColor = color(59, 165, 249, 1);
            [FinishButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
            [FinishButton setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
            [FinishButton setTintColor:[UIColor whiteColor]];
            [FinishButton setTitle:@"提交" forState:0];
            FinishButton.layer.cornerRadius = 5;
            [FinishButton addTarget:self action:@selector(FinishButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:FinishButton];
        }
    }else if (_theway == 1) {
        
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            textfield.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.tag = 3000+indexPath.row;
            /*
             toCompleteVC.BrokenReason = self.orderModel.BrokenReason;//故障原因dataSource[@"BrokenReason"];
             toCompleteVC.Change = self.orderModel.Change;//配件更换
             */
            if (!_InvoiceCode) {
                _InvoiceCode = @"";
            }
            
            if (_BrokenReason) {
                _BrokenReason = @"";
            }
            if (!_Change) {
                _Change = @"";
            }
            NSArray *array = @[_InvoiceCode,_BrokenReason,_Change];
            textfield.text = array[indexPath.row - 3];
            
            [cell addSubview:textfield];
        }
        
        
        if(indexPath.row>5 && indexPath.row<=8){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*7/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            textfield.tag = 3000+indexPath.row;
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(Width *13/16, 5, Width*2/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            
            if (indexPath.row==3) {
                moneyLab.text=@"";
                
            }else{
                moneyLab.text=@"元";
            }
            CGFloat fontSize;
            if (iPhone6_plus || iPhone6) {
                fontSize = 17;
            }else{
                fontSize = 14;
            }
            moneyLab.font = [UIFont systemFontOfSize:fontSize];
            
            
            NSArray *priceArray = @[_PriceService,_PriceMaterials,_PriceAppend];
            NSString *completeTextString = priceArray[indexPath.row - 6];
            if ([completeTextString  isEqual: @0]) {
                completeTextString = @"";
            }
            textfield.text = [NSString stringWithFormat:@"%@", completeTextString];
            
            
            
            [cell addSubview:moneyLab];
            [cell addSubview:textfield];
            
        }
        
        if (indexPath.row == 9){
            textfield.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            textfield.text = _WorkPostscript;
            textfield.tag = 3000+indexPath.row;
            [cell addSubview:textfield];
            
        }
        
        if (indexPath.row == 10) {
            self.button = [UIButton buttonWithType:0];
            
            self.button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
            self.button.backgroundColor = [UIColor whiteColor];
            self.button.layer.cornerRadius = 5;
            self.button.layer.masksToBounds = YES;
            if (!self.cpString) {
                self.cpString = @"";
            }
            [self.button setTitle:self.cpString forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(completeOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.button];
        }
        
        if (indexPath.row == 11){
            
            UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            firstView.backgroundColor = color(230, 230, 230, 1);
            
            UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            secondView.backgroundColor = color(230, 230, 230, 1);
            UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            thirdView.backgroundColor = color(230, 230, 230, 1);
            
            [cell addSubview:firstView];
            [cell addSubview:secondView];
            [cell addSubview:thirdView];
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(20 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(25, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(65 + (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            {
                UIView *firstLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3 + (Width - 120)/6 - 1, 20, 1, 4*(Width - 120)/9 - 20)];
                firstLineView.backgroundColor = [UIColor whiteColor];
                UIView *secondLineView = [[UIView alloc]initWithFrame:CGRectMake(Width - 15 - (Width - 120)/3, 10 + 2*(Width - 120)/9 - 1, (Width - 120)/3 - 10, 1)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:firstLineView];
                [cell addSubview:secondLineView];
                
            }
            
            self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            self.thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9)];
            
            [cell addSubview:self.firstImageView];
            [cell addSubview:self.secondImageView];
            [cell addSubview:self.thirdImageView];
            
            UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            firstButton.backgroundColor = [UIColor clearColor];
            firstButton.frame = CGRectMake(20, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:firstButton];
            firstButton.tag = 4001;
            [firstButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secondButton.backgroundColor = [UIColor clearColor];
            secondButton.frame = CGRectMake(60 + (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:secondButton];
            secondButton.tag = 4002;
            [secondButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
            thirdButton.backgroundColor = [UIColor clearColor];
            thirdButton.frame = CGRectMake(Width - 20 - (Width - 120)/3, 10, (Width - 120)/3, 4*(Width - 120)/9);
            [cell addSubview:thirdButton];
            thirdButton.tag = 4003;
            [thirdButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        if (indexPath.row == 12){
            UIButton *FinishButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 5, Width - 100, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
            FinishButton.backgroundColor = color(59, 165, 249, 1);
            [FinishButton setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
            [FinishButton setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
            [FinishButton setTintColor:[UIColor whiteColor]];
            [FinishButton setTitle:@"提交" forState:0];
            FinishButton.layer.cornerRadius = 5;
            [FinishButton addTarget:self action:@selector(FinishButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:FinishButton];
        }
        
        

    }
    textfield.layer.cornerRadius = 5;//设置那个圆角的有多圆
    textfield.layer.masksToBounds = YES;
    textfield.backgroundColor = [UIColor whiteColor];
//    textfield.tag = 3000+indexPath.row;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


- (void)completeOrderClicked:(UIButton *)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [NSString stringWithFormat:@"%@/Task.ashx?action=getmeasures&id=%@",HomeUrl,@(self.taskID)];
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.stepList.count != 0) {
            [self.stepList removeAllObjects];
        }
        for (NSDictionary *dic in responseObject) {
            [self.stepList addObject:dic[@"value"]];
        }
        NSLog(@"responseObj == %@",responseObject);
        NSLog(@"self.stepList.count==%@",@(self.stepList.count));
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
  
    CPViewController *cpVC = [[CPViewController alloc]init];

    cpVC.stepList = self.stepList;
    cpVC.returnStep = ^(NSString *name, NSInteger row){
        NSString *title;
        if (!name) {
            title = @"";
        }else{
            title = name;
        }
        [sender setTitle:title forState:UIControlStateNormal];
       
        self.cpString = title;
    };
    
    
    [self presentViewController:cpVC animated:YES completion:nil];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.theway == 0) {
        if (indexPath.row == 9) {
            return (Height - StatusBarAndNavigationBarHeight)*3/12;
        }
    }
    else if (self.theway == 2) {
        if (indexPath.row == 13) {
            return (Height - StatusBarAndNavigationBarHeight)*3/12;
        }
    }else{
        if (indexPath.row == 11) {
            return (Height - StatusBarAndNavigationBarHeight)*3/12;
        }
    }
    
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

- (void)pictureAction:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        imagePickerController.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    if (sender.tag == 4001) {
        self.selectedBtnposition = 1;
    }else if (sender.tag == 4002) {
        self.selectedBtnposition = 2;
    }else if(sender.tag == 4003) {
        self.selectedBtnposition = 3;
    }
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.selectedBtnposition != 0) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        if (self.selectedBtnposition == 1) {
            self.firstImageView.image = image;
            NSData *data1 = UIImageJPEGRepresentation(image, 1);
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data1.data"];
            [data1 writeToFile:path atomically:YES];
        }
        if (self.selectedBtnposition == 2) {
            self.secondImageView.image = image;
            NSData *data2 = UIImageJPEGRepresentation(image, 1);
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data2.data"];
            [data2 writeToFile:path atomically:YES];
        }
        if (self.selectedBtnposition == 3) {
            self.thirdImageView.image = image;
            NSData *data3 = UIImageJPEGRepresentation(image, 1);
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data3.data"];
            [data3 writeToFile:path atomically:YES];
        }
        
        self.selectedBtnposition ++;
        if (self.selectedBtnposition == 4) {
            self.selectedBtnposition = 1;
        }
        
        return;
    }else{
        self.selectedBtnposition = 2;
        self.firstImageView.image = image;
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 扫码
-(void)sweepTheYardBtnAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:self.scanVC animated:YES];
    if (sender.tag == 3301) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ErWeiMa"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"ErWeiMa"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
     [self.session startRunning];
}

#pragma mark - AVCaptureMetaDataOutputObjectsDelegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [self.session stopRunning];
    //    [self.previewLayer removeFromSuperlayer];
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"ErWeiMa"] == 1) {
            self.textfield1.text = obj.stringValue;
        }else {
            self.textfield2.text = obj.stringValue;
        }
        
        
        NSLog(@"---%@",obj.stringValue);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



//设置键盘的retrun按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击空白处清空
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMyAlertView:(NSString*)str
{
    
    __block UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake((Width-280)/2, (Height-40)/2 , 280, 40)];
    lable.text = str;
    
    
    lable.backgroundColor = [UIColor blackColor];
    
    lable.textColor = [UIColor whiteColor];
    
    lable.font = [UIFont systemFontOfSize:14.0f];
    
    lable.textAlignment = NSTextAlignmentCenter;
    lable.layer.masksToBounds = YES;
    lable.layer.cornerRadius = 2.0f;
    
    lable.alpha = 0 ;
    
    [self.view addSubview:lable];
    
    [UIView animateWithDuration:0.5 animations:^{
        lable.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            lable.alpha = 0;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
            lable = nil;
        }];
    }];
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField.tag == 3001) {
        _BarCode = self.textfield1.text;
    }
    if (textField.tag == 3002) {
        _BarCode2 = self.textfield2.text;
    }
    
    if (textField.tag == 3003) {
        _InvoiceCode = textField.text;
    }
    
    if (textField.tag == 3004) {
        if (_theway == 0) {
            _PriceService = textField.text;
            
        }else if (_theway == 2)
        {
            _DCode = textField.text;
        }else{
            _BrokenReason = textField.text;
        }
    }
    
    if (textField.tag == 3005) {
        if (_theway == 0) {
            _PriceMaterials = textField.text;
           
        }
        else if (_theway == 2)
        {
            _CheckCode = textField.text;
        }else{
            _Change = textField.text;
        }
    }
    
    if (textField.tag == 3006) {
        if (_theway == 0) {
            _PriceAppend = textField.text;

        }
        else if (_theway == 2)
        {
            _PCode = textField.text;
        }else{
            _PriceService = textField.text;
        }
    }
    
    
    if (textField.tag == 3007) {
        if (_theway == 0) {
            _WorkPostscript = textField.text;
        }
        
        if (_theway == 2) {
            _PickCode = textField.text;
        }
        
        if (_theway == 1) {
            _PriceMaterials = textField.text;
        }
    }
    if (textField.tag == 3008) {
        
        if (_theway == 0) {
            _cpOreder = textField.text;
        }
        
        if (_theway == 2) {
            _PriceService = textField.text;
        }
        
        if (_theway == 1) {
            _PriceAppend = textField.text;
        }
    }
    
    
    if (textField.tag == 3009) {
        if (_theway == 2) {
            _PriceMaterials = textField.text;
        }
        if (_theway == 1) {
            _WorkPostscript = textField.text;
        }
    }
    
    
    if (textField.tag == 3010) {
        if (_theway == 1) {
            _cpOreder = textField.text;
        }
        if (_theway == 2) {
            _PriceAppend = textField.text;
        }
    }
    if (textField.tag == 3011) {
        if (_theway == 2) {
            _WorkPostscript = textField.text;
        }
    }
    if (textField.tag == 3012) {
        if (_theway == 2) {
            _cpOreder = textField.text;
        }
    }

    return YES;
}
//


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 3001) {
        _BarCode = self.textfield1.text;
    }
    if (textField.tag == 3002) {
        _BarCode2 = self.textfield2.text;
    }
    
    if (textField.tag == 3003) {
        _InvoiceCode = textField.text;
    }
    
    if (textField.tag == 3004) {
        if (_theway == 0) {
            _PriceService = textField.text;
            
        }else if (_theway == 2)
        {
            _DCode = textField.text;
        }else{
            _BrokenReason = textField.text;
        }
    }
    
    if (textField.tag == 3005) {
        if (_theway == 0) {
            _PriceMaterials = textField.text;
            
        }
        else if (_theway == 2)
        {
            _CheckCode = textField.text;
        }else{
            _Change = textField.text;
        }
    }
    
    if (textField.tag == 3006) {
        if (_theway == 0) {
            _PriceAppend = textField.text;
            
        }
        else if (_theway == 2)
        {
            _PCode = textField.text;
        }else{
            _PriceService = textField.text;
        }
    }
    
    
    if (textField.tag == 3007) {
        if (_theway == 0) {
            _WorkPostscript = textField.text;
        }
        
        if (_theway == 2) {
            _PickCode = textField.text;
        }
        
        if (_theway == 1) {
            _PriceMaterials = textField.text;
        }
    }
    if (textField.tag == 3008) {
        
        if (_theway == 0) {
            _cpOreder = textField.text;
        }
        
        if (_theway == 2) {
            _PriceService = textField.text;
        }
        
        if (_theway == 1) {
            _PriceAppend = textField.text;
        }
    }
    
    
    if (textField.tag == 3009) {
        if (_theway == 2) {
            _PriceMaterials = textField.text;
        }
        if (_theway == 1) {
            _WorkPostscript = textField.text;
        }
    }
    
    
    if (textField.tag == 3010) {
        if (_theway == 1) {
            _cpOreder = textField.text;
        }
        if (_theway == 2) {
            _PriceAppend = textField.text;
        }
    }
    if (textField.tag == 3011) {
        if (_theway == 2) {
            _WorkPostscript = textField.text;
        }
    }
    if (textField.tag == 3012) {
        if (_theway == 2) {
            _cpOreder = textField.text;
        }
    }
}

- (void)FinishButtonClicked {
    
    NSInteger count = 0;
    if (self.firstImageView.image) {
        count ++;
        self.imageData1 = UIImageJPEGRepresentation(self.firstImageView.image, 0.1);
    }
    
    if (self.secondImageView.image) {
        count ++;
        self.imageData2 = UIImageJPEGRepresentation(self.secondImageView.image, 0.1);
    }
    
    if (self.thirdImageView.image) {
        count ++;
        self.imageData3 = UIImageJPEGRepresentation(self.thirdImageView.image, 0.1);
    }
    

    
    
    
    if ( self.textfield1.text.length < 5) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = @"产品条码输入错误";
        HUD.label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:HUD];
        
        [HUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD hideAnimated:YES];
            [HUD removeFromSuperViewOnHide];
        });
        return;
    }
    
    
      NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=updateFinish",HomeUrl];
    if (!_InvoiceCode) {
        _InvoiceCode = @"";
    }
    if (!self.button.titleLabel.text) {
        self.button.titleLabel.text = @"";
    }
    
    
    
    
    NSLog(@"_taskID--%@",@(_taskID));
    NSLog(@"_WaiterName--%@",_WaiterName);
    NSLog(@"_FinishTime---%@",_FinishTime);
    NSLog(@"self.textfield1.text---%@",self.textfield1.text);
    NSLog(@"self.textfield2.text---%@",self.textfield2.text);
    NSLog(@"self.textfield1.text--%@",_WorkPostscript);
    NSLog(@"_BrokenReason---%@",_BrokenReason);
    NSLog(@"_Change----%@",_Change);
    NSLog(@"_PriceService--%@",_PriceService);
    NSLog(@"_InvoiceCode---%@",_InvoiceCode);
    NSLog(@"_PriceMaterials--%@",_PriceMaterials);
    NSLog(@"_PriceAppend--%@",_PriceAppend);
    NSLog(@"_DCode---%@",_DCode);
    NSLog(@"_CheckCode---%@",_CheckCode);
    NSLog(@"_DCode---%@",_DCode);
    NSLog(@"_CheckCode---%@",_CheckCode);
    NSLog(@"_PCode--%@",_PCode);
    NSLog(@"_PickCode---%@",_PickCode);
    NSLog(@"self.button.titleLabel.text---%@",self.button.titleLabel.text);
    
    
      NSDictionary *params = @{
                               @"taskID":@(_taskID),
                               @"WaiterName":_WaiterName,
                               @"FinishTime":_FinishTime,
                               @"BarCode":self.textfield1.text,
                               @"BarCode2":self.textfield2.text,
                               @"WorkPostscript":_WorkPostscript,
                               @"BrokenReason":_BrokenReason,
                               @"Change":_Change,
                               @"PriceService":_PriceService,
                               @"InvoiceCode":_InvoiceCode,
                               @"PriceMaterials":_PriceMaterials,
                               @"PriceAppend":_PriceAppend,
                               @"Dcode":_DCode,
                               @"CheckCode":_CheckCode,
                               @"PCode":_PCode,
                               @"PriceCode":_PickCode,
                               @"Measures":self.button.titleLabel.text
                               };

    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:hud];
    [hud showAnimated:YES];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSArray *picArray = [[NSArray alloc]init];
            NSArray *nameArray = @[
                                   @"profile_picture1",
                                   @"profile_picture2",
                                   @"profile_picture3"
                                   ];
            NSArray *fileNameArray = @[
                                   @"profile_picture1.jpeg",
                                   @"profile_picture2.jpeg",
                                   @"profile_picture3.jpeg"
                                   ];
            if (self.firstImageView.image) {
                if (self.secondImageView.image) {
                    if (self.thirdImageView.image) {
                        picArray = @[self.imageData1,self.imageData2,self.imageData3];
                    }else{
                        picArray = @[self.imageData1,self.imageData2];
                    }
                }else{
                    if (self.thirdImageView.image) {
                        picArray = @[self.imageData1,self.imageData3];
                    }else{
                        picArray = @[self.imageData1];
                    }
                }
            }else{
                if (self.secondImageView.image) {
                    if (self.thirdImageView.image) {
                        picArray = @[self.imageData2,self.imageData3];
                    }else{
                        picArray = @[self.imageData2];
                    }
                }else{
                    if (self.thirdImageView.image) {
                        picArray = @[self.imageData3];
                    }else{
                        picArray = @[];
                    }
                }
            }
            
            for (NSInteger i = 0; i < count; i ++) {
                
                [formData appendPartWithFileData:picArray[i] name:nameArray[i] fileName:fileNameArray[i] mimeType:@"image/jpeg"];
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            [MyProgressView dissmiss];
            
            
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
            
            MBProgressHUD *successHUD = [[MBProgressHUD alloc]initWithView:self.view];
            successHUD.mode = MBProgressHUDModeText;
            successHUD.label.font = font(14);
            successHUD.label.text = @"提交成功";
            [self.view addSubview:successHUD];
            [successHUD showAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [successHUD hideAnimated:YES];
                [successHUD removeFromSuperViewOnHide];
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
            
            NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

            NSLog(@"图片上传成功 %@",str);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateRedLabel object:nil];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud hideAnimated:YES];
            [hud removeFromSuperViewOnHide];
            
            MBProgressHUD *successHUD = [[MBProgressHUD alloc]initWithView:self.view];
            successHUD.mode = MBProgressHUDModeText;
            successHUD.label.font = font(14);
            successHUD.label.text = @"提交失败，请检查网络重新提交";
            [self.view addSubview:successHUD];
            [successHUD showAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [successHUD hideAnimated:YES];
                [successHUD removeFromSuperViewOnHide];
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }];

   

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (void)dateButtonClicked:(UIButton *)sender {
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
    datePickerVC.returnDate = ^(NSString *dateStr){
        [sender setTitle:dateStr forState:UIControlStateNormal];
        _FinishTime = dateStr;
    };
    
    [self presentViewController:datePickerVC animated:YES completion:nil];
}



@end
