//
//  UIScrollView+Refresh.m
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
//添加头部刷新
-(void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}
//开始头部刷新
-(void)beginHeaderRefresh
{
    /**
     *  为了线程安全,把它放到主线程中操作
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mj_header beginRefreshing];
    });
    
}
//结束头部刷新
-(void)endHeaderRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [self.mj_header endRefreshing];
    });
   
}
//添加脚部自动刷新
-(void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
}
//添加脚部 返回刷新
-(void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:block];
}
//开始脚部刷新
-(void)beginFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mj_footer beginRefreshing];
    });
    
}
//结束脚部刷新
-(void)endFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
       [self.mj_footer endRefreshing];
    });

}

@end
