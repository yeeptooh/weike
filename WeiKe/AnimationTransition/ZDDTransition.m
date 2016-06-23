//
//  ZDDTransition.m
//  WeiKe
//
//  Created by 张冬冬 on 16/5/13.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "ZDDTransition.h"

@interface ZDDTransition ()
@property (nonatomic, assign) ZDDTransitionType type;
@property (nonatomic, assign) NSTimeInterval duration;

@end
@implementation ZDDTransition

+ (instancetype)transitionWithType:(ZDDTransitionType)type duration:(NSTimeInterval)duration {
    
    ZDDTransition *zddTranstion = [[ZDDTransition alloc]init];
    
    zddTranstion.type = type;
    zddTranstion.duration = duration;
    
    
    return zddTranstion;
}



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.type) {
        case ZDDTransitionTypePresent:
            [self present:transitionContext];
            break;
        case ZDDTransitionTypeDissmiss:
            [self dismiss:transitionContext];
            break;
        default:
            break;
    }
 
}

- (void)present:(id<UIViewControllerContextTransitioning>)transtionContext {
    
    
    
    UIViewController *fromVC = [transtionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transtionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transtionContext containerView];
    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    UIView *dimmingView = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    dimmingView.layer.opacity = 0.0f;
    dimmingView.backgroundColor = color(20, 20, 20, 1);
    
    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;
    
    // 要实现转场，必须加入到containerView中
    [containerView addSubview:tempView];
//    [containerView addSubview:fromVC.view];
    [containerView addSubview:dimmingView];
    [containerView addSubview:toVC.view];
    
    // 我们要设置外部所传参数
    // 设置呈现的高度
    toVC.view.frame = CGRectMake(0,
                                 0,
                                 Width - 100,
                                 Height/5);
    toVC.view.center = CGPointMake(Width/2, -(Height/10));
    
    // 开始动画
//    __weak __typeof(self) weakSelf = self;
    //  [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:0 animations:^{
    //    // 在Y方向移动指定的高度
    //    toVC.view.transform = CGAffineTransformMakeTranslation(0, -weakSelf.presentHeight);
    //
    //    // 让截图缩放
    //    tempView.transform = CGAffineTransformMakeScale(weakSelf.scale.x, weakSelf.scale.y);
    //  } completion:^(BOOL finished) {
    //    if (finished) {
    //      [transitonContext completeTransition:YES];
    //    }
    //  }];
    
    [UIView animateWithDuration:self.duration animations:^{
        // 在Y方向移动指定的高度
        toVC.view.transform = CGAffineTransformMakeTranslation(0, toVC.view.bounds.size.height + 100);
        
        // 让截图缩放
        [UIView animateWithDuration:self.duration animations:^{
            dimmingView.layer.opacity = 0.6;
        }];
        
        
    } completion:^(BOOL finished) {
        if (finished) {
            [transtionContext completeTransition:YES];
        }
    }];
    
    
    
    
    
    
    
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transtionContext {
    
    
    
    UIViewController *fromVC = [transtionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transtionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transtionContext containerView];
    
    // 取出present时的截图用于动画
    UIView *tempView = containerView.subviews[0];
    UIView *dimmingView = containerView.subviews[1];
    // 开始动画
    [UIView animateWithDuration:self.duration animations:^{
//        tempView.transform = CGAffineTransformIdentity;
        dimmingView.layer.opacity = 0;
        fromVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [transtionContext completeTransition:YES];
            toVC.view.hidden = NO;
//
//            // 将截图去掉
            [tempView removeFromSuperview];
        }
    }];
    
    
    
    
}


@end
