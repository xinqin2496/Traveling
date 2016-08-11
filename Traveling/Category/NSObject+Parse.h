//
//  NSObject+Parse.h
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>

@interface NSObject (Parse)

/**
 *  封装判断 JSON 是字典类型还是数组类型
 *
 */
+(id)parseJSON:(id)json;

@end
