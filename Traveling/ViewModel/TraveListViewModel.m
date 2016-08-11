//
//  TraveListViewModel.m
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TraveListViewModel.h"

@implementation TraveListViewModel
-(NSInteger)rowNumber
{
    return self.dataList.count;
}
-(NSURL *)scenicImageUrlForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.dataList[index].headImage];
}
-(NSString *)titleForIndex:(NSInteger)index
{
    return self.dataList[index].title;
}
-(NSString *)linePlanningForIndex:(NSInteger)index
{
    return  [NSString stringWithFormat:@"线路规划:%@",self.dataList[index].text];
}
-(NSURL *)userHeadeImageForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.dataList[index].userHeadImg];
}
-(NSString *)starTimeForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@出发",self.dataList[index].startTime];
}
-(NSString *)routeDaysForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"共%ld天",self.dataList[index].routeDays];
}
-(NSInteger)likeCountForIndex:(NSInteger)index
{
    return self.dataList[index].likeCount;
}
-(NSURL *)bookUrlForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.dataList[index].bookUrl];
}
-(NSMutableArray<TravelListDataBooksModel *> *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(void)getScenicRequestModel:(RequestMode)requestModel completionHandler:(void (^)(NSError *))completionHandler
{
    NSInteger tmpPage = 1;
    if (requestModel == RequestModeMore) {
        tmpPage = _pageNum + 1;
    }
    [DataManager getScenicspotsPagesize:tmpPage CompletionHandler:^(TravelListDataModel *model, NSError *error) {
        if (!error) {
            _pageNum = tmpPage;
            if (requestModel == RequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            
            [self.dataList addObjectsFromArray:model.books];
        }
        completionHandler(error);
    }];
}






@end
