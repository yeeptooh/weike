//
//  UserModel.h
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/3.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
<
NSCoding
>
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger CompanyID;

+(UserModel *)readUserModel;
+(void)writeUserModel:(UserModel *)usermodel;

@end
