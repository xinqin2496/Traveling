//
//  AppDelegate+ConfigUI.m
//  project
//
//  Created by 郑文青 on 16/6/23.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "AppDelegate+ConfigUI.h"
//#import "WelcomeViewController.h"
@implementation AppDelegate (ConfigUI)
-(void)setTargetBuildVersion
{
    // 1.读取曾经保存到偏好设置中的旧版本号
//    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"Version"];
    
    // 2.读取当前打开的应用中的info.plist中的新版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 3.如果两个版本号不相等，则显示欢迎界面
//    if (![currentVersion isEqualToString:oldVersion]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        WelcomeViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
//        self.window.rootViewController = vc;
//        [self.window makeKeyAndVisible];
//        //将当前版本号记录到偏好设置中
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"Version"];
//    }
//        else
//    {

        //配置环信SDK
        //配置环信appkey
//        EMOptions *options = [EMOptions optionsWithAppkey:kEaseMobAppKey];
//        //options.apnsCertName = @"istore_dev";
//        [[EMClient sharedClient] initializeSDKWithOptions:options];
//        
        //注册登录状态监听
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(loginStateChange:)
//                                                     name:KNOTIFICATION_LOGINCHANGE
//                                                   object:nil];
        
        //设置自动登录或者是注册
//        [self autoLogin];
//    }
    
}
-(void)setConfigUI
{
    self.window.tintColor = kRGBColor(109, 231, 254, 1.0);
    //导航栏 的颜色
   [[UINavigationBar appearance]setBarTintColor:kRGBColor(109, 231, 254, 1.0)];
     //把电池栏变白
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
   
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque ];
 
    //导航栏上按钮的颜色
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    //设置 导航栏上title 字体大小
   [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]}];
    //设置TabBar 的字体大小和颜色
   [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName :[UIFont systemFontOfSize:14]
                                                       } forState:UIControlStateNormal];
    
}

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig
{
//    //配置环信appkey
//    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
//    //options.apnsCertName = @"istore_dev";
//    [[EMClient sharedClient] initializeSDKWithOptions:options];
//    
//    //注册登录状态监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loginStateChange:)
//                                                 name:KNOTIFICATION_LOGINCHANGE
//                                               object:nil];
    
  
}
//-(void)autoLogin
//{
//    BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
//    MYLog(@"是否自动登录:%d",isAutoLogin);
//    UIStoryboard *storyboard = nil;
//    if (isAutoLogin){
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
//    }
//    else
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//        storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    }
//
//    self.window.rootViewController = storyboard.instantiateInitialViewController;
//     [self.window makeKeyAndVisible];

//}

// 将得到的deviceToken传给SDK
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[EMClient sharedClient] bindDeviceToken:deviceToken];
//    });
//}
#pragma mark - login changed

- (void)loginStateChange:(NSNotification *)notification
{
    
    BOOL loginSuccess = [notification.object boolValue];
    UIStoryboard *storyboard = nil;
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      
    }
    else{//登陆失败加载登陆页面控制器
        storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
    }
//    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
    
    self.window.rootViewController = storyboard.instantiateInitialViewController;
    [self.window makeKeyAndVisible];
 
}

@end
