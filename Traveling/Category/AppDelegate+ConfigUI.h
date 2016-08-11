//
//  AppDelegate+ConfigUI.h
//  project
//
//  Created by 郑文青 on 16/6/23.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ConfigUI)
//设置版本号对比
-(void)setTargetBuildVersion;
//设置界面颜色
-(void)setConfigUI;

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig;
@end
