//
//  UserModel.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/12/3.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "UserModel.h"
@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.Name forKey:@"Name"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.ID] forKey:@"ID"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.CompanyID] forKey:@"CompanyID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
   
    self = [super init];
    if (self) {
        self.UserName = [aDecoder decodeObjectForKey:@"UserName"];
        self.Name = [aDecoder decodeObjectForKey:@"Name"];
        self.ID = [[aDecoder decodeObjectForKey:@"ID"]integerValue];
        self.CompanyID = [[aDecoder decodeObjectForKey:@"CompanyID"]integerValue];
    }
    return self;
}



+ (void)writeUserModel:(UserModel *)model{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    
//    NSString *path = [NSString stringWithFormat:@"%@/Documents/userModel.data",NSHomeDirectory()];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userModel.data"];
    
    [data writeToFile:filePath atomically:YES];
}

+ (UserModel *)readUserModel{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/userModel.data",NSHomeDirectory()];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return model;
}



@end
