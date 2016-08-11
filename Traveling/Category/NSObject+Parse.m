//
//  NSObject+Parse.m
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+(id)parseJSON:(id)json
{
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [self modelWithJSON:json];
        
    }else if ([json isKindOfClass:[NSArray class]]){
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    return json;
    
}
/**
 *  重写 description
 *
 *  能把数组里面的值打印出来,方便调试
 */
-(NSString *)description
{
    return [self modelDescription];
}

@end
