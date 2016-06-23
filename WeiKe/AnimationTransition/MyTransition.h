//
//  MyTransition.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/16.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, MyTransitionType) {
    MyTransitionTypePresent,
    MyTransitionTypeDissmiss
};
@interface MyTransition : NSObject
<
UIViewControllerAnimatedTransitioning
>


+ (instancetype)transitionWithType:(MyTransitionType)type duration:(NSTimeInterval)duration;
@end
