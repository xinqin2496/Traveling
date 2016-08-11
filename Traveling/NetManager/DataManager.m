//
//  DataManager.m
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

//+(void)getDataAttractionsProductID:(NSString *)productID CompletionHandler:(void (^)(Ticket *, NSError *))completionHandler
//{
//
//        NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querydetail";
//        NSString *httpArg = [NSString stringWithFormat:@"id=%@",productID];
//
//        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
//        NSURL *url = [NSURL URLWithString: urlStr];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//        [request setHTTPMethod: @"GET"];
//        [request addValue: @"9ab01948f3e9cc3481077fe1d2d69fa3" forHTTPHeaderField: @"apikey"];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NSURLConnection sendAsynchronousRequest: request
//                                           queue: [NSOperationQueue mainQueue]
//                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//                                   if (error) {
//                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//                                   } else {
//                                      
//                                       NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                       NSDictionary *dict = [self dictionaryWithJsonString:responseString];
//                                       NSDictionary *dict1 = dict[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"];
//                                       completionHandler([Ticket parseJSON:dict1],error);
//                                   }
//                               }];
//    });
//   
//}

//+(void)requestPageno:(NSInteger )pageno CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
//{
//    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querylist";
//    NSString *httpArg = [NSString stringWithFormat:@"pageno=%@&pagesize=20",@(pageno)];
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue: @"9ab01948f3e9cc3481077fe1d2d69fa3" forHTTPHeaderField: @"apikey"];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            if (error) {
//                NSLog(@"httperror:%@",error.localizedDescription);
//            }else{
//                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                //把 productid 取出来 用到下面 的景点门票查询
//                NSDictionary *dict = [self dictionaryWithJsonString:responseString];
//                NSArray *tickListArray = dict[@"retData"][@"ticketList"];
//                NSArray *productid = [tickListArray valueForKey:@"productId"];
//                //                NSLog(@"productid:%@",productid);
//                completionHandler(productid,nil);
//                
//            }
//        }];
//        [task resume];
//        
//    });
//}
+(void)requestPageno:(NSInteger )pageno CompletionHandler:(void (^)(Ticket *, NSError *))completionHandler
{
    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querylist";
    NSString *httpArg = [NSString stringWithFormat:@"pageno=%@&pagesize=10",@(pageno)];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9ab01948f3e9cc3481077fe1d2d69fa3" forHTTPHeaderField: @"apikey"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"httperror:%@",error.localizedDescription);
            }else{
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //把 productid 取出来 用到下面 的景点门票查询
                NSDictionary *dict = [self dictionaryWithJsonString:responseString];
                NSArray *tickListArray = dict[@"retData"][@"ticketList"];
                NSArray *productid = [tickListArray valueForKey:@"productId"];
//                NSLog(@"productid:%@",productid);
                //通过 id 循环获取数据
                for(int i = 0; i <productid.count; i ++){
                   
                    NSString *httpUrl1 = @"http://apis.baidu.com/apistore/qunaerticket/querydetail";
                    NSString *httpArg1 = [NSString stringWithFormat:@"id=%@",productid[i]];
                    
                    NSString *urlStr1 = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl1, httpArg1];
                    NSURL *url1 = [NSURL URLWithString: urlStr1];
                    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc]initWithURL: url1 cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
                    [request1 setHTTPMethod: @"GET"];
                    [request1 addValue: @"9ab01948f3e9cc3481077fe1d2d69fa3" forHTTPHeaderField: @"apikey"];
                  
                        [NSURLConnection sendAsynchronousRequest: request1
                                                           queue: [NSOperationQueue mainQueue]
                                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                                   if (error) {
                                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                                   } else {
                                                       
                                                       NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                       NSDictionary *dict = [self dictionaryWithJsonString:responseString];
                                                       NSDictionary *dict1 = dict[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"];
                                                       completionHandler([Ticket parseJSON:dict1],error);
                                                   }
                                               }];

                }
          
            }
        }];
        [task resume];
        
    });
    
   
   
}


+(void)getScenicspotsPagesize:(NSInteger)pagesize CompletionHandler:(void (^)(TravelListDataModel *, NSError *))completionHandler
{
   
    NSString *httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString *httpArg = [NSString stringWithFormat:@"query=%%22%%22&page=%@",@(pagesize)];
   
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
   
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9ab01948f3e9cc3481077fe1d2d69fa3" forHTTPHeaderField: @"apikey"];
    
    NSURLSession *session = [NSURLSession sharedSession];

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
        NSDictionary *dict = [self dictionaryWithJsonString:responseString];
        NSDictionary *dict1 = dict[@"data"];
 
              completionHandler([TravelListDataModel parseJSON:dict1],error);

    }];
          [task resume];
    });

    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    
    }
 
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


@end
