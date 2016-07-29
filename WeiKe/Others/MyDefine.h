//
//  MyDefine.h
//  天气
//
//  Created by apple1 on 16/1/13.
//  Copyright © 2016年 apple1. All rights reserved.
//

#ifndef MyDefine_h
#define MyDefine_h
//机器唯一标识
#define  UUID                              [[UIDevice currentDevice].identifierForVendor UUIDString]

//系统版本
#define iOSVerson                         [[UIDevice currentDevice] systemVersion].floatValue


// 宽度
#define  Width                             [UIScreen mainScreen].bounds.size.width

// 高度
#define  Height                            [UIScreen mainScreen].bounds.size.height

// 状态栏高度
#define  StatusBarHeight                   20.f

// 导航栏高度
#define  NavigationBarHeight               44.f

// 标签栏高度
#define  TabbarHeight                      49.f

// 状态栏高度 + 导航栏高度
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)
#define  SearchBarHeight                   44.f


#define  iPhone4_4s   (Width == 320.f && Height == 480.f ? YES : NO)
#define  iPhone5_5s   (Width == 320.f && Height == 568.f ? YES : NO)
#define  iPhone6      (Width == 375.f && Height == 667.f ? YES : NO)
#define  iPhone6_plus (Width == 414.f && Height == 736.f ? YES : NO)


#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define font(str) [UIFont systemFontOfSize:(str)]

#define HomeUrl @"http://www.vk90.com/forapp"
//#define HomeUrl @"http://192.168.1.228:89/forapp"
//缩放比例尺
#define scaleScreen  Width / 414.0f
#define BlueColor color(59, 165, 249, 1)
#define MainBlueColor color(9, 152, 205, 1)

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif





#endif /* MyDefine_h */
