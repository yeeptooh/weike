//

/**********//**********//**********//**********//**********//**********//*
          .--,       .--,
         ( (  \.---./  ) )
          '.__/o   o\__.'
             {=  ^  =}
              >  -  <
             /       \
            //       \\
           //|   .   |\\
           "'\       /'"_.-~^`'-.
              \  _  /--'         `
            ___)( )(___
           (((__) (__)))
                                                                         
    高山仰止,景行行止.虽不能至,心向往之。
                                                                         
    最怕你一生碌碌无为 还安慰自己平凡可贵

*********//**********//**********//**********//**********//**********/


//  DetailTaskPlanViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "DetailTaskPlanViewController.h"
#import "DetailTaskPlanTableViewCell.h"
#import "SectionDetailTaskPlanTableViewCell.h"
#import "Section2DetailTableViewCell.h"
#import "DetailThirdTableViewCell.h"
#import "DetailForthTableViewCell.h"
#import "CancelTableViewCell.h"

#import "TaskPlanToDoViewController.h"

#import "AppointmentViewController.h"
#import "ToCompleteTheWorkOrderViewController.h"//完成工单
#import "ChangeBackViewController.h"
#import "SendViewController.h"

#import "AFNetClass.h"
#import "MyProgressView.h"
//#import "BaseMapViewController.h"

#import "UserModel.h"
//#import "UWDatePickerView.h"


//#import "SeachPJViewController.h"

#import "ServiceViewController.h"

#import "AFNetworking.h"
#import "UserModel.h"
#import "OrderModel.h"



#import "MBProgressHUD.h"


//#import "ButtonViewController.h"
//#import <CoreLocation/CoreLocation.h>
#import "DatePickerViewController.h"
#import "TypeViewController.h"

#import "SaleViewController.h"
#import "CancelViewController.h"
#import "AddPJViewController.h"
#import "CancelPJViewController.h"

#import "OtherTableViewCell.h"

/*修改buttonclicked*/
#import "ZDDTransition.h"
#import "MyTransition.h"
#import "ChangeNameViewController.h"
#import "ChangeAddressViewController.h"
#import "ProductTypeViewController.h"
#import "BarCodeViewController.h"
#import "BuyShopViewController.h"

#import <AVFoundation/AVFoundation.h>

#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]


@interface DetailTaskPlanViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
//BMKLocationServiceDelegate,
//BMKGeoCodeSearchDelegate,
//UWDatePickerViewDelegate,
UIViewControllerTransitioningDelegate
//CLLocationManagerDelegate
>
{
//    NSDictionary *dataSource;
    UIView *blackView;
    UIDatePicker *_datePicker;
    UIButton *button1;
    UIButton *button2;
    NSString *time1;
    NSString *time2;
    UITapGestureRecognizer *tap;
    int xcHeight;
//    BMKLocationService *_locService;
//    BMKGeoCodeSearch *_geocodesearch;
    
    UIView * view;
    
    UIButton * button;
//    
//    
//    BOOL ret;
//    
//    BOOL textRet;
//    BOOL textRet1;
//    BOOL textRet2;
//    BOOL textRet3;
//    BOOL textRet4;
    
    
//    NSString * string ;
//    
//    
//    NSString * tfString1;
//    NSString * tfString2;
//    NSString * tfString3;
//    NSString * tfString4;
//    
//    
//    UITextField* tf;
    

//    UWDatePickerView *_pickerView;
    
//    NSString * dateString;
    
}

@property (nonatomic, strong)UITableView *TaskDetailTableView;
//@property (nonatomic, strong)ApponintmentView *apponintView;

@property (nonatomic, copy)NSString *ProductType;
@property (nonatomic, copy)NSString *ProductCode;
@property (nonatomic, copy)NSString *OutNum;
@property (nonatomic, copy)NSString *BuyShop;
@property (nonatomic, copy)NSString *BuyTime;
@property (nonatomic, copy)NSString *ServiceClassify;
//@property (nonatomic, copy)NSString *BuyerName;
@property (nonatomic, copy)NSString *BuyerAddress;

@property (nonatomic, strong) NSMutableArray *serviceList;
@property (nonatomic, strong) UIButton *aButton;

@property (nonatomic, strong) UITextField *text;


@property (nonatomic, strong) DetailTaskPlanTableViewCell *cell;
@property (nonatomic, strong) SectionDetailTaskPlanTableViewCell *Scell;
@property (nonatomic, strong) Section2DetailTableViewCell *scell2;
@property (nonatomic, strong) NSString *addressString;

//@property (nonatomic, strong) CLLocationManager *manager;



@property (nonatomic, strong) NSString *buyAddressString;

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *productType1;

@property (nonatomic, strong) NSString *repairType;

@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) NSMutableArray *storeNameList;



@property (nonatomic, strong) NSMutableArray *fromID;
@property (nonatomic, strong) NSMutableArray *toID;

@property (nonatomic, strong) UIAlertController *alertController;


@end

@implementation DetailTaskPlanViewController

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"此应用的照相功能已禁用" message:@"请到设置 - 维客 - 相机打开应用的相机功能" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [_alertController addAction:openAction];
        [_alertController addAction:closeAction];
        
    }
    return _alertController;
}

-(NSMutableArray *)fromID {
    if (!_fromID) {
        _fromID = [NSMutableArray array];
    }
    return _fromID;
}

- (NSMutableArray *)toID {
    if (!_toID) {
        _toID = [NSMutableArray array];
        
    }
    return _toID;
}

- (NSMutableArray *)nameList {
    if (!_nameList) {
        _nameList = [NSMutableArray array];
        
    }
    return _nameList;
}

- (NSMutableArray *)storeNameList {
    if (!_storeNameList) {
        _storeNameList = [NSMutableArray array];
        
    }
    return _storeNameList;
}
- (NSMutableArray *)serviceList {
    if (!_serviceList) {
        _serviceList = [NSMutableArray array];
    }
    return _serviceList;
}


- (UITableView *)TaskDetailTableView {
    if (!_TaskDetailTableView) {
        _TaskDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _TaskDetailTableView.bounces = NO;
        _TaskDetailTableView.showsVerticalScrollIndicator = NO;
    }
    return _TaskDetailTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBar];
    [self setUI];
    [self keyboardAddNotice];

    
}


#pragma mark - UI
- (void)setUI {
    
    self.TaskDetailTableView.delegate = self;
    self.TaskDetailTableView.dataSource = self;
    [self.view addSubview:self.TaskDetailTableView];
    
    if ([self.theStatus isEqualToString: @"回访"] || [self.theStatus isEqualToString: @"待完成"]) {
        self.TaskDetailTableView.frame = CGRectMake(0, 0, Width, Height-StatusBarAndNavigationBarHeight-50);
        UIView *buttonMainView = [[UIView alloc]initWithFrame:CGRectMake(0, Height- StatusBarAndNavigationBarHeight -50, Width, 50)];
        buttonMainView.backgroundColor = Common_BackColor;
        [self.view addSubview:buttonMainView];
    
        if ([self.theStatus isEqualToString:@"待完成"]) {
            NSArray *theArray = @[@"预约",@"完成",@"退单",@"转派"];
                for (int i = 0; i < 4; i ++) {
                    int dis = (Width-280)/5;
                    UIButton *appontmentButton = [[UIButton alloc]initWithFrame:CGRectMake(dis+(70+dis)*i, 8, 70, 35)];
                    [appontmentButton setBackgroundColor: [UIColor colorWithRed:23/255.0 green:133/255.0 blue:255/255.0 alpha:1]];
                    [appontmentButton setTitle:theArray[i] forState:0];
                    appontmentButton.tag = i+101;
                    [appontmentButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
                    appontmentButton.layer.cornerRadius = 5;
                    [buttonMainView addSubview:appontmentButton];
                }
        }else if([self.theStatus isEqualToString:@"回访"]){
        
            NSArray *theArray = @[@"销售开单",@"配件核销"];
                for (int i = 0; i < 2; i ++) {
                    int dis = (Width-240)/3;
                    UIButton *appontmentButton = [[UIButton alloc]initWithFrame:CGRectMake(dis + (120 + dis) * i, 8, 120, 35)];
                    [appontmentButton setBackgroundColor: [UIColor colorWithRed:23/255.0 green:133/255.0 blue:255/255.0 alpha:1]];
                    [appontmentButton setTitle:theArray[i] forState:0];
                    appontmentButton.tag = i+101;
                    [appontmentButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
                    appontmentButton.layer.cornerRadius = 5;
                    [buttonMainView addSubview:appontmentButton];
                    
                }
            }
        }
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if ([self.theStatus  isEqualToString: @"回访"]) {
        if (self.status == 11) {

            return 4+self.flag;
        }
        return 5+self.flag;
        
    } else if ([self.theStatus  isEqualToString: @"未完成"]){
        return 3+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已录入"]) {
        return 5+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已核销"]) {
        return 4+self.flag;
    } else if ([self.theStatus  isEqualToString: @"待审核"]) {
        return 3+self.flag;
    } else {
        return 3+self.flag;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        self.cell = nil;
        self.cell = [[NSBundle mainBundle]loadNibNamed:@"DetailTaskPlanTableViewCell" owner:self.cell options:nil][0];
        self.cell.backgroundColor = Common_BackColor;
        
        self.cell.selectionStyle = UITableViewCellAccessoryNone;
        [self.cell.BuyerName setTitle:[NSString stringWithFormat:@"%@",self.orderModel.BuyerName] forState:UIControlStateNormal];
        
        [self.cell.BuyerName addTarget:self action:@selector(BuyerNameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        _BuyerAddress = self.orderModel.BuyerShortAddress;

        self.cell.BuyerPhone.text = self.orderModel.BuyerPhone;

        NSString *title;
        if (!self.addressString) {
            title = self.orderModel.BuyerShortAddress;
        }else{
            if ([self.orderModel.BuyerDistrict isEqualToString:@""]) {
                title = self.addressString;
            }else{
                if ([self.orderModel.BuyerTown isEqualToString:@""]) {
                    title = [NSString stringWithFormat:@"%@%@",self.orderModel.BuyerDistrict,self.addressString];
                }else{
                    title = [NSString stringWithFormat:@"%@%@%@",self.orderModel.BuyerDistrict,self.orderModel.BuyerTown,self.addressString];
                }
            }
            
        }
        
        [self.cell.BuyAddress setTitle:title forState:UIControlStateNormal];
        [self.cell.BuyAddress addTarget:self action:@selector(BuyAddressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.InfoFrom.text = [NSString stringWithFormat:@"来源: %@",self.orderModel.InfoFrom];
        self.cell.CallPhone.text = [NSString stringWithFormat:@"来电: %@",self.orderModel.CallPhone];
        self.cell.BillCode.text = [NSString stringWithFormat:@"单据: %@",self.orderModel.BillCode];
        self.cell.CallPhoneString = self.orderModel.BuyerPhone;
        
        return self.cell;
        
    }
    else if ((indexPath.section == 1)||(indexPath.section == 2)){
        
            if (indexPath.section == 1) {
                self.scell2 = [[NSBundle mainBundle]loadNibNamed:@"Section2DetailTableViewCell" owner:self.cell options:nil][0];
                self.scell2.selectionStyle = UITableViewCellAccessoryNone;
                
                [self.scell2.ProductType setTitle:self.orderModel.ProductType forState:UIControlStateNormal];
                
                self.scell2.ProductType.tag = 2000;
                [self.scell2.ProductType addTarget:self action:@selector(productTypeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            

                
                [self.scell2.ProductNum setTitle:self.orderModel.BarCode forState:UIControlStateNormal];
                [self.scell2.ProductNum addTarget:self action:@selector(barCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.scell2.OutNum setTitle:self.orderModel.BarCode2 forState:UIControlStateNormal];
                

                
                [self.scell2.BuyShop setTitle:self.orderModel.BuyAddress forState:UIControlStateNormal];
                
                [self.scell2.BuyShop addTarget:self action:@selector(buyShopBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.scell2.BuyTime setTitle:self.orderModel.BuyTimeStr forState:UIControlStateNormal];
                
                [self.scell2.BuyTime addTarget:self action:@selector(buyTimeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.scell2.ServiceClassify setTitle:self.orderModel.RepairType forState:0];
                
                [self.scell2.ServiceClassify addTarget:self action:@selector(seraction:) forControlEvents:UIControlEventTouchUpInside];
                self.scell2.backgroundColor = Common_BackColor;
                self.scell2.selectionStyle = UITableViewCellAccessoryNone;
                return self.scell2;

            }else{
                
                self.Scell = [[NSBundle mainBundle]loadNibNamed:@"SectionDetailTaskPlanTableViewCell" owner:self.cell options:nil][0];
                self.Scell.selectionStyle = UITableViewCellAccessoryNone;
                NSString *atimeString = self.orderModel.CloseTime;
                NSRange arange = [atimeString rangeOfString:@"("];
                NSRange arange1 = [atimeString rangeOfString:@")"];
                NSInteger aloc = arange.location;
                NSInteger alen = arange1.location - arange.location;
                NSString *anewtimeString = [atimeString substringWithRange:NSMakeRange(aloc + 1, alen - 1)];
                // 时间戳转时间
                double alastactivityInterval = [anewtimeString doubleValue];
                NSDateFormatter *aformatter = [[NSDateFormatter alloc] init];
                [aformatter setDateStyle:NSDateFormatterMediumStyle];
                [aformatter setTimeStyle:NSDateFormatterShortStyle];
                [aformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [aformatter setDateFormat:@"HH:mm"];
                NSDate *apublishDate = [NSDate dateWithTimeIntervalSince1970:alastactivityInterval/1000];
                NSDate *adate = [NSDate date];
                NSTimeZone *azone = [NSTimeZone systemTimeZone];
                NSInteger ainterval = [azone secondsFromGMTForDate:adate];
                apublishDate = [apublishDate  dateByAddingTimeInterval: ainterval];
                NSString *aappointmentTime = [aformatter stringFromDate:apublishDate];
                
                self.Scell.CloseTime.text = [NSString stringWithFormat:@"时限: %@",aappointmentTime];
                self.Scell.ExpectantTime.text = [NSString stringWithFormat:@"预约: %@",self.orderModel.ExpectantTimeStr];
                self.Scell.BrokenPhenomenon.text = [NSString stringWithFormat:@"故障: %@",self.orderModel.BrokenPhenomenon];
                self.Scell.BrokenReason.text = [NSString stringWithFormat:@"原因: %@",self.orderModel.BrokenReason];
                self.Scell.TaskPostscript.text = [NSString stringWithFormat:@"备注: %@",self.orderModel.TaskPostscript];
                
                // 时间戳转时间
                /*
                 ([self.orderModel.FinishTime isEqualToString:@""] || [self.orderModel.FinishTime isEqual:[NSNull null]])
                 */
                if (![self.orderModel.AddTime isEqual:[NSNull null]]) {
                    NSString *timeString = self.orderModel.AddTime;
                    NSRange range = [timeString rangeOfString:@"("];
                    NSRange range1 = [timeString rangeOfString:@")"];
                    NSInteger loc = range.location;
                    NSInteger len = range1.location - range.location;
                    NSString *newtimeString = [timeString substringWithRange:NSMakeRange(loc + 1, len - 1)];
                    double lastactivityInterval = [newtimeString doubleValue];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
                    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
                    NSDate *date = [NSDate date];
                    NSTimeZone *zone = [NSTimeZone systemTimeZone];
                    NSInteger interval = [zone secondsFromGMTForDate:date];
                    publishDate = [publishDate  dateByAddingTimeInterval: interval];
                    NSString *appointmentTime = [formatter stringFromDate:publishDate];
                    self.Scell.FinishTime.text = [NSString stringWithFormat:@"受理: %@",appointmentTime];
                }
                else{
                    self.Scell.FinishTime.text = @"受理: ";
                }
            }
        self.Scell.backgroundColor = Common_BackColor;
        self.Scell.selectionStyle = UITableViewCellAccessoryNone;
        return self.Scell;
    }
    else if (indexPath.section == 3)
    {
        if (self.status == 11 || self.status == 15 || [self.theStatus  isEqualToString: @"已录入"]) {
            
            DetailThirdTableViewCell *Tcell = [[NSBundle mainBundle]loadNibNamed:@"DetailThirdTableViewCell" owner:self.cell options:nil][0];
            Tcell.selectionStyle = UITableViewCellAccessoryNone;
            
            
            int price1 = [self.orderModel.PriceAppend intValue];
            int price2 = [self.orderModel.PriceService intValue];
            int price3 = [self.orderModel.PriceMaterials intValue];
            Tcell.WorkMoney.text = [NSString stringWithFormat:@"收费: %d",price1+price2+price3];
            Tcell.ServiceClassify.text = self.orderModel.WorkPostscript;
            _ServiceClassify = self.orderModel.WorkPostscript;
            
            // 时间戳转时间
            if (![self.orderModel.FinishTime isEqual:[NSNull null]]) {
                NSString *timeString = self.orderModel.FinishTime;
                NSRange range = [timeString rangeOfString:@"("];
                NSRange range1 = [timeString rangeOfString:@")"];
                NSInteger loc = range.location;
                NSInteger len = range1.location - range.location;
                NSString *newtimeString = [timeString substringWithRange:NSMakeRange(loc + 1, len - 1)];
                double lastactivityInterval = [newtimeString doubleValue];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [formatter setDateFormat:@"yyyy年MM月dd日"];
                NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
                NSDate *date = [NSDate date];
                NSTimeZone *zone = [NSTimeZone systemTimeZone];
                NSInteger interval = [zone secondsFromGMTForDate:date];
                publishDate = [publishDate  dateByAddingTimeInterval: interval];
                NSString *appointmentTime = [formatter stringFromDate:publishDate];
                Tcell.FinishTime.text = [NSString stringWithFormat:@"完工时间: %@",appointmentTime];
            }else{
                Tcell.FinishTime.text = @"完工时间: ";
            }
            
            Tcell.backgroundColor = Common_BackColor;
            Tcell.selectionStyle = UITableViewCellAccessoryNone;
            return Tcell;
        }else if([self.theStatus isEqualToString:@"未完成"] || [self.theStatus isEqualToString:@"待审核"]){
            
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self.cell options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            if (self.isCancel) {
                if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark];
//                    return cell;
                }
                
                if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                    
                }else{
                    
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason];
//                    return cell;
                }
                
                
                
                if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason];
//                    return cell;
                }
                
                
                if (self.isChange) {
                    cell.InfoLabel.text = [cell.InfoLabel.text stringByAppendingString:[NSString stringWithFormat:@"\n更换配件: %@",self.orderModel.Change]];
                }
                
                return cell;
            }else if (self.isChange) {
                cell.InfoLabel.text = [NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change];
            }
            
            return cell;

        }else if ([self.theStatus isEqualToString:@"已核销"]) {
            CancelTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"CancelTableViewCell" owner:self.cell options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if ([self.orderModel.CancelReason2 isEqual:[NSNull null]]) {
                self.orderModel.CancelReason2 = @"";
            }
            cell.cancelLabel.text = [NSString stringWithFormat:@"核销信息: %@",self.orderModel.CancelReason2];
            return cell;
        }
    }
    else if (indexPath.section == 4)
    {
        if (self.status == 15 || [self.theStatus  isEqualToString: @"已录入"]) {
            
            DetailForthTableViewCell *Fcell = [[NSBundle mainBundle]loadNibNamed:@"DetailForthTableViewCell" owner:self.cell options:nil][0];
            Fcell.selectionStyle = UITableViewCellAccessoryNone;

            int theprice1 = [self.orderModel.MoneyService intValue];
            int theprice2 = [self.orderModel.MoneyMaterials intValue];
            int theprice3 = [self.orderModel.MoneyAppend intValue];
            Fcell.WorkMoney.text = [NSString stringWithFormat:@"收费: %d",theprice1+theprice2+theprice3];
            
            Fcell.backgroundColor = Common_BackColor;
            Fcell.selectionStyle = UITableViewCellAccessoryNone;
            return Fcell;
        }else if (self.status == 11 || [self.theStatus isEqualToString:@"已核销"]) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self.cell options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark];
//                    return cell;
                }
                
                if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                    
                }else{
                    
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason];
//                    return cell;
                }
                
                
                
                if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason];
                    
                }
                
                
                if (self.isChange) {
                    cell.InfoLabel.text = [cell.InfoLabel.text stringByAppendingString:[NSString stringWithFormat:@"\n更换配件: %@",self.orderModel.Change]];
                }
                
                return cell;
            }else if (self.isChange) {
                cell.InfoLabel.text = [NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change];
                return cell;
            }
        }
    }else if (indexPath.section == 5) {
        
        if ([self.theStatus  isEqualToString: @"已录入"] || self.status == 15) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self.cell options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark];
//                    return cell;
                }
                
                if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                    
                }else{
                    
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason];
//                    return cell;
                }
                
                
                
                if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                    
                }else{
                    cell.InfoLabel.text = [NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason];
                    
                }
                
                
                if (self.isChange) {
                    cell.InfoLabel.text = [cell.InfoLabel.text stringByAppendingString:[NSString stringWithFormat:@"\n更换配件: %@",self.orderModel.Change]];
                }
                return cell;
                
            }else if (self.isChange) {
                cell.InfoLabel.text = [NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change];
                return cell;
            }
        }
    }
    
    return self.cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 30;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 150;
    }else if (indexPath.section == 1) {
        return 140;
    }else if (indexPath.section == 2) {
        return 167;
    }else if (indexPath.section == 3){
        
        if ([self.theStatus  isEqualToString: @"回访"] || [self.theStatus  isEqualToString: @"已录入"]) {
            return UITableViewAutomaticDimension;
        }else if ([self.theStatus isEqualToString:@"未完成"] || [self.theStatus isEqualToString:@"待审核"]) {
            return UITableViewAutomaticDimension;
        }else{
            return UITableViewAutomaticDimension;
        }
        
    }else if (indexPath.section == 4){
//        if ([tableView numberOfSections] == 5 && self.flag == 1) {
//            return UITableViewAutomaticDimension;
//        }
//        return 64;

        if (self.status == 15 || [self.theStatus isEqualToString:@"已录入"]) {
            return 64;
        }
    
        return UITableViewAutomaticDimension;
    
    }else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    UILabel *title2Label = [[UILabel alloc]initWithFrame:CGRectMake(Width - 220, 5, 200 , 20)];
    title2Label.textAlignment = 2;
    title2Label.font = [UIFont systemFontOfSize:14];
    title2Label.textColor = [UIColor colorWithRed:23/255.0 green:133/255.0 blue:255/255.0 alpha:1];
    if (section == 1) {

        titleLabel.text = @"产品信息";
        
        title2Label.text = [NSString stringWithFormat:@"%@%@",self.orderModel.ProductBreed,self.orderModel.ProductClassify];
        UIView *backView = [[UIView alloc]init];
        [backView addSubview:titleLabel];
        [backView addSubview:title2Label];
        return backView;
    }
    if (section == 2) {
        if (self.serviceList) {
            [self.serviceList removeAllObjects];
        }
        
        UserModel *userModel = [UserModel readUserModel];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 5;
        NSString *serviceURLString = [NSString stringWithFormat:@"%@/Task.ashx?action=getservicetype&comid=%ld&parent=%@",HomeUrl,(long)userModel.CompanyID,self.orderModel.ID];
        [manager GET:serviceURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            for (NSDictionary *dic in responseObject[@"servicetype"]) {
                [self.serviceList addObject:dic[@"Name"]];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
            HUD.mode = MBProgressHUDModeText;
            HUD.label.text = @"请检查网络";
            [self.view addSubview:HUD];
            [HUD showAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
                [HUD removeFromSuperViewOnHide];
            });
        }];
        
        
        titleLabel.text = @"业务信息";
        self.aButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.aButton.frame = CGRectMake(Width - 220, 5, 200 , 20);
        [self.aButton setTitle:self.orderModel.ServiceClassify forState:UIControlStateNormal];
        [self.aButton addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.aButton.tintColor = [UIColor colorWithRed:23/255.0 green:133/255.0 blue:255/255.0 alpha:1];
        self.aButton.titleLabel.textColor = [UIColor colorWithRed:23/255.0 green:133/255.0 blue:255/255.0 alpha:1];
        self.aButton.titleLabel.textAlignment = 2;
        self.aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.aButton.titleLabel.font  = [UIFont systemFontOfSize:14];
        UIView *backView = [[UIView alloc]init];
        [backView addSubview:titleLabel];
        [backView addSubview:self.aButton];
        return backView;
    }
    if (section == 3) {
        
        if ([self.theStatus isEqualToString:@"回访"] || [self.theStatus isEqualToString:@"已录入"]) {
            titleLabel.text = @"完工信息";
            title2Label.text = self.orderModel.WaiterName;
            UIView *backView = [[UIView alloc]init];
            [backView addSubview:titleLabel];
            [backView addSubview:title2Label];
            return backView;
        }else if ([self.theStatus isEqualToString:@"已核销"]) {
            UIView *backView = [[UIView alloc]init];
            titleLabel.text = @"核销信息";
            [backView addSubview:titleLabel];
            
            return backView;

        }else{
            UIView *backView = [[UIView alloc]init];
            titleLabel.text = @"其他信息";
            [backView addSubview:titleLabel];
            
            return backView;

        }
  
        
    }
    if (section == 4) {
        
        if ([self.theStatus isEqualToString:@"已录入"] || self.status == 15) {
            titleLabel.text = @"回访结果";
            title2Label.text = [NSString stringWithFormat:@"%@分",self.orderModel.WorkScore];
            UIView *backView = [[UIView alloc]init];
            [backView addSubview:titleLabel];
            [backView addSubview:title2Label];
            return backView;

        }else if ([self.theStatus isEqualToString:@"已核销"] || self.status == 11) {
            titleLabel.text = @"其他信息";
            UIView *backView = [[UIView alloc]init];
            [backView addSubview:titleLabel];
            //            [backView addSubview:title2Label];
            return backView;

        }

    }
    
    if (section == 5) {
        titleLabel.text = @"其他信息";
        UIView *backView = [[UIView alloc]init];
        [backView addSubview:titleLabel];
        //            [backView addSubview:title2Label];
        return backView;
    }

    return nil;
}
- (void)aButtonClicked:(UIButton *)sender {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
                HUD.mode = MBProgressHUDModeText;
                HUD.label.text = @"请检查网络";
                [self.view addSubview:HUD];
                [HUD showAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [HUD hideAnimated:YES];
                    [HUD removeFromSuperViewOnHide];
                });
                return ;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                
            }
                break;
                
            default:
                break;
        }
    }];

    
    ServiceViewController *svc = [[ServiceViewController alloc] init];
//    if (self.serviceList) {
//        [self.serviceList removeAllObjects];
//    }
    svc.serviceList = self.serviceList;
    svc.returnService = ^(NSString *name, NSInteger row){
        [sender setTitle:name forState:UIControlStateNormal];
        UserModel *userModel = [UserModel readUserModel];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //AFN 3840错误,reason:后台返回不是json，而是字符串，必须对response进行（Http）serializer，然后对返回的data变为字符串UTF8编码打印即可
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *URL = [NSString stringWithFormat:@"%@/Task.ashx?action=upServiceType",HomeUrl];
        NSDictionary *params = @{
                                 @"id":self.orderModel.ID,
                                 @"type":name,
                                 @"userid":[NSNumber numberWithInteger:userModel.ID],
                                 @"handler":userModel.Name
                                 };
        
//        URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSString *string1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    };
    [self presentViewController:svc animated:YES completion:nil];
    

}



#pragma mark - 预约、完成、退单
- (void)appontmentAciton:(UIButton *)sender {
    
    switch (sender.tag) {
            // 预约
        case 101:{
            if ([self.theStatus  isEqualToString: @"待完成"]) {
                AppointmentViewController *appVC = [[AppointmentViewController alloc]init];
                appVC.ID = self.ID;
//                appVC.transitioningDelegate = self;
//                appVC.modalPresentationStyle = UIModalPresentationCustom;
                
                [self presentViewController:appVC animated:YES completion:nil];
            }else{
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=searchOrder&taskId=%ld",HomeUrl,(long)self.ID];
                
                UserModel *userModel = [UserModel readUserModel];
                
                [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    SaleViewController *sVC = [[SaleViewController alloc]init];
                    sVC.taskID = self.ID;
                    
                    if (!responseObject) {
                        
                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                        NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=getSalesman&companyId=%ld",HomeUrl,(long)userModel.CompanyID];
                        
                        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            for (NSDictionary *dic in responseObject[@"salesman"]) {
                                [self.nameList addObject:dic[@"Name"]];
                            }
                            
                            for (NSString *nameString in self.nameList) {
                                if ([userModel.Name isEqualToString:nameString]) {
                                    sVC.flag1 = 1;
                                    sVC.name = nameString;
                                    break ;
                                }else{
                                    sVC.name = @"";
                                    sVC.nameList = self.nameList;
                                    sVC.flag1 = 0;
                                }
                            }
                            
                            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                            NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=getWarehouse&companyId=%ld",HomeUrl,(long)userModel.CompanyID];
                            
                            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                for (NSDictionary *dic in responseObject[@"warehouse"]) {
                                    [self.storeNameList addObject:dic[@"Name"]];
                                }
                                
                                for (NSString *nameString in self.storeNameList) {
                                    if ([userModel.Name isEqualToString:nameString]) {
                                        sVC.flag2 = 1;
                                        sVC.storeName = nameString;
                                        break ;
                                    }else{
                                        sVC.storeName = @"";
                                        sVC.flag2 = 0;
                                        sVC.storeNameList = self.storeNameList;
                                    }
                                }
                                [self.navigationController pushViewController:sVC animated:YES];
                                
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
 
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                        }];
   
                    }else{
                    
                        NSString *Warehouse = responseObject[@"order"][0][@"Warehouse"];
                        AddPJViewController *addVC = [[AddPJViewController alloc]init];
                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                        NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=searchSellDatail&sellOrderId=%@",HomeUrl,responseObject[@"order"][0][@"ID"]];
                        addVC.taskID = responseObject[@"order"][0][@"ID"];
                        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           
                            addVC.ID = [responseObject[@"order"][0][@"ID"] integerValue];
                            addVC.money = responseObject[@"money"];
                            NSMutableArray *arr = [NSMutableArray array];
                            for (NSDictionary *dic in responseObject[@"product"]) {
                                [arr addObject:dic];
                                
                                
                            }
                            NSMutableArray *countArr = [NSMutableArray array];
                            for (NSDictionary *dic in responseObject[@"sellWares"]) {
                                [countArr addObject:dic];
                            }
                            addVC.Warehouse = Warehouse;
                            addVC.countList = countArr;
                            addVC.List = arr;
                            [self.navigationController pushViewController:addVC animated:YES];
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                        }];
                        
                    }
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
                    HUD.mode = MBProgressHUDModeText;
                    HUD.label.text = @"请检查网络";
                    [self.view addSubview:HUD];
                    [HUD showAnimated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [HUD hideAnimated:YES];
                        [HUD removeFromSuperViewOnHide];
                    });
                    return ;
                }];
                
                
                
            }
        }
            break;
            // 完成
        case 102:
        {
            
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if(status == AVAuthorizationStatusAuthorized) {
                
                if (self.status == 5){
                    ToCompleteTheWorkOrderViewController *toCompleteVC = [[ToCompleteTheWorkOrderViewController alloc]init];
                    toCompleteVC.taskID = (long)self.ID;
                    
                    toCompleteVC.WaiterName = self.orderModel.WaiterName;
                    toCompleteVC.BarCode = self.orderModel.BarCode;//产品条码
                    toCompleteVC.BarCode2 = self.orderModel.BarCode2;//外机条吗dataSource[@"BarCode2"];
                    toCompleteVC.WorkPostscript = self.orderModel.WorkPostscript;//dataSource[@"WorkPostscript"];
                    toCompleteVC.PriceService = self.orderModel.PriceService;//安装维修dataSource[@"PriceService"];
                    toCompleteVC.PriceMaterials = self.orderModel.PriceMaterials;//配件材料dataSource[@"PriceMaterials"];
                    toCompleteVC.PriceAppend = self.orderModel.PriceAppend;//其他费用dataSource[@"PriceAppend"];
                    //dataSource[@"BrokenReason"];
                    if (toCompleteVC.BrokenReason == nil) {
                        toCompleteVC.BrokenReason = @"";
                    }else{
                        toCompleteVC.BrokenReason = self.orderModel.BrokenReason;
                    }
                    
                    
                    //
                    if (toCompleteVC.Change == nil) {
                        toCompleteVC.Change = @"";
                    }else{
                        toCompleteVC.Change = self.orderModel.Change;
                    }
                    //dataSource[@"DCode"];
                    if (toCompleteVC.DCode == nil) {
                        toCompleteVC.DCode = @"";
                    }else{
                        toCompleteVC.DCode = self.orderModel.DCode;
                    }
                    //dataSource[@"CheckCode"];
                    if (toCompleteVC.CheckCode == nil) {
                        toCompleteVC.CheckCode = @"";
                    }else{
                        toCompleteVC.CheckCode = self.orderModel.CheckCode;
                    }
                    //dataSource[@"PCode"];
                    if (toCompleteVC.PCode == nil) {
                        toCompleteVC.PCode = @"";
                    }else{
                        toCompleteVC.PCode = self.orderModel.PCode;
                    }
                    //dataSource[@"PickCode"];
                    if (toCompleteVC.PickCode == nil) {
                        toCompleteVC.PickCode = @"";
                    }else{
                        toCompleteVC.PickCode = self.orderModel.PickCode;
                    }
                    
                    
                    
                    
                    if ([self.aButton.titleLabel.text  isEqualToString: @"上门维修"] || [self.aButton.titleLabel.text  isEqualToString: @"送点维修"]) {
                        toCompleteVC.BrokenReason = self.orderModel.BrokenReason;//故障原因dataSource[@"BrokenReason"];
                        toCompleteVC.Change = self.orderModel.Change;//配件更换dataSource[@"Change"];
                        toCompleteVC.DCode = @"";
                        toCompleteVC.CheckCode = @"";
                        toCompleteVC.PCode = @"";
                        toCompleteVC.PickCode = @"";
                        toCompleteVC.theway = 1;
                    }else if ([self.aButton.titleLabel.text  isEqualToString: @"配送"]) {
                        toCompleteVC.theway = 2;
                    }else {
                        toCompleteVC.theway = 0;
                    }
                    
                    
                    
                    
                    [self.navigationController pushViewController:toCompleteVC animated:YES];
                }else{
                    
                    
                    //系统taskID一般是工单ID  self.ID 是工单ID
                    
                    //orderID一般是这一单销售ID
                    
                    
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=searchChangeOrder&taskId=%ld",HomeUrl,(long)self.ID];
                    
                    UserModel *userModel = [UserModel readUserModel];
                    
                    
                    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        CancelViewController *cVC = [[CancelViewController alloc]init];
                        cVC.taskID = self.ID;
                        
                        if (!responseObject) {
                            //调出仓
                            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                            ///Product.ashx?action=getWarehouse companyId
                            NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=getWarehouse&companyId=%ld",HomeUrl,(long)userModel.CompanyID];
                            
                            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                                
                                for (NSDictionary *dic in responseObject[@"warehouse"]) {
                                    [self.nameList addObject:dic[@"Name"]];
                                    [self.fromID addObject:dic[@"ID"]];
                                }
                                
                                cVC.fromID = self.fromID;
                                for (NSString *nameString in self.nameList) {
                                    if ([userModel.Name isEqualToString:nameString]) {
                                        cVC.flag1 = 1;
                                        cVC.name = nameString;
                                        NSInteger j;
                                        for (NSInteger i = 0; i < self.fromID.count; i++) {
                                            if ([userModel.Name isEqualToString:nameString]) {
                                                j = i;
                                                break;
                                            }
                                        }
                                        
                                        cVC.from = self.fromID[j];
                                        break ;
                                    }else{
                                        cVC.name = @"";
                                        cVC.nameList = self.nameList;
                                        cVC.flag1 = 0;
                                    }
                                }
                                //调入仓
                                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=getWarehouse&companyId=%ld",HomeUrl,(long)userModel.CompanyID];
                                
                                [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    for (NSDictionary *dic in responseObject[@"warehouse"]) {
                                        //                                    [self.storeNameList addObject:dic[@"Name"]];
                                        //                                    NSLog(@"%@",dic[@"Name"]);
                                        //                                    NSLog(@"%@",dic);
                                        //                                    [self.toID addObject:dic[@"ID"]];
                                        if ([dic[@"Name"] isEqualToString:@"次品仓"]) {
                                            cVC.storeName = @"次品仓";
                                            cVC.to = dic[@"ID"];
                                        }
                                    }
                                    
                                    if ([cVC.storeName isEqualToString:@"次品仓"]) {
                                        
                                    }else {
                                        cVC.storeName = @"";
                                    }
                                    
                                    [self.navigationController pushViewController:cVC animated:YES];
                                    
                                    //两仓库不能相同
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                }];
                                
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
                            
                        }else{
                            
                            CancelPJViewController *cancelVC = [[CancelPJViewController alloc]init];
                            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                            //Product.ashx?action=SearchChange&changeID= 核销开单id
                            NSString *URL = [NSString stringWithFormat:@"%@/Product.ashx?action=SearchChange&changeID=%@",HomeUrl,responseObject[@"changeOrder"][0][@"ID"]];
                            //核销ID
                            cancelVC.taskID = responseObject[@"changeOrder"][0][@"ID"];
                            cancelVC.Warehouse = responseObject[@"changeOrder"][0][@"FromName"];
                            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                                cancelVC.ID = [responseObject[@"product"][0][@"ID"] integerValue];
                                cancelVC.proCount = responseObject[@"count"];
                                NSMutableArray *arr = [NSMutableArray array];
                                for (NSDictionary *dic in responseObject[@"product"]) {
                                    [arr addObject:dic];
                                    
                                }
                                NSMutableArray *countArr = [NSMutableArray array];
                                for (NSDictionary *dic in responseObject[@"changeDatail"]) {
                                    [countArr addObject:dic];
                                }
                                //                            cancelVC.Warehouse = Warehouse;
                                cancelVC.countList = countArr;
                                cancelVC.List = arr;
                                
                                [self.navigationController pushViewController:cancelVC animated:YES];
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
                            
                        }
                        
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
                        HUD.mode = MBProgressHUDModeText;
                        HUD.label.text = @"请检查网络";
                        [self.view addSubview:HUD];
                        [HUD showAnimated:YES];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [HUD hideAnimated:YES];
                            [HUD removeFromSuperViewOnHide];
                        });
                        return ;
                    }];
                    
                }
                
            } else {
                
                
                [self presentViewController:self.alertController animated:YES completion:nil];
                
                
                
                
            }
 
        }
            break;
        case 103:
            // 退单
        {
            ChangeBackViewController *changeVC = [[ChangeBackViewController alloc]init];
            changeVC.taskID = self.ID;
            changeVC.WaiterName = self.orderModel.WaiterName;//dataSource[@"WaiterName"];
            [self.navigationController pushViewController:changeVC animated:YES];
        }
            break;
            
        case 104: {/*
                    
                    (get)
                    common.ashx?action=getmywaiterlist&comid="+ companyId + "&userid="+userId;
                    (post)
                    Task.ashx?action=setwaiter
                    comid="+companyId+"&taskId="+taskId+"&waiterId="+waiterId
                    
                    */
            UserModel *userModel = [UserModel readUserModel];
            
            SendViewController *sendVC = [[SendViewController alloc]init];
//            sendVC.stepList
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [NSString stringWithFormat:@"%@/common.ashx?action=getmywaiterlist&comid=%@&userid=%@",HomeUrl,@(userModel.CompanyID),@(userModel.ID)];
            
            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                sendVC.stepList = [NSMutableArray arrayWithArray:responseObject];
                sendVC.ID = self.ID;
                [self presentViewController:sendVC animated:YES completion:nil];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
 
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - --------------------------------- -
/*
 路径：/Task.ashx?action=upBuyerName
 方式：POST
 参数：id、name、userid、handler
 返回：1表示成功
 */
- (void)BuyerNameButtonClicked:(UIButton *)sender {
    ChangeNameViewController *changeNameVC = [[ChangeNameViewController alloc]init];
    
    changeNameVC.transitioningDelegate = self;
    changeNameVC.modalPresentationStyle = UIModalPresentationCustom;
    changeNameVC.ID = self.ID;
    changeNameVC.returnName = ^(NSString *name) {
        [sender setTitle:name forState:UIControlStateNormal];
    };
    
    [self presentViewController:changeNameVC animated:YES completion:nil];
    
    
    
}



- (void)BuyAddressButtonClick:(UIButton *)sender {
    ChangeAddressViewController *changeAddVC = [[ChangeAddressViewController alloc]init];
    
    changeAddVC.transitioningDelegate = self;
    changeAddVC.modalPresentationStyle = UIModalPresentationCustom;
    changeAddVC.ID = self.ID;
    changeAddVC.returnAdd = ^(NSString *address) {
        self.addressString = address;
        
        
        NSString *title;
        if (!self.addressString) {
            title = self.orderModel.BuyerShortAddress;
        }else{
            if ([self.orderModel.BuyerDistrict isEqualToString:@""]) {
                title = self.addressString;
            }else{
                if ([self.orderModel.BuyerTown isEqualToString:@""]) {
                    title = [NSString stringWithFormat:@"%@%@",self.orderModel.BuyerDistrict,self.addressString];
                }else{
                    title = [NSString stringWithFormat:@"%@%@%@",self.orderModel.BuyerDistrict,self.orderModel.BuyerTown,self.addressString];
                }
            }
            
        }
        [sender setTitle:title forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:changeAddVC animated:YES completion:nil];
}

- (void)productTypeBtnClicked:(UIButton *)sender {
    ProductTypeViewController *typeVC = [[ProductTypeViewController alloc]init];
    
    typeVC.transitioningDelegate = self;
    typeVC.modalPresentationStyle = UIModalPresentationCustom;
    typeVC.ID = self.ID;
    typeVC.returnType = ^(NSString *type) {
        [sender setTitle:type forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:typeVC animated:YES completion:nil];
}

- (void)barCodeBtnClicked:(UIButton *)sender {
    BarCodeViewController *codeVC = [[BarCodeViewController alloc]init];
    
    codeVC.transitioningDelegate = self;
    codeVC.modalPresentationStyle = UIModalPresentationCustom;
    codeVC.ID = self.ID;
    codeVC.returnCode = ^(NSString *title) {
        [sender setTitle:title forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:codeVC animated:YES completion:nil];
}

- (void)buyShopBtnClicked:(UIButton *)sender {
    BuyShopViewController *shopVC = [[BuyShopViewController alloc]init];
    
    shopVC.transitioningDelegate = self;
    shopVC.modalPresentationStyle = UIModalPresentationCustom;
    shopVC.ID = self.ID;
    shopVC.returnTitle = ^(NSString *title) {
        [sender setTitle:title forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:shopVC animated:YES completion:nil];
}


- (void)buyTimeBtnClicked:(UIButton *)sender {
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
    datePickerVC.returnDate = ^(NSString *dateStr){
        
        NSString *year = [dateStr substringToIndex:4];
        NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [dateStr substringFromIndex:8];
        
        NSString *date = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
        
        
        [sender setTitle:date forState:UIControlStateNormal];
        
        
        UserModel *userModel = [UserModel readUserModel];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //AFN 3840错误,reason:后台返回不是json，而是字符串，必须对response进行（Http）serializer，然后对返回的data变为字符串UTF8编码打印即可
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        
        NSString *URL = [NSString stringWithFormat:@"%@/Task.ashx?action=upBuyTime",HomeUrl];
        NSDictionary *params = @{
                                 @"id":self.orderModel.ID,
                                 @"date":date,
                                 @"userid":[NSNumber numberWithInteger:userModel.ID],
                                 @"handler":userModel.Name
                                 };
        
        //        URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
    };
    [self presentViewController:datePickerVC animated:YES completion:nil];
}

- (void)seraction:(UIButton *)sender
{
    
    TypeViewController *typeVC = [[TypeViewController alloc]init];
    typeVC.returnType = ^(NSInteger row){
        
        NSString *title;
        if (row == 0) {
            title = @"保内";
        }else{
            title = @"保外";
        }
        if (row == 0) {
            [sender setTitle:@"保内" forState:UIControlStateNormal];
            
        }
        if (row == 1) {
            [sender setTitle:@"保外" forState:UIControlStateNormal];
            
        }
        
        
        
        UserModel *userModel = [UserModel readUserModel];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //AFN 3840错误,reason:后台返回不是json，而是字符串，必须对response进行（Http）serializer，然后对返回的data变为字符串UTF8编码打印即可
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *URL = [NSString stringWithFormat:@"%@/Task.ashx?action=upRepairType",HomeUrl];
        NSDictionary *params = @{
                                 @"id":self.orderModel.ID,
                                 @"type":title,
                                 @"userid":[NSNumber numberWithInteger:userModel.ID],
                                 @"handler":userModel.Name
                                 };
        
        //        URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSString *mstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        

    };
    
    [self presentViewController:typeVC animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate -
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:[AppointmentViewController class]]) {
        return [MyTransition transitionWithType:MyTransitionTypePresent duration:0.25];
    }
    return [ZDDTransition transitionWithType:ZDDTransitionTypePresent duration:0.25];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[AppointmentViewController class]]) {
        return [MyTransition transitionWithType:MyTransitionTypeDissmiss duration:0.25];
    }
    return [ZDDTransition transitionWithType:ZDDTransitionTypeDissmiss duration:0.25];
}

-(void)setNavigationBar {
    
    self.navigationItem.title = @"工单明细";
}

#pragma mark - 监听键盘 -
- (void)keyboardAddNotice {
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




- (void)keyboardWasShown:(NSNotification*)aNotification {
    //添加手势
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.view removeGestureRecognizer:tap];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 单击手势 -
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)backLastView:(UIBarButtonItem *)sender {
//    NSInteger count = self.navigationController.viewControllers.count;
//    if ([self.navigationController.viewControllers[0] isMemberOfClass:[TaskPlanToDoViewController class]]) {
//        
//        [((TaskPlanToDoViewController *)self.navigationController.viewControllers[0]).tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//        
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
