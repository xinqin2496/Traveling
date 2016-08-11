//
//  UIView+RoundExtension.m
//  20160224_大练习
//
//  Created by zhengwenqing’s mac on 16/2/25.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "UIView+RoundExtension.h"

@implementation UIView (RoundExtension)

-(void)setRoundRectLayerCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

-(void)setRoundBorderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    // 断言 如果为真 继续执行 如果为假 程序在这里崩掉
    assert(self.frame.size.width == self.frame.size.height);
    [self setRoundRectLayerCornerRadius:self.frame.size.width / 2 borderWidth:width borderColor:color];
}
@end
