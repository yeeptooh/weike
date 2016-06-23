//
//  AFNetClass.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/30.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnBlock)(NSDictionary *response, NSError *error);
typedef void(^ErrorBlock)();

@interface AFNetClass : NSObject

#pragma mark - 登录请求 -
+ (void)LoginRequestWithParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock;

#pragma mark - AFNetWorking(GET) -
+ (void)AFNetworkingRequestWithURL:(NSString *)url andParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock;

#pragma mark - AFNetWorking封装(POST) -
+ (void)POST_AFNetworkingRequestWithURL:(NSString *)url andParmas:(NSDictionary *)parmas withReturnBlock:(ReturnBlock)returnBlock;

@end





