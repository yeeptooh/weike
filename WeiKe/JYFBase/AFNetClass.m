//
//  AFNetClass.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/30.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "AFNetClass.h"
#import "AFNetWorking.h"
#import "MyProgressView.h"


@implementation AFNetClass

#pragma mark - 初始化

+ (instancetype)initializeWithCus:(void(^)(AFNetClass *))afNetBlock {
    AFNetClass *af = [AFNetClass new];
    if (afNetBlock) {
        afNetBlock(af);
    }
    return af;
}

#pragma mark - 登录请求 -
+ (void)LoginRequestWithParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock
{
//    [MyProgressView showWith:@"Loading..."];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", NULL];
    manager.requestSerializer.timeoutInterval = 10;
    NSString *postString = [NSString stringWithFormat:@"%@/Passport.ashx",HomeUrl];
    
    [manager POST:postString parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"接口 请求成功：%@",responseObject);
        if (returnBlock) {
            returnBlock(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"接口请求失败：\n error = %@", error);
        [MyProgressView dissmissWithError:@"网络错误"];
    }];
}

#pragma mark - AFNetWorking封装(GET) -
+ (void)AFNetworkingRequestWithURL:(NSString *)url andParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock
{
//    [MyProgressView showWith:@"Loading..."];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", NULL];
    
    [manager GET:url parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"接口 请求成功：%@",responseObject);
        if (returnBlock) {
            returnBlock(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"接口请求失败： error = %@", error);
        [MyProgressView dissmissWithError:@"网络错误"];
    }];
}

#pragma mark - AFNetWorking封装(POST) -
+ (void)POST_AFNetworkingRequestWithURL:(NSString *)url andParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock
{
//    [MyProgressView showWith:@"Loading..."];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", NULL];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"接口 请求成功：%@",responseObject);
        if (returnBlock) {
            returnBlock(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"接口请求失败： error = %@", error);
        [MyProgressView dissmissWithError:@"网络错误"];
    }];
}


@end
