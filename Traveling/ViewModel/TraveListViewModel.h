//
//  TraveListViewModel.h
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelListModel.h"
//typedef NS_ENUM(NSUInteger, RequestMode)
//{
//    RequestModeRefresh,//刷新数据
//    RequestModeMore,//获取更多
//};
@interface TraveListViewModel : NSObject
/** 有多少个 */
@property (nonatomic,assign)NSInteger rowNumber;
-(NSURL *)scenicImageUrlForIndex:(NSInteger)index;//图片
-(NSString *)titleForIndex:(NSInteger)index;
-(NSString *)linePlanningForIndex:(NSInteger)index;//线路规划
-(NSURL *)userHeadeImageForIndex:(NSInteger)index;//用户头像
-(NSString *)starTimeForIndex:(NSInteger)index;//开始日期
-(NSString *)routeDaysForIndex:(NSInteger)index;//几天行程
-(NSInteger)likeCountForIndex:(NSInteger)index;//热爱数
-(NSURL *)bookUrlForIndex:(NSInteger)index;//详情

/** 属性 */
@property (nonatomic,strong)NSMutableArray<TravelListDataBooksModel *> *dataList;

/** 有几页 */
@property (nonatomic,assign)NSInteger pageNum;

-(void)getScenicRequestModel:(RequestMode)requestModel completionHandler:(void(^)(NSError *error))completionHandler;
@end
