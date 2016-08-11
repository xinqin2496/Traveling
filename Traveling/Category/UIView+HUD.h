//
//  UIView+HUD.h
//
//  Created by zhengwenqing’s mac on 16/4/2.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
/**
 *  带修改背景的文字
 *
 *  @param message  文字描述
 *  @param bgColor  背景颜色
 */
-(void)showMessage:(NSString *)message bgColor:(UIColor *)bgColor;
/**
 *  只显示文字,默认黑背白字
 *
 *  @param word 文字描述
 */
-(void)showMessage:(NSString *)message;
/**
 *  显示菊花样式
 */
-(void)showBusyHUD;
/**
 *  隐藏菊花样式
 */
-(void)hiddenBusyHUD;
/**
 *  带修改背色的菊花
 *
 *  @param bgColor 背景颜色
 */
-(void)showBusyHUDbgColor:(UIColor *)bgColor;
/**
 *  成功时带修改背景色
 *
 *  @param success 文字描述
 *  @param bgColor 背景颜色
 */
- (void)showSuccess:(NSString *)success bgColor:(UIColor*)bgColor;
/**
 *  错误时带修改背景色
 *
 *  @param success 文字描述
 *  @param bgColor 背景颜色
 */
- (void)showError:(NSString *)error bgColor:(UIColor*)bgColor;
/**
 *  成功时指定那个View显示
 *
 *  @param success 文字描述
 *  @param view    指定视图
 *  @param bgColor 背景颜色
 */
- (void)showSuccess:(NSString *)success toView:(UIView *)view bgColor:(UIColor*)bgColor;
/**
 *  错误时指定那个View显示
 *
 *  @param success 文字描述
 *  @param view    指定视图
 *  @param bgColor 背景颜色
 */
- (void)showError:(NSString *)error toView:(UIView *)view bgColor:(UIColor*)bgColor;


@end
