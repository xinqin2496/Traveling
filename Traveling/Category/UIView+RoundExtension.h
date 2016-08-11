//
//  UIView+RoundExtension.h
//  20160224_大练习
//
//  Created by zhengwenqing’s mac on 16/2/25.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundExtension)
//设置图片为矩型
-(void)setRoundRectLayerCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;
//设置图片为圆
-(void)setRoundBorderWidth:(CGFloat)width borderColor:(UIColor*)color;
@end
