//
//  SurroundViewModel.h
//  Traveling
//
//  Created by 郑文青 on 16/7/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurroundModel.h"
@interface SurroundViewModel : NSObject
@property (nonatomic,assign)NSInteger rowNumber;
-(NSURL *)imageURLForIndex:(NSInteger)index;//图片
-(NSString *)spotNameForIndex:(NSInteger)index;//名称
-(NSString *)ticketTitleForIndex:(NSInteger)index;//票价类型
-(NSString *)starGradeForIndex:(NSInteger)index;//星级
-(NSString *)priceForIndex:(NSInteger)index;//折扣的价格
-(NSString *)normalPriceForIndex:(NSInteger)index;//原价
-(NSString *)provinceCityForIndex:(NSInteger)index;//城市
-(NSString *)descriptionForIndex:(NSInteger)index;//描述
-(NSURL *)detailUrlForIndex:(NSInteger)index;//详细网页
@property (nonatomic,strong)NSMutableArray<Ticket *> *surrountList;
@property (nonatomic,assign)NSInteger pageNum;
-(void)getSurroundRequestModel:(RequestMode)requestModel completionHandler:(void(^)(NSError *error))completionHandler;
@end
