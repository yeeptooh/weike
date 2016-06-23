//
//  LGImagePickerSelectView.m
//  LGPhotoBrowser
//
//  Created by ligang on 15/10/27.
//  Copyright (c) 2015年 L&G. All rights reserved.

#import "LGImagePickerSelectView.h"
#import "LGPhotoPickerCommon.h"

@implementation LGImagePickerSelectView

- (id)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView setAlpha:0.8];
        [self addSubview:bgView];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn setFrame:CGRectMake(0, 20, 60, 40)];
        [self.backBtn setImage:[UIImage imageNamed:@"navigationbar_back_light"] forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backBtn setTitleColor:color(150, 150, 150, 1) forState:UIControlStateHighlighted];
//        [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 25, 24)];
//        [self.backBtn setImage:GetImage(@"navigationbar_back_light") forState:UIControlStateNormal];
        [self addSubview:self.backBtn];
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setFrame:CGRectMake(SCREEN_WIDTH - 40 - 15, 22, 40, 40)];
        [self.selectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 8, 0)];
        [self.selectBtn setImage:GetImage(@"checkbox_pic_non.png") forState:UIControlStateNormal];
        [self.selectBtn setImage:GetImage(@"checkbox_pic.png") forState:UIControlStateSelected];
        [self addSubview:self.selectBtn];
    }
    return self;
}

- (void)addTarget:(id)target backAction:(SEL)backAction selectAction:(SEL)selectAction forControlEvents:(UIControlEvents)controlEvents{
    [self.backBtn addTarget:target action:backAction forControlEvents:controlEvents];
    [self.selectBtn addTarget:target action:selectAction forControlEvents:controlEvents];
}


@end
