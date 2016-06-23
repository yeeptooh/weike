//
//  ErWeiMaViewController.h
//  天润
//
//  Created by Ji_YuFeng on 15/4/25.
//  Copyright (c) 2015年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ErWeiMaViewController : UIViewController
<
AVCaptureMetadataOutputObjectsDelegate
>

{
    NSInteger num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic, assign)int theTag;
@end
