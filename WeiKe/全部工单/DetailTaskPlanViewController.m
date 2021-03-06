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
#import "ServiceViewController.h"

#import "AFNetworking.h"
#import "UserModel.h"
#import "OrderModel.h"

#import "MBProgressHUD.h"

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
#import "DialogViewController.h"
#import "DialogAnimation.h"
#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]


@interface DetailTaskPlanViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
UIViewControllerTransitioningDelegate
>
{
    UIView *blackView;
    UIDatePicker *_datePicker;
    UIButton *button1;
    UIButton *button2;
    NSString *time1;
    NSString *time2;
    UITapGestureRecognizer *tap;
    int xcHeight;
    UIView * view;
    UIButton * button;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *ProductType;
@property (nonatomic, copy) NSString *ProductCode;
@property (nonatomic, copy) NSString *OutNum;
@property (nonatomic, copy) NSString *BuyShop;
@property (nonatomic, copy) NSString *BuyTime;
@property (nonatomic, copy) NSString *ServiceClassify;
@property (nonatomic, copy) NSString *BuyerAddress;
@property (nonatomic, strong) NSMutableArray *serviceList;
@property (nonatomic, strong) UIButton *aButton;
@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) DetailTaskPlanTableViewCell *cell;

@property (nonatomic, strong) NSString *addressString;

@property (nonatomic, strong) NSString *buyAddressString;

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *productType1;

@property (nonatomic, strong) NSString *repairType;

@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) NSMutableArray *storeNameList;

@property (nonatomic, strong) NSMutableArray *fromID;
@property (nonatomic, strong) NSMutableArray *toID;

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSMutableArray *diaLogList;

@end

@implementation DetailTaskPlanViewController

- (NSMutableArray *)diaLogList {
    if (!_diaLogList) {
        _diaLogList = [NSMutableArray array];
    }
    return _diaLogList;
}

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"此应用的照相功能已禁用" message:@"选择确定开启应用的相机功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, Width, Height-StatusBarAndNavigationBarHeight - 150) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBar];
    [self.view addSubview:self.tableView];
    [self keyboardAddNotice];
    [self setBaseView];
    [self setBottomButton];
}

- (void)setBaseView {
    
    DetailTaskPlanTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailTaskPlanTableViewCell" owner:self options:nil] lastObject];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    [cell.BuyerName setTitle:[NSString stringWithFormat:@"%@",self.orderModel.BuyerName] forState:UIControlStateNormal];
    
    [cell.BuyerName addTarget:self action:@selector(BuyerNameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _BuyerAddress = self.orderModel.BuyerShortAddress;
    
    cell.BuyerPhone.text = self.orderModel.BuyerPhone;
    [cell.dialogButton addTarget:self action:@selector(disLogButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
    
    [cell.BuyAddress setTitle:title forState:UIControlStateNormal];
    [cell.BuyAddress addTarget:self action:@selector(BuyAddressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.InfoFrom.text = [NSString stringWithFormat:@"来源: %@",self.orderModel.InfoFrom];
    cell.CallPhone.text = [NSString stringWithFormat:@"来电: %@",self.orderModel.CallPhone];
    cell.BillCode.text = [NSString stringWithFormat:@"单据: %@",self.orderModel.BillCode];
    cell.CallPhoneString = self.orderModel.BuyerPhone;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 155)];
    cell.frame = baseView.bounds;
    [baseView addSubview:cell];
    
    [self.view addSubview:baseView];
    
}

- (void)disLogButtonClicked {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/Task.ashx?action=getfeedbacklist&taskid=%@",HomeUrl,@(self.ID)];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (self.diaLogList.count) {
            [self.diaLogList removeAllObjects];
        }
        
        for (NSDictionary *dic in responseObject) {
            [self.diaLogList addObject:dic];
        }
        
        DialogViewController *dialogVC = [[DialogViewController alloc] init];
        dialogVC.modalPresentationStyle = UIModalPresentationCustom;
        dialogVC.transitioningDelegate = self;
        dialogVC.dialogList = self.diaLogList;
        
        dialogVC.taskID = [NSString stringWithFormat:@"%@",@(self.ID)];
        dialogVC.fromUserName = self.fromUserName;
        dialogVC.fromUserID = self.fromUserID;
        dialogVC.toUserName = self.toUserName;
        
        
        [self presentViewController:dialogVC animated:YES completion:^{
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error.userInfo);
    }];
}

- (void)setBottomButton {
    if ([self.theStatus isEqualToString: @"回访"] || [self.theStatus isEqualToString: @"待完成"]) {
        self.tableView.frame = CGRectMake(0, 150, Width, Height-StatusBarAndNavigationBarHeight-TabbarHeight - 150);
        
        if ([self.theStatus isEqualToString:@"待完成"]) {
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - StatusBarAndNavigationBarHeight - TabbarHeight, Width, TabbarHeight)];
            containerView.backgroundColor = color(230, 230, 230, 1);
            [self.view addSubview:containerView];
            
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
            effectView.frame = containerView.bounds;
            [containerView addSubview:effectView];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.6)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [effectView.contentView addSubview:lineView];
            
            
            UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            completeButton.frame = CGRectMake(0, 0, Width/4, TabbarHeight);
            completeButton.backgroundColor = MainBlueColor;
            [completeButton setTitle:@"预约" forState:UIControlStateNormal];
            [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            completeButton.tag = 101;
            completeButton.titleLabel.font = font(13);
            [completeButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:completeButton];
            
            UIButton *recedeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            recedeButton.frame = CGRectMake(Width/4, 0, Width/4, TabbarHeight);
            recedeButton.backgroundColor = MainBlueColor;
            [recedeButton setTitle:@"完成" forState:UIControlStateNormal];
            [recedeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            recedeButton.tag = 102;
            recedeButton.titleLabel.font = font(13);
            [recedeButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:recedeButton];
            
            
            UIButton *requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
            requestButton.frame = CGRectMake(Width/2, 0, Width/4, TabbarHeight);
            [requestButton setTitle:@"退单" forState:UIControlStateNormal];
            [requestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            requestButton.titleLabel.font = font(13);
            requestButton.tag = 103;
            requestButton.backgroundColor = MainBlueColor;
            [requestButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:requestButton];
            
            
            UIButton *appendButton = [UIButton buttonWithType:UIButtonTypeCustom];
            appendButton.frame = CGRectMake(Width*3/4, 0, Width/4, TabbarHeight);
            
            [appendButton setTitle:@"转派" forState:UIControlStateNormal];
            [appendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            appendButton.titleLabel.font = font(13);
            appendButton.tag = 104;
            appendButton.backgroundColor = MainBlueColor;
            [appendButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:appendButton];
            
            UIView *colView1 = [[UIView alloc] initWithFrame:CGRectMake(Width/4-0.5, 15, 1, TabbarHeight - 30)];
            colView1.backgroundColor = [UIColor whiteColor];
            [effectView.contentView addSubview:colView1];
            
            UIView *colView2 = [[UIView alloc] initWithFrame:CGRectMake(Width/2-0.5, 15, 1, TabbarHeight - 30)];
            colView2.backgroundColor = [UIColor whiteColor];
            [effectView.contentView addSubview:colView2];
            
            UIView *colView3 = [[UIView alloc] initWithFrame:CGRectMake(Width*3/4-0.5, 15, 1, TabbarHeight - 30)];
            colView3.backgroundColor = [UIColor whiteColor];
            [effectView.contentView addSubview:colView3];
         
        }else if([self.theStatus isEqualToString:@"回访"]){
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - StatusBarAndNavigationBarHeight - TabbarHeight, Width, TabbarHeight)];
            containerView.backgroundColor = color(230, 230, 230, 1);
            [self.view addSubview:containerView];
            
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
            effectView.frame = containerView.bounds;
            [containerView addSubview:effectView];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.6)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [effectView.contentView addSubview:lineView];
            
            UIButton *receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
            receiveButton.frame = CGRectMake(0, 0, Width/2, TabbarHeight);
            [receiveButton setTitle:@"销售开单" forState:UIControlStateNormal];
            
            [receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            receiveButton.backgroundColor = MainBlueColor;
            receiveButton.tag = 101;
            [receiveButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:receiveButton];
            
            UIButton *refuseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            refuseButton.frame = CGRectMake(Width/2, 0, Width/2, TabbarHeight);
            [refuseButton setTitle:@"配件核销" forState:UIControlStateNormal];
            [refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            refuseButton.tag = 102;
            refuseButton.backgroundColor = MainBlueColor;
            [refuseButton addTarget:self action:@selector(appontmentAciton:) forControlEvents:UIControlEventTouchUpInside];
            [effectView.contentView addSubview:refuseButton];
            
            UIView *colView = [[UIView alloc] initWithFrame:CGRectMake(Width/2-0.7, 15, 1.4, TabbarHeight - 30)];
            colView.backgroundColor = [UIColor whiteColor];
            [effectView.contentView addSubview:colView];
            
        }
    }
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.theStatus  isEqualToString: @"回访"]) {
        if (self.status == 11) {
            
            return 3+self.flag;
        }
        return 4+self.flag;
        
    } else if ([self.theStatus  isEqualToString: @"未完成"]){
        return 2+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已录入"]) {
        return 4+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已核销"]) {
        return 3+self.flag;
    } else if ([self.theStatus  isEqualToString: @"待审核"]) {
        return 2+self.flag;
    } else {
        return 2+self.flag;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        Section2DetailTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"Section2DetailTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ProductType setTitle:self.orderModel.ProductType forState:UIControlStateNormal];
        cell.paymentLabel.text = [NSString stringWithFormat:@"%@元",self.orderModel.CollectionMoney];
        cell.ProductType.tag = 2000;
        [cell.ProductType addTarget:self action:@selector(productTypeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.typeLabel.text = [NSString stringWithFormat:@"%@%@",self.orderModel.ProductBreed,self.orderModel.ProductClassify];
        [cell.ProductNum setTitle:self.orderModel.BarCode forState:UIControlStateNormal];
        [cell.ProductNum addTarget:self action:@selector(barCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.OutNum setTitle:self.orderModel.BarCode2 forState:UIControlStateNormal];
        [cell.BuyShop setTitle:self.orderModel.BuyAddress forState:UIControlStateNormal];
        [cell.BuyShop addTarget:self action:@selector(buyShopBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.BuyTime setTitle:self.orderModel.BuyTimeStr forState:UIControlStateNormal];
        [cell.BuyTime addTarget:self action:@selector(buyTimeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ServiceClassify setTitle:self.orderModel.RepairType forState:0];
        [cell.ServiceClassify addTarget:self action:@selector(seraction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.status == 15) {
            cell.ServiceClassify.enabled = NO;
            cell.ProductNum.enabled = NO;
            cell.ProductType.enabled = NO;
            cell.BuyShop.enabled = NO;
            cell.BuyTime.enabled = NO;
        }
        
        return cell;

    }else if (indexPath.row == 1) {
        
        SectionDetailTaskPlanTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"SectionDetailTaskPlanTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        
        cell.CloseTime.text = [NSString stringWithFormat:@"%@",aappointmentTime];
        cell.ExpectantTime.text = [NSString stringWithFormat:@"%@",self.orderModel.ExpectantTimeStr];
        cell.BrokenPhenomenon.text = [NSString stringWithFormat:@"%@",self.orderModel.BrokenPhenomenon];
        cell.BrokenReason.text = [NSString stringWithFormat:@"%@",self.orderModel.BrokenReason];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"备注:    %@",self.orderModel.TaskPostscript]];
        
        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
        
        cell.TaskPostscript.attributedText = attributedString;
        [cell.businessInfoButton setTitle:self.orderModel.ServiceClassify forState:UIControlStateNormal];
        [cell.businessInfoButton addTarget:self action:@selector(businessInfoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
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
            cell.FinishTime.text = [NSString stringWithFormat:@"%@",appointmentTime];
        }
        else{
            cell.FinishTime.text = @"";
        }
        return cell;
        
    } else if (indexPath.row == 2) {
        
        if (self.status == 11 || self.status == 15 || [self.theStatus  isEqualToString: @"已录入"]) {
            
            DetailThirdTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"DetailThirdTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            int price1 = [self.orderModel.PriceAppend intValue];
            int price2 = [self.orderModel.PriceService intValue];
            int price3 = [self.orderModel.PriceMaterials intValue];
            
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"收费: %@",[NSString stringWithFormat:@"%d",price1+price2+price3]]];
            
            [attributedString1 addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
            
            cell.WorkMoney.attributedText = attributedString1;
            cell.ServiceClassify.text = self.orderModel.WorkPostscript;
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
                NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"完工时间: %@",appointmentTime]];
                
                [attributedString2 addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.FinishTime.attributedText = attributedString2;
            }else{
                cell.FinishTime.text = @"完工时间: ";
                cell.FinishTime.textColor = color(85, 85, 85, 1);
            }
            
            return cell;
        } else if([self.theStatus isEqualToString:@"未完成"] || [self.theStatus isEqualToString:@"待审核"]){
            
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            
            return cell;

        }else if ([self.theStatus isEqualToString:@"已核销"]) {
            CancelTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"CancelTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if ([self.orderModel.CancelReason2 isEqual:[NSNull null]]) {
                self.orderModel.CancelReason2 = @"";
            }
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"核销信息: %@",self.orderModel.CancelReason2]];
            
            [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
            cell.cancelLabel.attributedText = attributedString;
            return cell;
        }else {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            return cell;
        }
    } else if (indexPath.row == 3) {
        
        if (self.status == 15 || [self.theStatus  isEqualToString: @"已录入"]) {
            
            DetailForthTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"DetailForthTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            int theprice1 = [self.orderModel.MoneyService intValue];
            int theprice2 = [self.orderModel.MoneyMaterials intValue];
            int theprice3 = [self.orderModel.MoneyAppend intValue];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"收费: %d",theprice1+theprice2+theprice3]];
            
            [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
            
            cell.WorkMoney.attributedText = attributedString;
            
            return cell;
        }else if (self.status == 11 || [self.theStatus isEqualToString:@"已核销"]) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            return cell;
        }
    }else if (indexPath.row == 4) {
        
        if ([self.theStatus  isEqualToString: @"已录入"] || self.status == 15) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
        }
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 190;
    }else if (indexPath.row == 1) {
        if ([self.orderModel.TaskPostscript isEqualToString:@""] || !self.orderModel.TaskPostscript) {
            return UITableViewAutomaticDimension;
        }
        return 192;
    }else if (indexPath.row == 2){
        
        return UITableViewAutomaticDimension;
        
    }else if (indexPath.row == 3){

        return UITableViewAutomaticDimension;
    
    }else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)businessInfoButtonClicked:(UIButton *)sender {
    
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
        
        ServiceViewController *svc = [[ServiceViewController alloc] init];
        
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
           
            [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        };
        [self presentViewController:svc animated:YES completion:nil];
        
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
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"AVCan"]) {
                
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
                    
                
            }else {
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
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
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

        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    };
    [self presentViewController:datePickerVC animated:YES completion:nil];
}

- (void)seraction:(UIButton *)sender {
    
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

        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    };
    [self presentViewController:typeVC animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate -
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:[AppointmentViewController class]]) {
        return [MyTransition transitionWithType:MyTransitionTypePresent duration:0.25];
    } else if ([presented isKindOfClass:[DialogViewController class]]) {
        return [DialogAnimation dialogAnimationWithType:DialogAnimationTypePresent duration:0.75];
    }
    return [ZDDTransition transitionWithType:ZDDTransitionTypePresent duration:0.25];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[AppointmentViewController class]]) {
        return [MyTransition transitionWithType:MyTransitionTypeDissmiss duration:0.25];
    }else if ([dismissed isKindOfClass:[DialogViewController class]]) {
        return [DialogAnimation dialogAnimationWithType:DialogAnimationTypeDismiss duration:0.75];
    }
    return [ZDDTransition transitionWithType:ZDDTransitionTypeDissmiss duration:0.25];
}

-(void)setNavigationBar {
    self.navigationItem.title = @"工单明细";
}


@end
