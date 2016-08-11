//
//  WineshopViewController.m
//  Traveling
//
//  Created by 郑文青 on 16/7/14.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "WineshopViewController.h"

@interface WineshopViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WineshopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes =  UIDataDetectorTypeAll;
    
    //解决网址中带有中文字符
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedString = [self.backURLStr stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
