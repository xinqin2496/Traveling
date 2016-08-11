//
//  RootViewController.m
//  Traveling
//
//  Created by 郑文青 on 16/7/1.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "RootViewController.h"
#import "MineViewController.h"
#import "MainViewController.h"
@interface RootViewController ()<RESideMenuDelegate>

@end

@implementation RootViewController

- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = NO;//内容的阴影
    self.scaleContentView = NO;//设置平滑不缩放效果
    self.contentViewInPortraitOffsetCenterX = 100;//设置内容视图侧滑的比例
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MineViewController"];
 
    self.backgroundImage = [UIImage imageNamed:@"login_background"];
    self.delegate = self;
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
   // NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
   // NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
   // NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
