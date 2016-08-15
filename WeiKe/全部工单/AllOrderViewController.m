//
//  AllOrderViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "AllOrderViewController.h"
#import "DetailTaskPlanViewController.h"
#import "TaskPlanToDoTableViewCell.h"
//#import "TaskPlanToDoTopTableViewCell.h"
#import "AFNetClass.h"
#import "UserModel.h"
#import "MyProgressView.h"
#import "PJRequestTableViewController.h"

#import "AFNetworking.h"
#import "OrderModel.h"
@interface AllOrderViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>
{
//    NSMutableArray *dataSource;
    UITapGestureRecognizer *tap;
    NSString *the_TextFiledString;

}

@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) UITableView *taskPlanToDoTableView;
@property (nonatomic, strong) UILabel *nilLabel;
@property (nonatomic, strong) UIView *noOrderView;
@property (nonatomic, strong) UIView *noNetWorkingView;
@property (nonatomic, strong) UIView *noSearchResultView;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *dicList;


@property (nonatomic, strong) UITableView *searchResultTableView;
@property (nonatomic, strong) UIView *searchResultView;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) NSMutableArray *searchResultList;


@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger searchPage;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIActivityIndicatorView *searchIndicatorView;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) OrderModel *orderModel;
@property (nonatomic, strong) AFHTTPRequestOperationManager *checkManager;

@end

@implementation AllOrderViewController

- (UIView *)noOrderView {
    if (!_noOrderView) {
        _noOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, SearchBarHeight, Width, Height - StatusBarAndNavigationBarHeight - TabbarHeight - SearchBarHeight)];
        _noOrderView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loding_wrong"]];
        imageView.center = CGPointMake(Width/2, _noOrderView.center.y - imageView.bounds.size.height/2 - 25);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.center = _noOrderView.center;
        label.text = @"无订单";
        label.font = font(18);
        label.textAlignment = NSTextAlignmentCenter;
        [_noOrderView addSubview:imageView];
        [_noOrderView addSubview:label];
        
    }
    return _noOrderView;
}

- (UIView *)noNetWorkingView {
    
    if (!_noNetWorkingView) {
        _noNetWorkingView = [[UIView alloc]initWithFrame:CGRectMake(0, SearchBarHeight, Width, Height - StatusBarAndNavigationBarHeight - TabbarHeight - SearchBarHeight)];
        _noNetWorkingView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loding_wrong"]];
        imageView.center = CGPointMake(Width/2, _noNetWorkingView.center.y - imageView.bounds.size.height/2 - 25);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.center = _noNetWorkingView.center;
        label.text = @"请检查网络";
        label.font = font(18);
        label.textAlignment = NSTextAlignmentCenter;
        [_noNetWorkingView addSubview:imageView];
        [_noNetWorkingView addSubview:label];
        
    }
    return _noNetWorkingView;
}

- (UIView *)noSearchResultView {
    if (!_noSearchResultView) {
        _noSearchResultView = [[UIView alloc]initWithFrame:CGRectMake(0, SearchBarHeight, Width, Height - StatusBarAndNavigationBarHeight - TabbarHeight - SearchBarHeight)];
        _noSearchResultView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loding_wrong"]];
        imageView.center = CGPointMake(Width/2, _noSearchResultView.center.y - imageView.bounds.size.height/2 - 25);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.center = _noSearchResultView.center;
        label.text = @"无搜索结果";
        label.font = font(18);
        label.textAlignment = NSTextAlignmentCenter;
        [_noSearchResultView addSubview:imageView];
        [_noSearchResultView addSubview:label];
    }
    return _noSearchResultView;
}


- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(0, 0, Width, Height);
        _indicatorView.center = CGPointMake(Width/2, (Height- StatusBarAndNavigationBarHeight)/2);
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (UIActivityIndicatorView *)searchIndicatorView {
    if (!_searchIndicatorView) {
        _searchIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _searchIndicatorView.frame = CGRectMake(0, 0, Width, Height);
        _searchIndicatorView.center = CGPointMake(Width/2, (Height- StatusBarAndNavigationBarHeight)/2);
        [self.searchResultView addSubview:_searchIndicatorView];
    }
    return _searchIndicatorView;
}

- (NSMutableArray *)dicList {
    if (!_dicList) {
        _dicList = [NSMutableArray array];
    }
    return _dicList;
}

- (NSMutableArray *)searchResultList {
    if (!_searchResultList) {
        _searchResultList = [NSMutableArray array];
    }
    return _searchResultList;
}


- (UITableView *)tableView {
    if (!_tableView) {
        
        CGRect frame;
        frame = CGRectMake(0, SearchBarHeight, Width, Height - StatusBarAndNavigationBarHeight - SearchBarHeight);
        
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.tag = 300;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = color(215, 227, 238, 1);
        __weak typeof(self) weakSelf = self;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        
    }
    return _tableView;
}


- (UITableView *)searchResultTableView {
    if (!_searchResultTableView) {
        
        CGRect frame;
        frame = CGRectMake(0, SearchBarHeight, Width, Height - StatusBarAndNavigationBarHeight - SearchBarHeight);

        _searchResultTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];

        _searchResultTableView.tag = 500;
        _searchResultTableView.tableFooterView = [[UIView alloc]init];
        _searchResultTableView.delegate = self;
        _searchResultTableView.dataSource = self;

        __weak typeof(self) weakSelf = self;
        _searchResultTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreSearchData];
        }];
        
    }
    return _searchResultTableView;
}


- (UIView *)searchResultView {
    
    if (!_searchResultView) {
        
        CGRect frame;
        frame = CGRectMake(0,0, Width, Height - StatusBarAndNavigationBarHeight);
        
        _searchResultView = [[UIView alloc]initWithFrame:frame];
        _searchResultView.backgroundColor = [UIColor whiteColor];//color(215, 227, 238, 1);
        _searchResultView.alpha = 0;
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, SearchBarHeight)];
        containerView.backgroundColor = color(235, 235, 235, 1);//color(215, 227, 238, 1);
        [_searchResultView addSubview:containerView];
        
        self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(8, 7, Width - 16, SearchBarHeight - 14)];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        self.whiteView.layer.cornerRadius = 5;
        self.whiteView.layer.masksToBounds = YES;
        [containerView addSubview:self.whiteView];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchButton setTitle:@" 客户姓名／客户电话" forState:UIControlStateNormal];
        [self.searchButton setTitleColor:color(30, 30, 30, 1) forState:UIControlStateNormal];
        
        CGFloat fontSize;
        if (iPhone6 || iPhone6_plus) {
            fontSize = 16;
        }else{
            fontSize = 14;
        }
        self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.searchButton.titleLabel.font = font(fontSize);
        self.searchButton.backgroundColor = [UIColor whiteColor];
        self.searchButton.frame = CGRectMake(8, 7, Width - 60, SearchBarHeight - 14);
        self.searchButton.layer.cornerRadius = 5;
        self.searchButton.layer.masksToBounds = YES;
        [containerView addSubview:self.searchButton];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(8, 7, Width - 60, SearchBarHeight - 14)];
        self.textfield.backgroundColor = [UIColor clearColor];
        self.textfield.clearsOnBeginEditing = YES;
        self.textfield.keyboardType = UIKeyboardTypeWebSearch;
        self.textfield.delegate = self;
        //监听textfield的text时时变化
        self.textfield.font = font(fontSize);
        [self.textfield addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        self.textfield.layer.cornerRadius = 5;
        self.textfield.layer.masksToBounds = YES;
        [containerView addSubview:self.textfield];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:BlueColor forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:color(240, 240, 240, 1) forState:UIControlStateHighlighted];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat fontsize;
        if (iPhone6 || iPhone6_plus) {
            fontsize = 18;
        }else{
            fontsize = 16;
        }
        self.cancelButton.titleLabel.font = font(fontsize);
        self.cancelButton.frame = CGRectMake(Width, 7, 60, 30);
        [_searchResultView addSubview:self.cancelButton];
        
    }
    return _searchResultView;
}

- (void)editingChanged:(UITextField *)sender {
    if (![sender.text isEqualToString:@""]) {
        self.searchButton.titleLabel.text = @"";
    }else{
        self.searchButton.titleLabel.text = @" 客户姓名／客户电话";
    }
    
    if (self.searchResultList.count) {
        [self.searchResultList removeAllObjects];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = color(215, 227, 238, 1);
    self.page = 1;
    self.searchPage = 1;
    [self setNavigationBar];

    [self setSearchButton];
    [self keyboardAddNotice];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_noOrderView) {
        [self.noOrderView removeFromSuperview];
        self.noOrderView = nil;
    }
    if (_noNetWorkingView) {
        [self.noNetWorkingView removeFromSuperview];
        self.noNetWorkingView = nil;
    }
    [self.indicatorView startAnimating];
    
    [self loadNewDate];
    
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.indicatorView stopAnimating];
    
    if (_noOrderView) {
        [self.noOrderView removeFromSuperview];
        self.noOrderView = nil;
    }
    
    if (_noNetWorkingView) {
        [self.noNetWorkingView removeFromSuperview];
        self.noNetWorkingView = nil;
    }
    
    if (_searchResultView) {
        [self.searchResultView removeFromSuperview];
        self.searchResultView = nil;
    }
    
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    
    [self.manager.operationQueue cancelAllOperations];
    
}



//导航栏
-(void)setNavigationBar {
    self.navigationItem.title = @"全部工单";
}


- (void)loadNewDate {
    [self requestNetWorking];
}

- (void)loadMoreData {
    self.page ++;
    [self requestNetWorking];
}

#pragma mark - NetWoring -
- (void)requestNetWorking{
    
    __weak typeof(self)weakSelf = self;
    UserModel *usermodel = [UserModel readUserModel];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=getlist&comid=%@&uid=%@&page=%@&query=%@&state=%@",HomeUrl,[NSNumber numberWithInteger: usermodel.CompanyID],[NSNumber numberWithInteger: usermodel.ID],[NSString stringWithFormat:@"%ld",(long)self.page],@"",@"-1"];
    
    NSString *theUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.requestSerializer.timeoutInterval = 5;
    
    [self.manager POST:theUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.indicatorView stopAnimating];
        
        if (weakSelf.page == 1) {
            if (weakSelf.dicList) {
                [weakSelf.dicList removeAllObjects];
            }
        }
        
        for (NSDictionary *dic in responseObject[@"task"]) {
            OrderModel *ordelModel = [OrderModel orderFromDictionary:dic];
            [weakSelf.dicList addObject:ordelModel];
        }
        if (!self.dicList.count) {
            [self.view addSubview:self.noOrderView];
            return ;
        }
        [weakSelf.view addSubview:weakSelf.tableView];
        [weakSelf.tableView reloadData];
        
        if ([responseObject[@"ResponseInfo"][0][@"PageNow"] integerValue] == [responseObject[@"ResponseInfo"][0][@"PageRowCount"] integerValue]) {
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.tableView.mj_footer.hidden = YES;
            return ;
        }else {
            weakSelf.tableView.mj_footer.hidden = NO;
        }
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [weakSelf.manager.operationQueue cancelAllOperations];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [self.indicatorView stopAnimating];
        
        weakSelf.tableView.mj_footer.hidden = YES;
        return ;
        
    }];
}



#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 300) {
        return self.dicList.count;
    }else{
        return self.searchResultList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    TaskPlanToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (tableView.tag == 300) {
        self.orderModel = self.dicList[indexPath.row];
    }else{
        self.orderModel = self.searchResultList[indexPath.row];
    }
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TaskPlanToDoTableViewCell" owner:cell options:nil][0];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.address.text = self.orderModel.BuyerAddress;
    NSString *timeString = self.orderModel.ExpectantTime;
    
    //dataSource[indexPath.row-1][@"ExpectantTime"];
    NSRange range = [timeString rangeOfString:@"("];
    NSRange range1 = [timeString rangeOfString:@")"];
    NSInteger loc = range.location;
    NSInteger len = range1.location - range.location;
    NSString *newtimeString = [timeString substringWithRange:NSMakeRange(loc + 1, len - 1)];
    
    // 时间戳转时间
    double lastactivityInterval = [newtimeString doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    publishDate = [publishDate  dateByAddingTimeInterval: interval];
    NSString *appointmentTime = [formatter stringFromDate:publishDate];
    cell.appointmentTime.text = [NSString stringWithFormat:@"预约 : %@",appointmentTime];
    
    
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
    
    cell.limitTime.text = [NSString stringWithFormat:@"时限 : %@",aappointmentTime];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",self.orderModel.BuyerName,self.orderModel.BuyerPhone]];
    
    [attributedString1 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}range:NSMakeRange(0, self.orderModel.BuyerName.length)];
    cell.User.attributedText = attributedString1;
    cell.Infoform.text = self.orderModel.InfoFrom;
    cell.UserCity.text = self.orderModel.BuyerDistrict;
    if ([self.orderModel.SwiftNumber isEqualToString:@""]) {
        cell.OrderID.text = [NSString stringWithFormat:@"[%@]",self.orderModel.ID];
    }else{
        cell.OrderID.text = [NSString stringWithFormat:@"[%@]",self.orderModel.SwiftNumber];
    }
    
    cell.OrderState.text = self.orderModel.StateStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%@] %@%@",self.orderModel.ServiceClassify, self.orderModel.ProductBreed, self.orderModel.ProductClassify]];
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:color(248, 89, 34, 1)}range:NSMakeRange(0, self.orderModel.ServiceClassify.length+2)];
    
    cell.SendName.attributedText = attributedString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 130;

}

#pragma mark - 跳转到明细工单
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSArray *vcList = self.navigationController.viewControllers;
    NSInteger count = vcList.count;
    UIViewController *vc = vcList[count - 2];//count - 1是自己
    
    if ([vc isKindOfClass:[PJRequestTableViewController class]]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        if (tableView.tag == 300) {
            self.returnID([NSString stringWithFormat:@"%@",((OrderModel *)self.dicList[indexPath.row]).ID]);
        }else{
            self.returnID([NSString stringWithFormat:@"%@",((OrderModel *)self.searchResultList[indexPath.row]).ID]);
        }
        
        
    }else{
        
        TaskPlanToDoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        DetailTaskPlanViewController *detailTaskPlanVC = [[DetailTaskPlanViewController alloc]init];
        
        if (tableView.tag == 300) {
            detailTaskPlanVC.orderModel = self.dicList[indexPath.row];
        }else{
            detailTaskPlanVC.orderModel = self.searchResultList[indexPath.row];
        }
        
        
        if ([detailTaskPlanVC.orderModel.ReceiveTaskStr isEqualToString:@"已查看"]) {
            
            if (([detailTaskPlanVC.orderModel.UnFinishRemark isEqualToString:@""] || [detailTaskPlanVC.orderModel.UnFinishRemark isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.CancelReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.CancelReason isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.NoEntryReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.NoEntryReason  isEqual:[NSNull null]])&&([detailTaskPlanVC.orderModel.Change isEqualToString:@""] || [detailTaskPlanVC.orderModel.Change isEqual:[NSNull null]])) {
                detailTaskPlanVC.flag = 0;
            }else{
                
                if (([detailTaskPlanVC.orderModel.Change isEqualToString:@""] || [detailTaskPlanVC.orderModel.Change isEqual:[NSNull null]])) {
                    detailTaskPlanVC.change = NO;
                }else{
                    detailTaskPlanVC.change = YES;
                }
                
                if (([detailTaskPlanVC.orderModel.UnFinishRemark isEqualToString:@""] || [detailTaskPlanVC.orderModel.UnFinishRemark isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.CancelReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.CancelReason isEqual:[NSNull null]]) && ([detailTaskPlanVC.orderModel.NoEntryReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.NoEntryReason  isEqual:[NSNull null]])) {
                    detailTaskPlanVC.cancel = NO;
                }else{
                    detailTaskPlanVC.cancel = YES;
                }
                
                detailTaskPlanVC.flag = 1;
            }
            
            
            
            if (tableView.tag == 300) {
                
                
                
                if ([((OrderModel *)self.dicList[indexPath.row]).State intValue]==5) {
                    detailTaskPlanVC.theStatus = @"待完成";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==11)||([((OrderModel *)self.dicList[indexPath.row]).State intValue]==15)){
                    detailTaskPlanVC.theStatus = @"回访";
                    
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==8)||([((OrderModel *)self.dicList[indexPath.row]).State intValue]==9)){
                    detailTaskPlanVC.theStatus = @"未完成";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==6)) {
                    detailTaskPlanVC.theStatus = @"待审核";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==16)) {
                    detailTaskPlanVC.theStatus = @"已录入";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==7)) {
                    detailTaskPlanVC.theStatus = @"已核销";
                }else {
                    detailTaskPlanVC.theStatus = @"其他";
                }

                
                
                detailTaskPlanVC.status = [((OrderModel *)self.dicList[indexPath.row]).State integerValue];
                detailTaskPlanVC.ID = [((OrderModel *)self.dicList[indexPath.row]).ID integerValue];
            }else{
                
                
                if ([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==5) {
                    detailTaskPlanVC.theStatus = @"待完成";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==11)||([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==15)){
                    detailTaskPlanVC.theStatus = @"回访";
                    
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==8)||([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==9)){
                    detailTaskPlanVC.theStatus = @"未完成";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==6)) {
                    detailTaskPlanVC.theStatus = @"待审核";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==16)) {
                    detailTaskPlanVC.theStatus = @"已录入";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==7)) {
                    detailTaskPlanVC.theStatus = @"已核销";
                }else {
                    detailTaskPlanVC.theStatus = @"其他";
                }
                
                
                detailTaskPlanVC.status = [((OrderModel *)self.searchResultList[indexPath.row]).State integerValue];
                detailTaskPlanVC.ID = [((OrderModel *)self.searchResultList[indexPath.row]).ID intValue];
            }
            
            [self.navigationController pushViewController:detailTaskPlanVC animated:YES];
            cell.userInteractionEnabled = YES;
        }else{
            
            self.checkManager = [AFHTTPRequestOperationManager manager];
            self.checkManager.requestSerializer.timeoutInterval = 5;
            self.checkManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            UserModel *userModel = [UserModel readUserModel];
            NSString *URL = [NSString stringWithFormat:@"%@/task.ashx?action=sendTaskLog",HomeUrl];
            NSDictionary *params = @{
                                     @"comId":@(userModel.CompanyID),
                                     @"userId":@(userModel.ID),
                                     @"taskId":detailTaskPlanVC.orderModel.ID,
                                     @"device":@"i"
                                     };
            
            [self.checkManager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *response = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@",response);
                    
                    if (([detailTaskPlanVC.orderModel.UnFinishRemark isEqualToString:@""] || [detailTaskPlanVC.orderModel.UnFinishRemark isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.CancelReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.CancelReason isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.NoEntryReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.NoEntryReason  isEqual:[NSNull null]])&&([detailTaskPlanVC.orderModel.Change isEqualToString:@""] || [detailTaskPlanVC.orderModel.Change isEqual:[NSNull null]])) {
                        detailTaskPlanVC.flag = 0;
                    }else{
                        
                        if (([detailTaskPlanVC.orderModel.Change isEqualToString:@""] || [detailTaskPlanVC.orderModel.Change isEqual:[NSNull null]])) {
                            detailTaskPlanVC.change = NO;
                        }else{
                            detailTaskPlanVC.change = YES;
                        }
                        
                        if (([detailTaskPlanVC.orderModel.UnFinishRemark isEqualToString:@""] || [detailTaskPlanVC.orderModel.UnFinishRemark isEqual:[NSNull null]])&& ([detailTaskPlanVC.orderModel.CancelReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.CancelReason isEqual:[NSNull null]]) && ([detailTaskPlanVC.orderModel.NoEntryReason isEqualToString:@""] || [detailTaskPlanVC.orderModel.NoEntryReason  isEqual:[NSNull null]])) {
                            detailTaskPlanVC.cancel = NO;
                        }else{
                            detailTaskPlanVC.cancel = YES;
                        }
                        
                        detailTaskPlanVC.flag = 1;
                    }
                    
                    
                    
                    if (tableView.tag == 300) {
                        
                        
                        
                        
                        detailTaskPlanVC.status = [((OrderModel *)self.dicList[indexPath.row]).State integerValue];
                        detailTaskPlanVC.ID = [((OrderModel *)self.dicList[indexPath.row]).ID integerValue];
                    }else{
                        
                        
                        
                        
                        detailTaskPlanVC.status = [((OrderModel *)self.searchResultList[indexPath.row]).State integerValue];
                        detailTaskPlanVC.ID = [((OrderModel *)self.searchResultList[indexPath.row]).ID intValue];
                    }
                    
                
               
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            if (tableView.tag == 300) {
                if ([((OrderModel *)self.dicList[indexPath.row]).State intValue]==5) {
                    detailTaskPlanVC.theStatus = @"待完成";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==11)||([((OrderModel *)self.dicList[indexPath.row]).State intValue]==15)){
                    detailTaskPlanVC.theStatus = @"回访";
                    
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==8)||([((OrderModel *)self.dicList[indexPath.row]).State intValue]==9)){
                    detailTaskPlanVC.theStatus = @"未完成";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==6)) {
                    detailTaskPlanVC.theStatus = @"待审核";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==16)) {
                    detailTaskPlanVC.theStatus = @"已录入";
                }else if (([((OrderModel *)self.dicList[indexPath.row]).State intValue]==7)) {
                    detailTaskPlanVC.theStatus = @"已核销";
                }else {
                    detailTaskPlanVC.theStatus = @"其他";
                }

            }else{
                if ([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==5) {
                    detailTaskPlanVC.theStatus = @"待完成";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==11)||([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==15)){
                    detailTaskPlanVC.theStatus = @"回访";
                    
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==8)||([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==9)){
                    detailTaskPlanVC.theStatus = @"未完成";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==6)) {
                    detailTaskPlanVC.theStatus = @"待审核";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==16)) {
                    detailTaskPlanVC.theStatus = @"已录入";
                }else if (([((OrderModel *)self.searchResultList[indexPath.row]).State intValue]==7)) {
                    detailTaskPlanVC.theStatus = @"已核销";
                }else {
                    detailTaskPlanVC.theStatus = @"其他";
                }
            }
            
            [self.navigationController pushViewController:detailTaskPlanVC animated:YES];
            cell.userInteractionEnabled = YES;
            
        }

    }
   
    
}




- (void)setSearchButton {
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@" 客户姓名／客户电话" forState:UIControlStateNormal];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [searchButton setTitleColor:color(150, 150, 150, 1) forState:UIControlStateNormal];
    [searchButton setTitleColor:color(200, 200, 200, 0.8) forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = 5;
    searchButton.layer.masksToBounds = YES;
    
    CGFloat fontSize;
    if (iPhone6 || iPhone6_plus) {
        fontSize = 16;
    }else{
        fontSize = 14;
    }
    
    searchButton.titleLabel.font = font(fontSize);
    searchButton.backgroundColor = color(235, 235, 235, 1);
    searchButton.frame = CGRectMake(8, 7, Width - 16, SearchBarHeight - 14);
    [self.view addSubview:searchButton];
    
    
    
}

- (void)searchButtonClicked:(UIButton *)sender {
    
    if (self.searchResultView) {
        [self.searchResultView removeFromSuperview];
        self.searchResultView = nil;
    }
    [self.view addSubview:self.searchResultView];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.searchResultView.alpha = 1;
        
        CGRect frame = self.whiteView.frame;
        frame.size.width = Width - 60;
        self.whiteView.frame = frame;
        self.cancelButton.frame = CGRectMake(Width - 60, 7, 60, 30);
        [self.textfield becomeFirstResponder];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelButtonClicked:(UIButton *)sender {
    self.searchPage = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.searchResultView.alpha = 0;
        [self.textfield resignFirstResponder];
        CGRect frame = self.whiteView.frame;
        frame.size.width = Width - 16;
        self.whiteView.frame = frame;
        self.cancelButton.frame = CGRectMake(Width, 7, 60, 30);
        [self.nilLabel removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.searchResultView removeFromSuperview];
        self.searchResultView = nil;
        
    }];
    
}




#pragma mark - 单击手势 -
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    self.searchPage = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.searchResultView.alpha = 0;
        [self.textfield resignFirstResponder];
        CGRect frame = self.whiteView.frame;
        frame.size.width = Width - 16;
        self.whiteView.frame = frame;
        self.cancelButton.frame = CGRectMake(Width, 7, 60, 30);
        
    } completion:^(BOOL finished) {
        [self.searchResultView removeFromSuperview];
        self.searchResultView = nil;
    }];
}

#pragma mark - 键盘回车 -
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //
    [textField resignFirstResponder];
    __weak typeof(self)weakSelf = self;
    
    if (_noSearchResultView) {
        [self.noSearchResultView removeFromSuperview];
        self.noSearchResultView = nil;
    }
    
    if (_searchResultTableView) {
        [self.searchResultTableView removeFromSuperview];
        self.searchResultTableView = nil;
    }
    
    [self.searchIndicatorView startAnimating];
    NSString *str = textField.text;
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                     (CFStringRef)str,NULL,NULL,kCFStringEncodingUTF8));
    
    // 进行网络请求
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=getlist&comid=%@&uid=%@&page=%@&query=%@&state=%@",HomeUrl,[NSNumber numberWithInteger: usermodel.CompanyID],[NSNumber numberWithInteger: usermodel.ID],@(self.searchPage),encodedString,@"-1"];

    
    the_TextFiledString = encodedString;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.searchIndicatorView stopAnimating];
       
        for (NSDictionary *dic in responseObject[@"task"]) {
            OrderModel *ordelModel = [OrderModel orderFromDictionary:dic];
            [weakSelf.searchResultList addObject:ordelModel];
        }
        if (!self.searchResultList.count) {
            [self.searchResultView addSubview:self.noSearchResultView];
            return ;
        }
        [weakSelf.searchResultView addSubview:weakSelf.searchResultTableView];
        [weakSelf.searchResultTableView reloadData];
        
        if ([responseObject[@"ResponseInfo"][0][@"PageNow"] integerValue] == [responseObject[@"ResponseInfo"][0][@"PageRowCount"] integerValue]) {
            [weakSelf.searchResultTableView.mj_footer endRefreshing];
            weakSelf.searchResultTableView.mj_footer.hidden = YES;
            return ;
        }else {
            weakSelf.searchResultTableView.mj_footer.hidden = NO;
        }
        
        [weakSelf.searchResultTableView.mj_footer endRefreshing];
        return ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        [weakSelf.searchResultTableView.mj_footer endRefreshing];
        [self.searchIndicatorView stopAnimating];
        weakSelf.searchResultTableView.mj_footer.hidden = YES;
        return ;
    }];
    
    
    return YES;
}

- (void)loadMoreSearchData {
    self.searchPage ++;
    
    __weak typeof(self)weakSelf = self;
    
    UserModel *usermodel = [UserModel readUserModel];
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=getlist&comid=%@&uid=%@&page=%@&query=%@&state=%@",HomeUrl,[NSNumber numberWithInteger: usermodel.CompanyID],[NSNumber numberWithInteger: usermodel.ID],@(self.searchPage),the_TextFiledString,@"-1"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.searchIndicatorView stopAnimating];
        
        for (NSDictionary *dic in responseObject[@"task"]) {
            OrderModel *ordelModel = [OrderModel orderFromDictionary:dic];
            [weakSelf.searchResultList addObject:ordelModel];
        }
        if (!self.searchResultList.count) {
            [self.searchResultView addSubview:self.noSearchResultView];
            return ;
        }
        [weakSelf.searchResultView addSubview:weakSelf.searchResultTableView];
        [weakSelf.searchResultTableView reloadData];
        
        if ([responseObject[@"ResponseInfo"][0][@"PageNow"] integerValue] == [responseObject[@"ResponseInfo"][0][@"PageRowCount"] integerValue]) {
            [weakSelf.searchResultTableView.mj_footer endRefreshing];
            weakSelf.searchResultTableView.mj_footer.hidden = YES;
            return ;
        }else {
            weakSelf.searchResultTableView.mj_footer.hidden = NO;
        }
        
        [weakSelf.searchResultTableView.mj_footer endRefreshing];
        return ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.searchResultTableView.mj_footer endRefreshing];
        [self.searchIndicatorView stopAnimating];
        weakSelf.searchResultTableView.mj_footer.hidden = YES;
        return ;
    }];
    
}





#pragma mark - 键盘 -
- (void)keyboardWasShown:(NSNotification*)aNotification {
    
    //添加手势
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.view removeGestureRecognizer:tap];
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    the_TextFiledString = textField.text;
//    return YES;
//}

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


@end
