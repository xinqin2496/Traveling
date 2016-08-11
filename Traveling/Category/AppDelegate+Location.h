//
//  AppDelegate+Location.h
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AppDelegate.h"

@import CoreLocation;

@interface AppDelegate (Location)<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
//开启定位服务
-(void)setupLocation;
@end
