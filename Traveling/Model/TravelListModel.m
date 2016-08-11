//
//  TravelListModel.m
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TravelListModel.h"

@implementation TravelListModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [TravelListDataModel class]};
}
@end
@implementation TravelListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"books" : [TravelListDataBooksModel class]};
}

@end


@implementation TravelListDataBooksModel

@end


