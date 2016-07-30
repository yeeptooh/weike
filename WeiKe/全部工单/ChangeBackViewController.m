//
//  ChangeBackViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/13.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "ChangeBackViewController.h"
#import "AFNetClass.h"
#import "MyProgressView.h"
//#import "QutiTableView.h"
#import "UserModel.h"
#import "AFNetworking.h"
#import "RefuseViewController.h"
#import "MBProgressHUD.h"

#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]


@interface ChangeBackViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
{
    UITableView *ToCompleteTableView;
    UIView *headView;
    NSArray *dataArr;
    NSString*reason;
    UILabel *dataLab;
    NSMutableArray *namearray;
    NSMutableArray *thenameArray;
    int theindex;
    NSString *testreason;
    UITextField *textFiled;
    UIButton *picButton;
    UIButton *picButton2;
    UIButton *picButton3;
    int picCount;
//    NSData *imageData1;
//    NSData *imageData2;
//    NSData *imageData3;
    NSString *reasonps;
}
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) NSData *image_data;

//@property(nonatomic,retain)QutiTableView *quitTableview;

@property (nonatomic, strong) UIButton *theButton;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;

@property (nonatomic, assign) NSInteger selectedBtnposition;

@property (nonatomic, strong) NSData *imageData1;
@property (nonatomic, strong) NSData *imageData2;
@property (nonatomic, strong) NSData *imageData3;

@end

@implementation ChangeBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self keyboardAddNotification];
    // Do any additional setup after loading the view.
    theindex = 0;
    picCount = 0;
    dataArr = @[@"退单理由",@"备注内容",@"现场拍照",@""];
    testreason = @"";
    [self setNavigationBar];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/Task.ashx?action=getDataList&userID=%ld",HomeUrl,(long)[UserModel readUserModel].CompanyID];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        namearray = responseObject[@"DataList"];
        thenameArray = [[NSMutableArray alloc]init];
        for (int i = 0; i< namearray.count; i ++) {
            [thenameArray addObject:namearray[i][@"Name"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
//    [self askNetworking];
    [self setTableView];
    
    UIButton *FinishButton = [[UIButton alloc]initWithFrame:CGRectMake(80, (Height)*11/12, Width - 160, (Height - StatusBarAndNavigationBarHeight)/12)];
    FinishButton.backgroundColor = [UIColor colorWithRed:27/255.0 green:121/255.0 blue:254/255.0 alpha:1.0];
    [FinishButton setTintColor:[UIColor whiteColor]];
    [FinishButton setTitle:@"提交" forState:0];
    FinishButton.layer.cornerRadius = 5;
    [FinishButton addTarget:self action:@selector(FinishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FinishButton];
    //添加手势
//    UITapGestureRecognizer *tap;
//    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//    tap.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:tap];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(touchReasonAction:) name:@"touchReason" object:nil];

}

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

- (void)setTableView
{
    ToCompleteTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
    ToCompleteTableView.delegate = self;
    ToCompleteTableView.dataSource = self;
    ToCompleteTableView.backgroundColor = color(241, 241, 241, 1);
    ToCompleteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:ToCompleteTableView];

}

//导航栏
-(void)setNavigationBar {
    
    self.navigationItem.title = @"退单";
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    dataLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, Width/4, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
    dataLab.text = [dataArr objectAtIndex:indexPath.row];
    CGFloat fontSize;
    if (iPhone6_plus || iPhone6) {
        fontSize = 17;
    }else{
        fontSize = 14;
    }
    dataLab.font = [UIFont systemFontOfSize:fontSize];
    dataLab.textAlignment = NSTextAlignmentRight;
    [cell addSubview:dataLab];
    
    if (indexPath.row == 0) {
        self.theButton = [[UIButton alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        self.theButton.layer.masksToBounds = YES;
        self.theButton.layer.cornerRadius = 5;
        self.theButton.backgroundColor = [UIColor whiteColor];
        self.theButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.theButton setTitleColor:[UIColor blackColor] forState:0];
        [self.theButton setTitle:[NSString stringWithFormat:@"%@", @"用户拒修"] forState:0];
        self.theButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self.theButton addTarget:self action:@selector(theButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.theButton];

        
    }
    else if (indexPath.row == 1){
        textFiled = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        textFiled.layer.cornerRadius = 5;
        textFiled.layer.masksToBounds = YES;
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.delegate = self;
        [cell addSubview:textFiled];
    }else if (indexPath.row == 2){

        

        
        
        
        
    }else{
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
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)theButtonAciton:(UIButton *)sender {
    
    
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
    
    
    RefuseViewController *svc = [[RefuseViewController alloc] init];
    svc.stepList = thenameArray;
    svc.returnStep = ^(NSString *name, NSInteger row){
        [sender setTitle:name forState:UIControlStateNormal];
    };
    [self presentViewController:svc animated:YES completion:nil];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return (Height - StatusBarAndNavigationBarHeight)*3/12;
    }
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

#pragma mark -
- (void)FinishButtonAction
{
//    [MyProgressView showWith:@"Loading..."];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Json" forKey:@"Json"];
    [textFiled resignFirstResponder];
    NSString*urlString=[NSString stringWithFormat:@"%@/Task.ashx",HomeUrl];
    NSDictionary*params = @{
                            @"action":@"updateUnFinish",
                            @"taskID":@(_taskID),
                            @"WaiterName":_WaiterName,
                            @"DropCancelReason":self.theButton.titleLabel.text,
                            @"reason":textFiled.text
                            };
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:ToCompleteTableView];
    HUD.mode = MBProgressHUDModeIndeterminate;
    [ToCompleteTableView addSubview:HUD];
    [HUD showAnimated:YES];
    
    
    NSInteger count = 0;
    if (self.firstImageView.image) {
        count ++;
        self.imageData1 = UIImageJPEGRepresentation(self.firstImageView.image, 0.1);//UIImagePNGRepresentation(self.firstImageView.image);//
    }
    
    if (self.secondImageView.image) {
        count ++;
        self.imageData2 = UIImageJPEGRepresentation(self.secondImageView.image, 0.1);//UIImagePNGRepresentation(self.secondImageView.image);//
    }
    
    if (self.thirdImageView.image) {
        count ++;
        self.imageData3 = UIImageJPEGRepresentation(self.thirdImageView.image, 0.1);//UIImagePNGRepresentation(self.thirdImageView.image);//
    }
    
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
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < count; i ++) {
            
            //name必须跟后台给的一致，fileName随便
            [formData appendPartWithFileData:picArray[i] name:nameArray[i] fileName:fileNameArray[i] mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hideAnimated:YES];
        [HUD removeFromSuperViewOnHide];
        
        NSLog(@"responseObject====%@",responseObject);
        
        MBProgressHUD *successHUD = [[MBProgressHUD alloc]initWithView:ToCompleteTableView];
        successHUD.mode = MBProgressHUDModeText;
        successHUD.label.text = @"退单成功";
        CGFloat fontsize;
        if (iPhone4_4s) {
            fontsize = 14;
        }else{
            fontsize = 16;
        }
        
        successHUD.label.font = [UIFont systemFontOfSize:fontsize];
        
        [ToCompleteTableView addSubview:successHUD];
        [successHUD showAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateRedLabel object:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [successHUD hideAnimated:YES];
            [successHUD removeFromSuperViewOnHide];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUD hideAnimated:YES];
        [HUD removeFromSuperViewOnHide];
        
        MBProgressHUD *successHUD = [[MBProgressHUD alloc]initWithView:ToCompleteTableView];
        successHUD.mode = MBProgressHUDModeText;
        successHUD.label.text = @"退单失败，请检查网络";
        CGFloat fontsize;
        if (iPhone4_4s) {
            fontsize = 14;
        }else{
            fontsize = 16;
        }
        
        successHUD.label.font = [UIFont systemFontOfSize:fontsize];
        
        [ToCompleteTableView addSubview:successHUD];
        [successHUD showAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [successHUD hideAnimated:YES];
            [successHUD removeFromSuperViewOnHide];
            
        });
    }];
    
    
    
}

//
//#pragma mark - 图片上传
//- (void)pictureAction:(UIButton *)sender
//{
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
//        
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.sourceType = sourceType;
//        
//        [self presentViewController:imagePickerController animated:YES completion:^{
//            
//        }];
//        
//    }];
//    
//    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        
//                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//                imagePickerController.delegate = self;
//                imagePickerController.allowsEditing = YES;
//                imagePickerController.sourceType = sourceType;
//        
//                [self presentViewController:imagePickerController animated:YES completion:^{
//        
//                }];
//        
////        [self presentPhotoPickerViewControllerWithStyle:0];
//        
//    }];
//    
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [actionSheet addAction:cameraAction];
//    [actionSheet addAction:albumAction];
//    [actionSheet addAction:cancelAction];
//    
//    [self presentViewController:actionSheet animated:YES completion:nil];
//}
//
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
//{
//    if (buttonIndex == 0) {
//        
//        //判断当前传入的这个多媒体类型是不是一个有效的类型
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
//            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            //            [self presentModalViewController:imagePicker animated:YES];
//            [self presentViewController:imagePicker animated:YES completion:nil];
//        }
//        else
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"调用相机失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//            [alertView show];
//        }
//    }
//    else if(buttonIndex == 1)
//    {
//        
//        //判断一下这个相册类型是不是有效类型
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
//            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            //            [self presentModalViewController:imagePicker animated:YES];
//            [self presentViewController:imagePicker animated:YES completion:nil];
//        }
//        else
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"调用相册失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//            [alertView show];
//        }
//        
//    }
//}
//
//-(void)loadImagePickerWithSourceType:(UIImagePickerControllerSourceType) sourceType
//{
//    //在这个方法里，我们去创建一个UIImagePickerController对象
//    //这是一个系统封装的相机和相册的使用逻辑的一个控制器
//    //创建一下对象
//    UIImagePickerController * pickerContoller = [[UIImagePickerController alloc]init];
//    
//    //设置一下代理
//    pickerContoller.delegate = self;
//    
//    //设置类型
//    pickerContoller.sourceType = sourceType;
//    
//    //判断一下是否可以进行后续的编辑
//    //条件是当调用相册时，才进行后续编辑操作
//    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
//        pickerContoller.allowsEditing = YES;
//    }
//    
//    //因为UIImagePickerController是一个视图控制器
//    //所以，我们在使用他的时候，需要使用模态化的形式把他呈现出来
//    [self presentViewController:pickerContoller animated:NO completion:^{
//    }];
//}
//#pragma mark - 实现UIImagePickerController协议的方法
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:NO completion:^{
//    }];
//}
//
////这个方法是调用相册时，处理图片使用，info参数中，保存的是图片的信息
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    //    选定图片之后所执行的操作
//    NSString *imageType = [info objectForKey:UIImagePickerControllerMediaType];
//    //因为在相册里存的除了图片，可能还有视频
//    //所以先判断一下，取出来的是什么类型
//    if ([imageType isEqualToString: (NSString *)kUTTypeImage])
//    {
//        _image = [info objectForKey:UIImagePickerControllerEditedImage];
//        _image_data = UIImageJPEGRepresentation(_image,1.0);
//    }
//    
//    //    获取请求地址
//    
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *str = [formatter stringFromDate:[NSDate date]];
//    NSString *filename = [NSString stringWithFormat:@"%@.png",str];
//    
//    
//    if (picCount == 0) {
//        [picButton setImage:_image forState:0];
//        imageData1 = _image_data;
//        picButton2.hidden = NO;
//        picCount ++;
//    }
//    else if (picCount == 1) {
//        [picButton2 setImage:_image forState:0];
//        imageData2 = _image_data;
//        picButton3.hidden = NO;
//        picCount ++;
//    }
//    else if (picCount == 2) {
//        [picButton3 setImage:_image forState:0];
//        imageData3 = _image_data;
//        picCount ++;
//    }
//    [self dismissViewControllerAnimated:NO completion:nil];
//    
//    
//    
//    
//}

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

#pragma mark - UIImagePickcerControllerDelegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.selectedBtnposition != 0) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        if (self.selectedBtnposition == 1) {
            self.firstImageView.image = image;
        }
        if (self.selectedBtnposition == 2) {
            self.secondImageView.image = image;
        }
        if (self.selectedBtnposition == 3) {
            self.thirdImageView.image = image;
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


 




@end
