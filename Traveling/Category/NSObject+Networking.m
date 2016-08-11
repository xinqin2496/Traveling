//
//  NSObject+Networking.m
//  HappyBuy
//
//  Created by zhengwenqing’s mac on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "NSObject+Networking.h"

#define kRequestTimeoutInterval 30

@implementation NSObject (Networking)

+(id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //让AFN 接受除了JSON 以外的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    
    //修改网络请求超时的时间 把默认60秒 改成30秒
    manager.requestSerializer.timeoutInterval = kRequestTimeoutInterval;
    
   return  [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
       completionHandler(responseObject,nil);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completionHandler(nil,error);
    }];
    
}
+(id)POST:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //让AFN 接受除了JSON 以外的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    
    //修改网络请求超时的时间 把默认60秒 改成30秒
    manager.requestSerializer.timeoutInterval = kRequestTimeoutInterval;
    
    return  [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionHandler(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completionHandler(nil,error);
    }];

}
@end
