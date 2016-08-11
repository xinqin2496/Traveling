//
//  SurroundViewController.m
//  Traveling
//
//  Created by 郑文青 on 16/7/11.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "SurroundViewController.h"
#import "TicketViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
#import "WineshopViewController.h"
@interface SurroundViewController () <NinaPagerViewDelegate>



@end

@implementation SurroundViewController
#pragma mark 懒加载


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *titleArray = @[
                            @"上海一日游",
                            @"必游景点",
                            @"游乐场",
                            @"景点门票",
                            @"酒店特惠"
                              ];
//    NSArray *vcs = @[@"TicketViewController",
//                     @"WebViewController",
//                     @"TicketViewController"
//                     ];
    NSArray *URLArray = @[
                          @"http://touch.piao.qunar.com/touch/list_上海_一日游.html?region=上海&limitCondition=oneDayTour&cat=from_area%253Dts_type_nav%2526from_index%253D3%2526from_value%253D%2525E4%2525B8%252580%2525E6%252597%2525A5%2525E6%2525B8%2525B8%2526dist_city%253D%2525E4%2525B8%25258A%2525E6%2525B5%2525B7&pageSize=20",
                          @"http://touch.piao.qunar.com/touch/list_上海_必游景点.html?region=上海&cat=from_area%253Dts_type_nav%2526from_index%253D2%2526from_value%253D%2525E5%2525BF%252585%2525E6%2525B8%2525B8%2525E6%2525A6%25259C%2525E5%25258D%252595%2526dist_city%253D%2525E4%2525B8%25258A%2525E6%2525B5%2525B7&lat=31.208622&lng=121.460522&isForeign=false&pageSize=20",
                          @"http://touch.piao.qunar.com/touch/list_上海_游乐场.html?region=上海&cat=from_area%253Dts_type_nav%2526from_index%253D5%2526from_value%253D%2525E6%2525B8%2525B8%2525E4%2525B9%252590%2525E5%25259C%2525BA%2526dist_city%253D%2525E4%2525B8%25258A%2525E6%2525B5%2525B7&lat=31.208622&lng=121.460522&isForeign=false&pageSize=20",
                          @"http://touch.piao.qunar.com/touch/list_上海_景点门票.html?region=上海&cat=from_area%253Dts_type_nav%2526from_index%253D0%2526from_value%253D%2525E6%252599%2525AF%2525E7%252582%2525B9%2525E9%252597%2525A8%2525E7%2525A5%2525A8%2526dist_city%253D%2525E4%2525B8%25258A%2525E6%2525B5%2525B7&lat=31.208575&lng=121.460168&isForeign=false&pageSize=20",
                          @"http://touch.qunar.com/h5/hotel/hotellist?isLM=1&city=上海&cityUrl=shanghai_city&location=gg%7C31.206617852420926%7C121.46457763884543"
                          ];
    NSMutableArray * detailArr = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        WineshopViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WineshopViewController"];
        webVC.backURLStr = URLArray[i];
    
        [detailArr addObject:webVC];
    }

    NSArray * colorArr = @[kRGBColor(253, 0, 255, 1.0),//标题选中颜色
                           kRGBColor(157, 157, 157, 1.0),//标题未选中颜色
                           kRGBColor(253, 0, 255, 1.0),//下划线颜色
                           [UIColor whiteColor],];//背景颜色
    NinaPagerView * pagerView = [[NinaPagerView alloc]initWithTitles:titleArray WithVCs:detailArr WithColorArrays:colorArr];
    pagerView.delegate = self;
    [self.view addSubview:pagerView];
    pagerView.pushEnabled = NO;
}
- (BOOL)deallocVCsIfUnnecessary {
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
