//
//  UIView+HUD.m
//
//  Created by zhengwenqing’s mac on 16/4/2.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"
#define kAfterDelayTimeDuration 1.5

#define kTimeoutDuration 20

@implementation UIView (HUD)
-(void)showMessage:(NSString *)message bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.color = bgColor;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        
        [hud hide:YES afterDelay:kAfterDelayTimeDuration];
    });
    
 
}
-(void)showMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self animated:YES];
    
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        
        [hud hide:YES afterDelay:kAfterDelayTimeDuration];
    });
    
    
}
-(void)showBusyHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        
        [[MBProgressHUD showHUDAddedTo:self animated:YES]hide:YES afterDelay:kTimeoutDuration];
        
    });
}
-(void)hiddenBusyHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    });
}
-(void)showBusyHUDbgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
        hud.color = bgColor;
        [self addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:kTimeoutDuration];
    });
   
    
}

#pragma mark 显示信息
- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view color:(UIColor*)color
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    /********** 自己添加 ************************************/
    hud.color = color;
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}
-(void)showSuccess:(NSString *)success bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:success icon:@"success.png" view:nil color:bgColor];
    });
}
-(void)showError:(NSString *)error bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:error icon:@"error.png" view:nil color:bgColor];
    });
}
-(void)showSuccess:(NSString *)success toView:(UIView *)view bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:success icon:@"success.png" view:view color:bgColor];
    });
}
-(void)showError:(NSString *)error toView:(UIView *)view bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:error icon:@"error.png" view:view color:bgColor];
    });
}






@end
