//
//  MyProgressView.m
//  天润
//
//  Created by t on 15/6/5.
//  Copyright (c) 2015年 Ji_YuFeng. All rights reserved.
//

#import "MyProgressView.h"

@implementation MyProgressView

 MyProgressView *progressView;
UIWindow *window;
UILabel *label;
+(void)showWith:(NSString *)str
{
    if (progressView == nil) {
        
    
    progressView = [[MyProgressView alloc]init];
    progressView.view.backgroundColor = [UIColor blackColor];
    progressView.view.alpha = 0.6;
    progressView.view.layer.cornerRadius = 10;
    window = [UIApplication sharedApplication].keyWindow;
 
    progressView.quan.center = CGPointMake(progressView.view.frame.size.width/2, progressView.view.frame.size.height/2-15);
    [progressView.quan startAnimating];
    label = [[UILabel alloc]initWithFrame:CGRectMake((progressView.view.frame.size.width-80)/2, progressView.view.frame.size.height-35, 80, 30)];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [progressView.view addSubview:label];
    

    [window addSubview:progressView.view];
    [progressView.view addSubview:progressView.quan];
    }

}



-(UIView *)view
{
    if (_view == nil) {
        _view = [[UIView alloc]initWithFrame:CGRectMake((Width-100)/2, Height/2-80/2, 100, 80)];
        
        return _view;
    }
    return _view;
}


-(UIActivityIndicatorView *)quan{
    if (_quan == nil) {
        _quan = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        return _quan;
    }
    return _quan;
}

+(void)dissmiss
{

    [UIView animateWithDuration:0.2 animations:^{
        progressView.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [progressView.view removeFromSuperview];
        [progressView.quan stopAnimating];
        [progressView.quan removeFromSuperview];
        progressView.view =nil;
        progressView = nil;
        progressView.quan =nil;
    }];
   
    
    
    
}


+(void)dissmissWithError:(NSString *)str
{
    
    [progressView.quan stopAnimating];
    [progressView.quan removeFromSuperview];
    label.frame = CGRectMake((progressView.view.frame.size.width-80)/2, progressView.view.frame.size.height/2-60/2, 80, 60);
    label.text = str;
    label.numberOfLines = 0;
    [UIView animateWithDuration:0.2 delay:1.5 options:0 animations:^{
        progressView.view.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        [progressView.view removeFromSuperview];
        [progressView.quan stopAnimating];
        [progressView.quan removeFromSuperview];
        progressView.view =nil;
        progressView = nil;
        progressView.quan =nil;
    }];
    
}


@end
