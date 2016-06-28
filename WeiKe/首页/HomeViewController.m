//
//  HomeViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/24.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
//上一行
#import "TaskPlanToDoViewController.h"
#import "UnFinishViewController.h"
#import "AllOrderViewController.h"
#import "AddViewController.h"
//下一行
#import "FeesViewController.h"
#import "InformationViewController.h"
#import "DataHouseViewController.h"
#import "AboutViewController.h"
//下二行
#import "RepairViewController.h"
#import "EWMViewController.h"
//#import "RequestTableViewController.h"
#import "PJRequestTableViewController.h"

//下三行
#import "SearchViewController.h"
#import "BrokenViewController.h"


//#import "BaseMapViewController.h"

#import "AFNetClass.h"
#import "UserModel.h"
#import "MyProgressView.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


#import "LocationTracker.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController ()
<
UMSocialUIDelegate
>
{
    NSTimer *_timer;
    UIImageView *image;
    UIView *HomeTaskManagementView;
    UILabel *HomeTaskManagementLabel;
    UIView *HomeDownButtonBackView;
    UIView *HomeTopButtonBackView;
    UIButton *HomeTopButton;
    UILabel *HomeTopLabel ;
    UIView *HomeServerView;
    UILabel *HomeServerLabel;
}
@property (nonatomic, strong) UILabel *redPointLabel;

@property (nonatomic, strong) LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;
@property (nonatomic, strong) UIAlertController *alertController;

@property (nonatomic, strong) UIAlertController *locationAlertController;
@property (nonatomic, strong) UIAlertController *locationManagerAlertController;
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation HomeViewController




- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}


- (UIAlertController *)locationAlertController {
    if (!_locationAlertController) {
        _locationAlertController = [UIAlertController alertControllerWithTitle:@"此手机的定位功能已禁用" message:@"请点击确定打开手机的定位功能" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
        }];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [_locationAlertController addAction:openAction];
        [_locationAlertController addAction:closeAction];
        
    }
    return _locationAlertController;
}

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"此应用的相机功能已禁用" message:@"请点击确定打开应用的相机功能" preferredStyle:UIAlertControllerStyleAlert];
        
        
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

-(void)setUpLocationTraker{
    
    self.locationTracker = [[LocationTracker alloc]init];
    [self.locationTracker startLocationTracking];
    //设定向服务器发送位置信息的时间间隔
    NSTimeInterval time = 600.0;
    //开启计时器
    self.locationUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)updateLocation {
    NSLog(@"开始获取定位信息...");
    //向服务器发送位置信息
    [self.locationTracker updateLocationToServer];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self addNoti];
    

    self.navigationItem.title = @"维客";
    
    [self ask_networking];
    
    // 计时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
        if (![CLLocationManager locationServicesEnabled]) {
            [self presentViewController:self.locationAlertController animated:YES completion:nil];
            
        }else {
            [self setUpLocationTraker];
        }
        
        return;
    }
    
    
    [self setUpLocationTraker];

}


- (void)setServerCenterUI:(CGPoint)point {
    
    NSArray *HomeDownPicArray = @[@"homebutton3",@"homebutton4",@"homebutton5",@"homebutton6",@"homebutton7",@"homebutton8",@"homebutton9",@"homebutton10",@"homebutton11",@"homebutton14"];
    NSArray *HomeDownLabelArray = @[@"收费标准",@"我的信息",@"数据中心",@"通知公告",@"保修政策",@"二维码",@"分享好友",@"配件申请",@"配件查询",@"故障查询"];
    
    if (HomeDownButtonBackView) {
        [HomeDownButtonBackView removeFromSuperview];
        HomeDownButtonBackView = nil;
    }
    
    if (iPhone4_4s) {
        HomeDownButtonBackView = [[UIView alloc]initWithFrame:CGRectMake(0, point.y + 25, Width, Height-(point.y+25))];
        
    }else{
       HomeDownButtonBackView = [[UIView alloc]initWithFrame:CGRectMake(0, point.y + 35, Width, Height-(point.y+35))];
        
    }

    HomeDownButtonBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:HomeDownButtonBackView];
    
    NSInteger z = 0;
    for (NSInteger a = 0; a < 3; a ++) {
        for (NSInteger b = 0; b < 4; b ++) {
            if (z == 10) {
                return;
            }
            
            CGRect Frame;
            if (iPhone4_4s) {
                Frame = CGRectMake(15+((Width-90)/4+20)*b, 10 + ((Width-90)/4+ 30)*a, (Width-90)/4, (Width-90)/4);
            }else{
                Frame = CGRectMake(15+((Width-90)/4+20)*b, 15 + ((Width-90)/4+ 30)*a, (Width-90)/4, (Width-90)/4);
            }
            
            UIButton *HomeDownButton = [[UIButton alloc]initWithFrame:Frame];
            [HomeDownButton setBackgroundImage:[UIImage imageNamed:HomeDownPicArray[z]] forState:0];
            HomeDownButton.tag = 101+z;
            [HomeDownButton addTarget:self action:@selector(HomeDownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [HomeDownButtonBackView addSubview:HomeDownButton];

            CGRect labelFrame;
            if (iPhone4_4s) {
                labelFrame = CGRectMake(15+((Width-90)/4+20)*b, 10 + ((Width-90)/4+30)*a + (Width-90)/4, (Width-90)/4, 20);
            }else{
                labelFrame = CGRectMake(15+((Width-90)/4+20)*b, 15 + ((Width-90)/4+30)*a + (Width-90)/4, (Width-90)/4, 20);
            }
            UILabel *HomeDownLabel = [[UILabel alloc]initWithFrame:labelFrame];
            HomeDownLabel.textAlignment = NSTextAlignmentCenter;
            HomeDownLabel.font = [UIFont systemFontOfSize:12];

            HomeDownLabel.text = HomeDownLabelArray[z];
            [HomeDownButtonBackView addSubview:HomeDownLabel];
        
            z ++;
        }
    }
}

#pragma mark - 上方按钮
- (void)HomeTopButtonAction:(UIButton *)sender
{
    switch (sender.tag) {
        //待完成
        case 201:{
            TaskPlanToDoViewController *taskPlanToDoVC = [[TaskPlanToDoViewController alloc]init];
            [self.navigationController pushViewController:taskPlanToDoVC animated:YES];
        }
            break;
        //未完成
        case 202:{
            
            UnFinishViewController *unFinishVC = [[UnFinishViewController alloc]init];
            [self.navigationController pushViewController:unFinishVC animated:YES];
            
        }
            break;
        //全部工单
        case 203:{
            
            AllOrderViewController *allVC = [[AllOrderViewController alloc]init];
            [self.navigationController pushViewController:allVC animated:YES];
            
        }
            break;
        //新增工单
        case 204:{
            
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"AVCan"]) {
                AddViewController *addVC = [[AddViewController alloc]init];
                [self.navigationController pushViewController:addVC animated:YES];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AVCan"];
            }else {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (status == AVAuthorizationStatusAuthorized) {
                    AddViewController *addVC = [[AddViewController alloc]init];
                    [self.navigationController pushViewController:addVC animated:YES];
                }else {
                    [self presentViewController:self.alertController animated:YES completion:nil];
                }
            }
            
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 下方按钮
- (void)HomeDownButtonAction:(UIButton *)sender
{
    switch (sender.tag) {
        //收费标准
        case 101: {
            FeesViewController *feeVC = [[FeesViewController alloc]init];
            [self.navigationController pushViewController:feeVC animated:YES];
        }
            break;
        //我的信息
        case 102: {
            InformationViewController *loginVC = [[InformationViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
        //数据中心
        case 103: {
            DataHouseViewController *dataVC = [[DataHouseViewController alloc]init];
            [self.navigationController pushViewController:dataVC animated:YES];
        }
            break;
        //通知公告
        case 104: {
            AboutViewController *aboutVC = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        //保修政策
        case 105: {
            RepairViewController *repairVC = [[RepairViewController alloc]init];
            [self.navigationController pushViewController:repairVC animated:YES];
        }
            break;
        //二维码
        case 106: {
            
            EWMViewController *ewm = [[EWMViewController alloc]init];
            [self.navigationController pushViewController:ewm animated:YES];
        }
            break;
        //分享好友
        case 107: {
            // 友盟分享
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"568d183667e58ed934001601"
                                              shareText:@"友盟分享"
                                             shareImage:[UIImage imageNamed:@"icon.png"]
                                        shareToSnsNames:nil
                                               delegate:self];
        }break;
        //配件申请
        case 108: {
            
            PJRequestTableViewController *requestTVC = [[PJRequestTableViewController alloc]init];
            [self.navigationController pushViewController:requestTVC animated:YES];
        }
            break;
            //配件查询 
        case 109: {
            
            SearchViewController *searchVC = [[SearchViewController alloc]init];
            [self.navigationController pushViewController:searchVC animated:YES];
            searchVC.hidesBottomBarWhenPushed = YES;
        }
            break;
            
        case 110: {
            
            BrokenViewController *searchVC = [[BrokenViewController alloc]init];
            [self.navigationController pushViewController:searchVC animated:YES];
            searchVC.hidesBottomBarWhenPushed = YES;
        }
            break;
            
        
        default:
            break;
    }
}

#pragma mark - UI -
- (void)setDataManagerUI:(NSDictionary *)response
{
    NSArray *HomeTopPicArray = @[@"homebutton1",@"homebutton11",@"homebutton2",@"homebutton12"];
    NSArray *HomeTopLabelArray = @[@"待完成",@"未完成",@"全部工单",@"新增工单"];

    if (HomeTaskManagementView) {
        [HomeTaskManagementView removeFromSuperview];
        HomeTaskManagementView = nil;
    }
    if (iPhone4_4s) {
        HomeTaskManagementView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Width, 25)];
    }else{
        HomeTaskManagementView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Width, 35)];
    }
    
    HomeTaskManagementView.backgroundColor = color(234, 235, 236, 1);
    [self.view addSubview:HomeTaskManagementView];
    
    if (HomeTaskManagementLabel) {
        [HomeTaskManagementLabel removeFromSuperview];
        HomeTaskManagementLabel = nil;
    }
    
    if (iPhone4_4s) {
        HomeTaskManagementLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 3, 70, 19)];
        HomeTaskManagementLabel.font = [UIFont systemFontOfSize:13];
    }else{
        HomeTaskManagementLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 7, 75, 21)];
        HomeTaskManagementLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    HomeTaskManagementLabel.text = @"任务管理";
    [HomeTaskManagementView addSubview:HomeTaskManagementLabel];
    
    if (HomeTopButtonBackView) {
        [HomeTopButtonBackView removeFromSuperview];
        HomeTopButtonBackView = nil;
    }
    if (iPhone4_4s) {
        HomeTopButtonBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 89, Width, 77)];
    }else{
        HomeTopButtonBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 99, Width, 100)];
    }
    
    [self.view addSubview:HomeTopButtonBackView];
    
    NSInteger z = 0;
    
    if (HomeTopButton) {
        [HomeTopButton removeFromSuperview];
        HomeTopButton = nil;
    }
    if (self.redPointLabel) {
        [self.redPointLabel removeFromSuperview];
        self.redPointLabel = nil;
    }
    if (HomeTopLabel) {
        [HomeTopLabel removeFromSuperview];
        HomeTopLabel = nil;
    }
    for (NSInteger i = 0; i < 4; i ++) {
        
        if (iPhone4_4s) {
            HomeTopButton = [[UIButton alloc]initWithFrame:CGRectMake(15+((Width-90)/4+20)*i, 10, (Width-90)/4, (Width-90)/4)];
        }else{
            HomeTopButton = [[UIButton alloc]initWithFrame:CGRectMake(15+((Width-90)/4+20)*i, 15, (Width-90)/4, (Width-90)/4)];
        }
        
        [HomeTopButtonBackView addSubview:HomeTopButton];
        HomeTopButton.tag = 201+z;
        [HomeTopButton setBackgroundImage:[UIImage imageNamed:HomeTopPicArray[i]] forState:0];
        [HomeTopButton addTarget:self action:@selector(HomeTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // button上的红点
    
        self.redPointLabel = [[UILabel alloc]initWithFrame:CGRectMake((Width-90)/4-20*Width/320, 0, 20*Width/320, 20*Width/320)];
//        self.redPointLabel.font = [UIFont systemFontOfSize:8];
        if (i == 3) {
            
        }else{
            self.redPointLabel.backgroundColor = [UIColor redColor];
            self.redPointLabel.layer.masksToBounds = YES;
            self.redPointLabel.layer.cornerRadius = self.redPointLabel.frame.size.height/2;
            self.redPointLabel.textAlignment = 1;
            self.redPointLabel.textColor = [UIColor whiteColor];
            self.redPointLabel.font = [UIFont systemFontOfSize:10*Width/320];
        }

        [HomeTopButton addSubview:self.redPointLabel];
        
        switch (i) {
            case 0:{
                self.redPointLabel.text = response[@"TaskCount"][0][@"TaskTreat"];
                if ([self.redPointLabel.text isEqualToString:@"0"]) {
                    self.redPointLabel.text = @"";
                    self.redPointLabel.backgroundColor = [UIColor clearColor];
                }
            }
                break;
            case 1:{
                self.redPointLabel.text = response[@"TaskCount"][0][@"TaskUnFinish"];                
                if ([self.redPointLabel.text isEqualToString:@"0"]) {
                    self.redPointLabel.text = @"";
                    self.redPointLabel.backgroundColor = [UIColor clearColor];
                }
            }
                break;
            case 2:{
                self.redPointLabel.text = response[@"TaskCount"][0][@"TaskAll"];
                if ([self.redPointLabel.text isEqualToString:@"0"]) {
                    self.redPointLabel.text = @"";
                    self.redPointLabel.backgroundColor = [UIColor clearColor];
                }
            }
                break;
            default:
                break;
        }
        
        HomeTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+((Width-90)/4+20)*i, HomeTopButton.frame.origin.y+(Width-90)/4, (Width-90)/4, 20)];
        
        HomeTopLabel.text = HomeTopLabelArray[i];
        HomeTopLabel.textAlignment = 1;
        HomeTopLabel.font = [UIFont systemFontOfSize:12];
        [HomeTopButtonBackView addSubview:HomeTopLabel];
        z ++;
    }
    
    if (HomeServerView) {
        [HomeServerView removeFromSuperview];
        HomeServerView = nil;
    }
    if (iPhone4_4s) {
        HomeServerView = [[UIView alloc]initWithFrame:CGRectMake(0, HomeTopButtonBackView.frame.size.height+HomeTopButtonBackView.frame.origin.y+20, Width, 25)];
    }else{
        HomeServerView = [[UIView alloc]initWithFrame:CGRectMake(0, HomeTopButtonBackView.frame.size.height+HomeTopButtonBackView.frame.origin.y+20, Width, 35)];
    }
    
    HomeServerView.backgroundColor = color(234, 235, 236, 1);
    [self.view addSubview:HomeServerView];
    
    if (HomeServerLabel) {
        [HomeServerLabel removeFromSuperview];
        HomeServerLabel = nil;
    }
    if (iPhone4_4s) {
        HomeServerLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 3, 70, 19)];
        HomeServerLabel.font = [UIFont systemFontOfSize:13];
    }else{
        HomeServerLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 7, 75, 21)];
        HomeServerLabel.font = [UIFont systemFontOfSize:15];
    }
    
    HomeServerLabel.text = @"服务中心";
    [HomeServerView addSubview:HomeServerLabel];
    
    [self setServerCenterUI:HomeServerView.frame.origin];
}


#pragma mark - netWorking -
- (void)ask_networking {
    
    NSString *GetString = [NSString stringWithFormat:@"%@/Task.ashx?action=updateTaskCount",HomeUrl];
    UserModel *theModel = [UserModel readUserModel];
    NSDictionary *params = @{@"uid":[NSNumber numberWithInteger:theModel.ID],@"comid":[NSNumber numberWithInteger:theModel.CompanyID]};
    [AFNetClass AFNetworkingRequestWithURL:GetString andParmas:params withReturnBlock:^(NSDictionary *response, NSError *error) {
//        [MyProgressView dissmiss];
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"response"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self setDataManagerUI:response];
    }];
}


#pragma mark - 计时器
- (void)updateTimer:(NSTimer *)sender{
    [self ask_networking];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [_timer setFireDate:[NSDate distantFuture]];
//}
//
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [_timer setFireDate:[NSDate distantPast]];
//}


#pragma mark - 分享回调
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)addNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRedLabel:) name:kUpdateRedLabel object:nil];
}

- (void)updateRedLabel:(NSNotification *)noti {
    [self ask_networking];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
