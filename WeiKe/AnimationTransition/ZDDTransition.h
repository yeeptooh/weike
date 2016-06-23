//
//  ZDDTransition.h
//  WeiKe
//
//  Created by 张冬冬 on 16/5/13.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZDDTransitionType) {
    ZDDTransitionTypePresent,
    ZDDTransitionTypeDissmiss
};
@interface ZDDTransition : NSObject
<
UIViewControllerAnimatedTransitioning
>


+ (instancetype)transitionWithType:(ZDDTransitionType)type duration:(NSTimeInterval)duration;




@end
