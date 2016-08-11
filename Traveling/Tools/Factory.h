//
//  Factory.h
//  BaseProject
//
//  Created by apple-jd09 on 15/11/25.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
/** 向某个控制器上，添加菜单按钮 */
+ (void)addMenuItemToVC:(UIViewController *)vc;

/** 向某个控制器上，添加返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;
/** 右上角添加搜索按钮 */
+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)())clickHandler;

+ (BOOL)isPhoneNumber:(NSString *)phoneNum;
/** 加密 */
+ (NSString *)md5:(NSString *)str;

@end
