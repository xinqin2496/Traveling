//
//  ImageViewScale.m
//  图片缩放
//
//  Created by 郑文青 on 16/5/16.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "ImageViewScale.h"

#define kWindowW [UIScreen mainScreen].bounds.size.width
#define kWindowH [UIScreen mainScreen].bounds.size.height

#define kDuration 0.5   //---设置动画时间

@interface ImageViewScale()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    //---用于按屏幕比例缩放图像
    UIView* container_View;
    //---利用 Scrollview 的缩放功能来缩放图像
    UIScrollView *container_ScrollView;
    //---保存放大前原始图片在 window 上的坐标和大小
    CGRect originImageRect;
    
    //---保存缩放的图像
    UIView *snapShotView;
}
@end

@implementation ImageViewScale

- (void)showImage:(UIImageView *)defaultImageView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //---获取当前的显示的 image
    UIImage *image = defaultImageView.image;
    //---将 imageview 的坐标转换到屏幕上的坐标位置，
    originImageRect = [defaultImageView convertRect:defaultImageView.bounds toView:window];
    
    //---添加容器 container_ScrollView
    container_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    container_ScrollView.delegate=self;
    //---设置最大伸缩比例
    container_ScrollView.multipleTouchEnabled = YES;
    container_ScrollView.maximumZoomScale=3.0;
    
    //---添加容器 container_View，用于缩放
    //---若是直接缩放图像，若是图片的大小比例不是屏幕的大小，缩放的时候会有位移偏差
    container_View = [UIView new];
    container_View.frame = container_ScrollView.frame;
    container_View.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //---截图大法，用于缩放
    snapShotView = [defaultImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = originImageRect;
    
    //---加载到屏幕上
    [container_View addSubview:snapShotView];
    [container_ScrollView addSubview:container_View];
    [window addSubview:container_ScrollView];
    
    //---添加全局手势 点击缩小回原位
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [container_ScrollView addGestureRecognizer:tap];
    
    //---设置图片开始是透明的
    //    defaultImageView.alpha = 0;
    
    container_ScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //---移动到屏幕中央
    CGFloat rate = kWindowW / image.size.width;
    CGRect finalRect = CGRectMake(0,
                                  ( kWindowH - image.size.height * rate )/2,
                                  kWindowW,
                                  image.size.height * rate );
    
    //---动画显示
    [UIView animateWithDuration:kDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        snapShotView.frame = finalRect;
        container_ScrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
    }
                     completion:^(BOOL finished)
     {
         //---隐藏状态栏
         //         [UIApplication.sharedApplication setStatusBarHidden:true withAnimation:UIStatusBarAnimationSlide];
     }];
    
}

- (void)hideImage:(UITapGestureRecognizer*)tap
{
    //        UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    //    [UIApplication.sharedApplication setStatusBarHidden:false withAnimation:UIStatusBarAnimationNone];
    
    
    [UIView animateWithDuration:kDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //---缩放到原始大小时，必须同时缩放到原始的倍率，否则放大的情况位置偏移
        container_ScrollView.zoomScale = 1.0f;
        
        snapShotView.frame = originImageRect;
        container_ScrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    } completion:^(BOOL finished) {
        //       imageView.alpha = 1;
        [container_ScrollView removeFromSuperview];
    }];
}

#pragma mark - UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //---缩放容器container_View
    return container_View;
}

@end
