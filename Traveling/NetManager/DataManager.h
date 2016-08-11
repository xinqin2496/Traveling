//
//  DataManager.h
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelListModel.h"
#import "SurroundModel.h"

@interface DataManager : NSObject
//获取景点门票信息的ID
//+(void)requestPageno:(NSInteger )pageno CompletionHandler:(void (^)(NSArray *productid,NSError *error))completionHandler;
//获取周边景点门票信息
+(void)requestPageno:(NSInteger )pageno CompletionHandler:(void (^)(Ticket *model,NSError *error))completionHandler;
//获取景点门票信息
//+(void)getDataAttractionsProductID:(NSString *)productID CompletionHandler:(void(^)(Ticket *model,NSError *error))completionHandler;
//获取首页景点游记列表
+(void)getScenicspotsPagesize:(NSInteger)pagesize CompletionHandler:(void(^)(TravelListDataModel *model,NSError *error))completionHandler;
@end
