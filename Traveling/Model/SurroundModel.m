//
//  SurroundModel.m
//  Traveling
//
//  Created by 郑文青 on 16/7/11.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "SurroundModel.h"

@implementation SurroundModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"retData" : [Retdata class]};
}
@end
@implementation Retdata
+ (NSDictionary *)modelCustomPropertyMapper
{
    //返回一个 Dict，将 Model @"属性名"对映射到 JSON 的 @"Key"。
    return @{
             @"ID":@"id",
           
             
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ticketDetail" : [Ticketdetail class]};
}
@end


@implementation Ticketdetail
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [Data class]};
}
@end


@implementation Data
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"display" : [Display class]};
}
@end


@implementation Display
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ticket" : [Ticket class]};
}
@end


@implementation Ticket
+ (NSDictionary *)modelCustomPropertyMapper
{
    //返回一个 Dict，将 Model @"属性名"对映射到 JSON 的 @"Key"。
    return @{
             @"desc":@"description",
             
             
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"priceList" : [Pricelist class]};
}
@end


@implementation Pricelist

@end


