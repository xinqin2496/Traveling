//
//  SurroundViewModel.m
//  Traveling
//
//  Created by 郑文青 on 16/7/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "SurroundViewModel.h"

@implementation SurroundViewModel
-(NSInteger)rowNumber
{
    return self.surrountList.count;
}
-(NSURL *)imageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.surrountList[index].imageUrl];
}
-(NSString *)spotNameForIndex:(NSInteger)index
{
    return self.surrountList[index].spotName;
}
-(NSString *)ticketTitleForIndex:(NSInteger)index
{
    return self.surrountList[index].priceList.ticketTitle;
}
-(NSString *)descriptionForIndex:(NSInteger)index
{
    return self.surrountList[index].desc;
}
-(NSString *)starGradeForIndex:(NSInteger)index
{
    return self.surrountList[index].starGrade;
}
-(NSString *)priceForIndex:(NSInteger)index
{
   
    return  self.surrountList[index].priceList.price;
   
}
-(NSString *)normalPriceForIndex:(NSInteger)index
{
    return self.surrountList[index].priceList.normalPrice;
}
-(NSString *)provinceCityForIndex:(NSInteger)index
{
    NSString *cityStr = self.surrountList[index].address;
    NSArray *cityArr = [cityStr componentsSeparatedByString:@"市"];
    
    return [NSString stringWithFormat:@"%@市",cityArr[0]] ;
}
-(NSURL *)detailUrlForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.surrountList[index].detailUrl];
}
-(NSMutableArray<Ticket *> *)surrountList
{
    if (!_surrountList) {
        _surrountList = [NSMutableArray array];
    }
    return _surrountList;
}

-(void)getSurroundRequestModel:(RequestMode)requestModel completionHandler:(void (^)(NSError *))completionHandler
{
    NSInteger tmpPage = 1;
    if (requestModel == RequestModeMore) {
        tmpPage = _pageNum + 1;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [DataManager requestPageno:tmpPage CompletionHandler:^(Ticket *model, NSError *error) {
        if (!error) {
            _pageNum = tmpPage;
            if (requestModel == RequestModeRefresh) {
                [self.surrountList removeAllObjects];
            }
            
            [arr addObject:model];
        }
        self.surrountList = [NSMutableArray arrayWithArray:arr];
        completionHandler(error);
        
//        NSLog(@"surrountList:%@",self.surrountList);
    }];
   
}
@end
