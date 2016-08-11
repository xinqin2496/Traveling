//
//  TravelListModel.h
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TravelListDataModel,TravelListDataBooksModel;
@interface TravelListModel : NSObject

@property (nonatomic, assign) NSInteger errcode;

@property (nonatomic, assign) NSInteger ver;

@property (nonatomic, strong) TravelListDataModel *data;

@property (nonatomic, copy) NSString *errmsg;

@property (nonatomic, assign) BOOL ret;

@end
@interface TravelListDataModel : NSObject

@property (nonatomic, strong) NSArray<TravelListDataBooksModel *> *books;

@property (nonatomic, assign) NSInteger count;

@end

@interface TravelListDataBooksModel : NSObject

@property (nonatomic, copy) NSString *bookUrl;

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, assign) NSInteger bookImgNum;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, copy) NSString *userHeadImg;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL elite;

@property (nonatomic, assign) NSInteger routeDays;

@property (nonatomic, copy) NSString *startTime;

@end

