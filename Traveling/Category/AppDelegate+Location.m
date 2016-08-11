//
//  AppDelegate+Location.m
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AppDelegate+Location.h"
//使用runtime 来让分类也能添加属性
#import <objc/runtime.h>

@implementation AppDelegate (Location)

//必须把属性的 set 方法 写了
-(void)setLocationManager:(CLLocationManager *)locationManager
{
    //@selector(locationManager) -> 本质就是个指针的地址
    //绑定了指针地址和 locationManager 变量
    return objc_setAssociatedObject(self, @selector(locationManager), locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get 方法 写了
-(CLLocationManager *)locationManager
{
    //_cmd 当前方法的指针
    return objc_getAssociatedObject(self, _cmd);
}


-(void)setupLocation
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    //ios8 新特点
    //respondsToSelector: 返回值是bool ,真就代表有这个方法 不写 7版本就会崩溃
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }

    //开启定位服务: 注意ios8 之后的特点
    [self.locationManager startUpdatingLocation];
    
    //设置初始城市  放到子线程 性能优化
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!kCurrentCity) {
            [[NSUserDefaults  standardUserDefaults]setObject:@"上海" forKey:kCurrentCityName];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //回主线程发通知
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter]postNotificationName:kCurrentCitychangedNotification object:nil];
            });
        }
    });

}
#pragma mark CLLocationManager  Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.firstObject;
    NSLog(@"坐标:%@",location);
    if (location) {
        //加这一句就只会弹出一次对话框
        manager.delegate = nil;
        //如果有值 就停止定位
        [manager stopUpdatingLocation];
        
        //反地理编码
        [[CLGeocoder new]reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks.firstObject;
            //反编码得到的城市名
            NSString *localCity = placemark.locality;
            NSLog(@"反编码得到的城市名:%@",localCity);
            //把城市中的"市"替换成空字符串
            localCity = [localCity stringByReplacingOccurrencesOfString:@"市" withString:@""];
            
            if (![kCurrentCity isEqualToString:localCity]) {
                if(localCity.length == 0){
                    localCity = kCurrentCity;
                   
                }
                //BlocksKit 第三方的优化 弹出警告对话框
                NSString *message = [NSString stringWithFormat:@"当前城市发生变化,是否要切换到'%@'?",localCity];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换城市" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //1.保存新的城市名称 到userDefaults
                    [[NSUserDefaults standardUserDefaults]setObject:localCity forKey:kCurrentCityName];
                    //2.同步到沙盒
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    //3.发送城市变更通知
                    [[NSNotificationCenter defaultCenter]postNotificationName:kCurrentCitychangedNotification object:nil];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [alert addAction:cancel];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];

              
            }
        }];
    }
    
}

@end
