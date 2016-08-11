//
//  Constants.h
//  Traveling
//
//  Created by 郑文青 on 16/6/29.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef NS_ENUM(NSUInteger, RequestMode)
{
    RequestModeRefresh,//刷新数据
    RequestModeMore,//获取更多
};
#define kApikey @"9ab01948f3e9cc3481077fe1d2d69fa3"   //这是您在APIStore调用服务所需要的API密钥


//固定格式, 为了解决block 中 self 报黄的问题
#define   WK(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/** RGB 颜色宏    */

#define kRGBColor(R,G,B,Alpha) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:Alpha]

#define kBgColor kRGBColor(109, 231, 254, 1.0) //#6DE7FE
/**   屏幕宽  */
#define  kScreenW [UIScreen mainScreen].bounds.size.width

/**   屏幕高   */
#define kScreenH [UIScreen mainScreen].bounds.size.height

/** 存储当前选中的城市   */

#define kCurrentCityName @"kCurrentCityName"

/** 当前城市 */
#define kCurrentCity [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentCityName]

/** 当前城市变化的通知  */
#define kCurrentCitychangedNotification @"kCurrentCitychangedNotification"

//debug调试用宏
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif
