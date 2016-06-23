//
//  DataHouseViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/16.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "DataHouseViewController.h"

#import "UserModel.h"
#import "TheWebViewController.h"


#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]


@interface DataHouseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DataHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    
    [self setTableview];
}

//导航栏
-(void)setNavigationBar
{
    self.navigationItem.title = @"数据中心";
    
}

- (void)setTableview
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = color(234, 235, 236, 1);
    [self.view addSubview:tableView];
}



#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    NSArray *array = @[@"不满意明细",@"结算汇总",@"库存查询",@"销售毛利",@"核销汇总",@"服务收费汇总"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = array[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TheWebViewController *theWeb = [[TheWebViewController alloc]init];
    
    NSArray *array = @[@"不满意明细",@"结算汇总",@"库存查询",@"销售毛利",@"核销汇总",@"服务收费汇总"];
    NSArray *urlList = @[
                         @"excell.aspx?action=notsatisfied",
                         @"excell.aspx?action=jiesuan",
                         @"StorageLeave.aspx?",
                         @"excell.aspx?action=xiaoshou",
                         @"excell.aspx?action=hexiao",
                         @"excell.aspx?action=fuwushoufei"
                         ];
    theWeb.urlStirng = urlList[indexPath.row];
    theWeb.theTitle = array[indexPath.row];
    [self.navigationController pushViewController:theWeb animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


@end
